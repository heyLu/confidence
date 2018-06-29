#![feature(rust_2018_preview)]

use std::env;
use std::path::PathBuf;
use std::process;

// Checks if it can find a directory (or file) up the directory tree.
//
// Can be used to check if you're in a vcs-versioned directory, like git, mercurial or svn.
//
// usage: up .git
//        up .git <path-to-directory>
fn main() {
    let repo_dir_name = &env::args().nth(1).expect("missing argument");
    let mut path = env::args()
        .nth(2)
        .map(PathBuf::from)
        .ok_or(0)
        .or_else(|_| env::current_dir())
        .unwrap();
    while path.parent().is_some() {
        if path.join(repo_dir_name).exists() {
            println!("{}", path.canonicalize().unwrap().display());
            return;
        }
        path = path.parent().unwrap().to_path_buf();
    }
    process::exit(1);
}
