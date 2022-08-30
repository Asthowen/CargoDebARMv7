<!--suppress HtmlDeprecatedAttribute -->
<h1 align="center">
  CargoDebARMv7
</h1>
<h3 align="center">
    <strong>Action for creating .deb package for Rust projects using cargo-deb for ARMv7.</strong>
</h3>

> This repository is a simple fork of [cargo-deb-armv7-debian](https://github.com/ebbflow-io/cargo-deb-armv7-debian/).

Provides a build environment for executing `cargo-deb` [1] and producing statically linked binaries for the built Debian (`.deb`) package.

This build on a `debian:buster` base image and targets `armv7-unknown-linux-musleabihf`. The `musl` installation is possible thanks to the cross project [2].

The interface for this package was inspired/copied from the cargo-static-build [3] action.

[1] Cargo Deb provided by mmstick
- https://github.com/mmstick/cargo-deb
- https://crates.io/crates/cargo-deb

[2] MUSL environment made possible thanks to `cross` dual-licensed under [Apache 2.0](https://github.com/rust-embedded/cross/blob/master/LICENSE-APACHE) or [MIT](https://github.com/rust-embedded/cross/blob/master/LICENSE-MIT)
- https://github.com/rust-embedded/cross

[3] https://github.com/zhxiaogg/cargo-static-build

**NOTE**: This package may fail to build your project if your build links against other OS-provided libraries. Feel free to open a pull-request to modify the `Dockerfile` so your project can build.

## Inputs

`cmd` - The command to be executed inside the container. Defaults to `cargo deb --target=armv7-unknown-linux-musleabihf`

## Outputs

None, besides the `deb` package that is built. The built `.deb` will be located in `target/armv7-unknown-linux-musleabih/debian/<DEB>`.

## Example Usage

```yaml
name: Build deb package

on:
  push:
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2
      - name: Build .deb
        uses: asthowen/CargoDebARMv7@main
```