package frontend

import "embed"

//go:embed all:build/web
var FS embed.FS

const Subdir = "build/web"
