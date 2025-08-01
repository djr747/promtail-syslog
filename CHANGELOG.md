# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)

## [0.4.0] - 2025-07-31

### Added

- run container as non-root user

### Changed

- moved to using package manager to install `promtail` instead of downloading binary
- move to using `debian:bookworm-slim` as base image
- latest version of `promtail` will be installed
- `supervisord.conf` updated to remove `root` user
- replace label `appname` with `app_name` to match Loki's label naming convention
- removed `host` label in `promtail.yaml` to avoid duplication with `hostname`

## [0.3.0] - 2024-11-15

### Added

- install `promtail` for based off arch (`arm64`/`amd64`)
- `promtail` runs as non `root` user
- additional duplicate label for `hostname` (`host` kept for compatibility)
- additional label for `severity`
- additional label for `facility`
- additional lavel for `appname`

### Changed

- latest version of `promtail` will be installed
- `supervisord.conf` updated to surpress warning regarding running as `root`

### Deprecated

- `host` label will be removed in the future

## [0.2.0] - 2023-07-16

### Added

- `rsyslog-mmutf8fix` module
- `rsyslog-mmjsonparse` module

## [0.1.0] - 2023-06-18

Initial release of container to Docker hub