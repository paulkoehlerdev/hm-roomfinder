package frontend

import "embed"

//go:embed all:build
var FS embed.FS

const Subdir = "build"
