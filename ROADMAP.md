# Roadmap

Possible future work. No timelines, no commitments. Listed because they came up while building current commands.

## Things that would justify a v5.x release

- **Benchmark `/prompt-research`.** Pick 3 representative codebases (small library, medium app, large monorepo). Measure: time-to-first-useful-finding, total tokens consumed, agent iteration count. Publish methodology and numbers in `tests/benchmarks/`.
- **Consolidate `/prompt` Phase 0 into a single, testable function.** Currently distributed across multiple library files. Goal: one canonical implementation with input/output examples that can be regression-tested.

## Things that might not happen

- ML-based context prediction
- Visual prompt builder
- Voice input
- Team collaboration features

These were aspirational. Listed so future-me doesn't re-discover them.
