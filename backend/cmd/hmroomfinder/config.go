package main

import (
	"encoding/json"
	"fmt"
	"github.com/hashicorp/hcl/v2/hclsimple"
)

type config struct {
	Server         serverConfig         `hcl:"server,block"`
	Logger         loggerConfig         `hcl:"logger,block"`
	Database       databaseConfig       `hcl:"database,block"`
	SearchDatabase searchDatabaseConfig `hcl:"search_database,block"`
	Metrics        metricsConfig        `hcl:"metrics,block"`
}

func (c *config) String() string {
	bytes, err := json.Marshal(c)
	if err != nil {
		return err.Error()
	}

	return string(bytes)
}

type serverConfig struct {
	Bind string `hcl:"bind"`
}

type loggerConfig struct {
	LogLevel string            `hcl:"level"`
	Console  bool              `hcl:"console,optional"`
	File     []fileLoggerConfg `hcl:"file,block"`
}

type fileLoggerConfg struct {
	Path string `hcl:"path"`
}

type databaseConfig struct {
	Host     string `hcl:"host"`
	Port     string `hcl:"port"`
	Username string `hcl:"username"`
	Password string `hcl:"password"`
	Database string `hcl:"database"`
}

type searchDatabaseConfig struct {
	Host     string `hcl:"host"`
	Key      string `hcl:"key"`
	Index    string `hcl:"index"`
	ResLimit int64  `hcl:"res_limit"`
}

type metricsConfig struct {
	Bind string `hcl:"bind"`
}

func (d databaseConfig) ConnString() string {
	return fmt.Sprintf("postgres://%s:%s@%s:%s/%s", d.Username, d.Password, d.Host, d.Port, d.Database)
}

func loadConfig(path string) (*config, error) {
	var conf config
	err := hclsimple.DecodeFile(path, nil, &conf)
	if err != nil {
		return nil, fmt.Errorf("failed to load config file: %w", err)
	}

	return &conf, err
}
