---
title: Using Rust In CI/CD with Codeship Basic
shortTitle: Rust
tags:
- rust
- cargo
- languages
menus:
  basic/languages:
    title: Rust
    weight: 9
categories:
  - Languages And Frameworks  
  - Configuration
---

* include a table of contents
{:toc}

## Versions And Setup

[Rust](https://www.rust-lang.org/en-US) is not installed on the build VMs by default, but it can be easily added with a script.

To install the latest Rust version add [this command](https://github.com/codeship/scripts/blob/master/languages/rust.sh#L6) to your _Setup Commands_ and the script will automatically be called at build time.

Rust is installed via [rustup](https://github.com/rust-lang-nursery/rustup.rs) so after install `rustc`, `cargo` and `rustup` are all available in the environment.

## Dependencies

After installing Rust, fetching dependencies via Cargo should work as normal in your [setup commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}).


### Dependency Cache

We do not cache Rust dependencies between builds.

## Frameworks And Testing

Frameworks such as Iron and testing via the standard Rust test attribute or via testing tools like Stainless are supported, but must be manually configured.

## Parallel Testing

If you are running [parallel test pipelines]({{ site.baseurl }}{% link _basic/builds-and-configuration/parallel-tests.md %}), you will want separate your tests into groups and call a group specifically in each pipeline. For instance:

**Pipeline 1:**
```shell
cargo test --test tests_1
```

**Pipeline 2:**
```shell
cargo test --test tests_1
```

### Parallelization Modules

Rust tests can be parallelized via our [ParallelCI]({{ site.baseurl }}{% link _basic/builds-and-configuration/parallel-tests.md %}) feature by manually specifying different test specs per pipeline.

## Notes And Known Issues

As mentioned above, as Rust is not preinstalled you will need to manually install Rust and necessary dependencies yourself in your [setup commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}).
