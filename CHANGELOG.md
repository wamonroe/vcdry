## [1.1.1] - 2023-05-25

- Breakout `VCDry::Core` from `VCDry::DSL` to better support mixing in `keyword`
  behavior in other gems like `vcfb`.

## [1.0.1] - 2023-04-28

- Added initializer callbacks.
- Treat `default: nil` and `optional: true` identically.
- Fix for `other_keywords` to accept the optional type as intended.
- Fix for inheritance issues when including VCDry::DSL on a parent component.
- Fix to allow passing `nil` to an optional keyword.

## [1.0.0] - 2023-04-16

- Initial release
