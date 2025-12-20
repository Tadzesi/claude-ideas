# Test Suite for Claude Commands Library

This directory contains automated tests for validating the library system and ensuring all commands follow v2.0 standards.

## Available Tests

### `validate-library-references.ps1`

**Purpose:** Validates that all commands properly reference the unified library system and follow v2.0 conventions.

**What it tests:**
1. Core library file exists
2. All adapter files exist (technical, article, session, hybrid)
3. Commands have library references
4. Commands have version history with v2.0 entries
5. Commands have Library Integration sections
6. Commands reference appropriate adapters

**Usage:**

```powershell
# Run from project root
.\tests\validate-library-references.ps1

# Run with verbose output
.\tests\validate-library-references.ps1 -Verbose

# Run from custom path
.\tests\validate-library-references.ps1 -CommandsPath "C:\path\to\.claude\commands" -LibraryPath "C:\path\to\.claude\library"
```

**Output:**

```
===============================================
Library Reference Validation Test Suite v1.0
===============================================

[Test Suite 1: Core Library Files]
-----------------------------------
[PASS] Core library (prompt-perfection-core.md) exists

[Test Suite 2: Adapter Files]
------------------------------
[PASS] Adapter exists: technical-adapter.md
[PASS] Adapter exists: article-adapter.md
[PASS] Adapter exists: session-adapter.md
[PASS] Adapter exists: hybrid-adapter.md (v2.0)

[Test Suite 3: Command Library References]
------------------------------------------
[PASS] prompt - Has library reference
[PASS] prompt-hybrid - Has library reference
[PASS] prompt-technical - Has library reference
...

[Test Suite 4: Version History]
--------------------------------
[PASS] prompt - Has v2.0 version history
[PASS] prompt-hybrid - Has v2.0 version history
...

[Test Suite 5: Library Integration Sections]
---------------------------------------------
[PASS] prompt - Has Library Integration section
...

[Test Suite 6: Adapter References in Commands]
-----------------------------------------------
[PASS] prompt-technical references technical-adapter.md
[PASS] prompt-hybrid references hybrid-adapter.md
...

===============================================
Test Results Summary
===============================================

Total Tests:  32
Passed:       30
Failed:       0
Warnings:     2

Success Rate: 93.75%

RESULT: PASSED - All tests passed!
```

**Exit Codes:**
- `0` - All tests passed or only minor warnings
- `1` - One or more tests failed

**Integration with CI/CD:**

```yaml
# Example GitHub Actions workflow
name: Validate Library References

on: [push, pull_request]

jobs:
  test:
    runs-on: windows-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run library validation
        shell: pwsh
        run: .\tests\validate-library-references.ps1
```

## Running All Tests

```powershell
# Run all tests from project root
Get-ChildItem .\tests\*.ps1 | ForEach-Object { & $_.FullName }
```

## Test Development Guidelines

When adding new tests:

1. **Use descriptive test names**
   - Good: `Test-CommandHasLibraryReference`
   - Bad: `Test1`

2. **Provide clear output**
   - Use color coding (Green=Pass, Red=Fail, Yellow=Warn)
   - Include helpful error messages
   - Show file paths for failed tests

3. **Support verbose mode**
   - Add `-Verbose` parameter
   - Show additional details when enabled
   - Keep standard output concise

4. **Handle edge cases**
   - Missing files
   - Malformed content
   - Different file encodings
   - Different line endings

5. **Document your tests**
   - Add comments explaining complex logic
   - Update this README
   - Include usage examples

## Future Test Additions

Potential tests to add:

1. **Content Validation:**
   - Verify adapter imports are valid
   - Check for broken internal links
   - Validate markdown syntax

2. **Configuration Tests:**
   - Verify JSON config files are valid
   - Check required config keys exist
   - Validate threshold values

3. **Documentation Tests:**
   - Check all commands have examples
   - Verify documentation links work
   - Ensure consistent formatting

4. **Integration Tests:**
   - Test commands execute without errors
   - Verify Phase 0 flow works
   - Check agent spawning (if configured)

5. **Performance Tests:**
   - Measure command execution time
   - Check cache effectiveness
   - Monitor memory usage

## Contributing

When adding tests:

1. Create new test file: `tests/test-name.ps1`
2. Follow existing test patterns
3. Update this README
4. Run all tests to ensure no regressions
5. Document any new dependencies

## Support

For issues with tests:
- Check test output for specific failures
- Run with `-Verbose` for detailed information
- Verify file paths are correct
- Ensure you're running from project root

For questions or suggestions:
- Open an issue in the repository
- Reference specific test file and failure
- Include full error output
