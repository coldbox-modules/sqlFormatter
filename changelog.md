# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

----

## [v1.1.3] - 2022-MAY-04

### Changed

* Switched BACK to S3 storage, since `forgeboxStorage` is still broken

## [v1.1.2] - 2022-MAY-04

### Changed

* Switched back to `forgeboxStorage` since Forgebox resolved the package storage issue

## [v1.1.1] - 2022-MAY-02

### Changed

* Switched to S3 storage to avoid a Forgebox storage issue

## [v1.1.0] - 2022-APR-27

### Changed

* Embeds the `sql-formatter` jar to avoid downloading from Maven on install

## [v1.0.3] - 2022-APR-21

### Added

* 📦 NEW: Add `formatter.withParams()` for parameter replacement

## [v1.0.2] - 2022-APR-21

### Added

* 📦 NEW: Add `ConfigBuilder` for custom formatting configuration

## [v1.0.1] - 2022-APR-18

### Added

* 👌 IMPROVE: Add BSD-3 license
* 📖 DOC: Clean up README and API docs

## [v1.0.0] - 2022-APR-18

* 📦 Initial version!