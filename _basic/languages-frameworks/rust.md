---
title: Rust
tags:
- rust
- cargo
- languages
category: Languages &amp; Frameworks
---
[Rust](https://www.rust-lang.org/en-US) is not installed on the build VMs by default, but it can be easily added with a script.

To install the latest Rust version add [this command](https://github.com/codeship/scripts/blob/master/languages/rust.sh#L6) to your _Setup Commands_ and the script will automatically be called at build time.

Rust is installed via [rustup](https://github.com/rust-lang-nursery/rustup.rs) so after install `rustc`, `cargo` and `rustup` are all available in the environment.
