return {
	cmd = { "ccls" }
    filetypes = { "c", "cpp", "objc", "objcpp" }
    offset_encoding = "utf-32"
    root_dir = root_pattern("compile_commands.json", ".ccls", ".git")
    single_file_support = false
}
