package main

import (
	"fmt"
	"github.com/hashicorp/hcl/v2/hclsimple"
	"log/slog"
	"strings"
)

type config struct {
	Server   serverConfig    `hcl:"server,block"`
	Logger   loggerConfig    `hcl:"logger,block"`
	Frontend *frontendConfig `hcl:"frontend,block"`
}

type serverConfig struct {
	Bind string `hcl:"bind"`
}

type frontendConfig struct {
	ProxyUrl *string `hcl:"proxy_url,optional"`
}

type loggerConfig struct {
	LogLevel string `hcl:"level"`
}

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

func loadConfig(path string) (config, error) {
	var conf config
	err := hclsimple.DecodeFile(path, nil, &conf)
	if err != nil {
		return conf, fmt.Errorf("failed to load config file: %w", err)
	}

	return conf, err
}
