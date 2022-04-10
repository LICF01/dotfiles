
return {
	capabilities = default capabilities, with offsetEncoding utf-8
	cmd = { "clangd" }
    filetypes = { "c", "cpp", "objc", "objcpp" }
    offset_encoding = "utf-32"
    root_dir = root_pattern("compile_commands.json", "compile_flags.txt", ".git")
    single_file_support = true
}
