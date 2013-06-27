fn main() {
	let path = copy os::args()[1];
	let mut cwd = Path("");
	while cwd != Path("/") {
		cwd = os::getcwd();
		if Path(path).exists() {
			io::println(cwd.to_str());
			return;
		} else {
			os::change_dir(&Path(".."));
		}
	}

	os::set_exit_status(1);
}
