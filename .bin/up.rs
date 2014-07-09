use std::os;

fn main() {
	let path = Path::new(os::args().get(1).as_slice());
	let mut cwd = Path::new("");
	while cwd != Path::new("/") {
		cwd = os::getcwd();
		if path.exists() {
			println!("{}", cwd.display());
			return;
		} else {
			os::change_dir(&Path::new(".."));
		}
	}

	os::set_exit_status(1);
}
