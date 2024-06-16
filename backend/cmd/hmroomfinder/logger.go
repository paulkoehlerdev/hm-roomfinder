package main

import (
	"io"
	"log/slog"
	"os"
	"strings"
)

func (l *loggerConfig) Level() slog.Level {
	switch strings.ToLower(l.LogLevel) {
	case "debug":
		return slog.LevelDebug
	case "info":
		return slog.LevelInfo
	case "warn":
		return slog.LevelWarn
	case "error":
		return slog.LevelError
	default:
		return slog.LevelInfo
	}
}

func createLogger(stdout io.Writer, config loggerConfig) func() (logger *slog.Logger, shutdown func()) {
	return func() (logger *slog.Logger, shutdown func()) {
		var writer []io.Writer
		var files []*os.File
		var errors []error

		if config.Console {
			writer = append(writer, stdout)
		}

		for _, file := range config.File {
			f, err := os.OpenFile(file.Path, os.O_APPEND|os.O_CREATE, 0666)
			if err != nil {
				errors = append(errors, err)
				continue
			}

			files = append(files, f)
			writer = append(writer, f)
		}

		logger = slog.New(slog.NewTextHandler(
			io.MultiWriter(writer...),
			&slog.HandlerOptions{
				AddSource: true,
				Level:     &config,
			},
		))

		for _, err := range errors {
			logger.Error("error while loading log file", "error", err)
		}

		return logger, func() {
			for _, file := range files {
				err := file.Close()
				if err != nil {
					logger.Error("Error while closing log file", "error", err)
				}
			}
		}
	}
}
