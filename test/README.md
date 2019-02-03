# conf Test

## How to test conf?

It's quite simple, in REPL:

```lisp
(asdf:test-system :conf)
```

If "T" is returned in Test result because it passed, if "nil" is returned because it failed.