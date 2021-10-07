return {
	lintCommand = "golangci-lint run --fast",
	lintIgnoreExitCode = true,
	lintFormats = { "%f:%l:%c: %m" },
}