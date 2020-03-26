# Reproducer

This is a reproducer for `shfmt` issue https://github.com/mvdan/sh/issues/530.

## Observed platforms

shfmt version: 3.0.2

The issue appears on:

- Mac (`shfmt` from Brew)
- Alpine (`shfmt` from `apk add`)

## Reproduce with Docker

To run the reproducer on Alpine with Docker:

```bash
docker build --rm -t repro .
docker run --rm -it repro
```

## Workaround

:bulb: Remove `keep_padding` from `.editorconfig`.

## Results

```
$ ./test
[RUN] shfmt -version
v3.0.2

[INFO] One filepath with printer options is OK.
[RUN] shfmt -d -i 4 scripts/1
[RUN] shfmt -d -i 4 scripts/2
[RUN] shfmt -l -i 4 scripts/2

[INFO] One filepath without printer options is OK.
[RUN] shfmt -d scripts/1
[RUN] shfmt -d scripts/2
[RUN] shfmt -l scripts/2

[INFO] Two filepaths with printer options is OK.
[RUN] shfmt -d -i 4 scripts/1 scripts/2
[RUN] shfmt -d -ci scripts/1 scripts/2
[RUN] shfmt -l -ci scripts/1 scripts/2

[INFO] Two filepaths WITHOUT printer options is PANIC.
[RUN] shfmt -d scripts/1 scripts/2
panic: interface conversion: syntax.bufWriter is *syntax.colCounter, not *bufio.Writer

goroutine 1 [running]:
mvdan.cc/sh/v3/syntax.KeepPadding.func1(0xc0000d0000)
	/private/tmp/shfmt-20200223-13327-c96be6/sh-3.0.2/syntax/printer.go:58 +0xac
main.propsOptions(0x0, 0x0, 0xc0000d8800, 0xb, 0x10)
	/private/tmp/shfmt-20200223-13327-c96be6/sh-3.0.2/cmd/shfmt/main.go:257 +0x320
main.formatBytes(0xc0000d4000, 0x34, 0x600, 0x7ffeefbff9f3, 0x9, 0x8000, 0x8000)
	/private/tmp/shfmt-20200223-13327-c96be6/sh-3.0.2/cmd/shfmt/main.go:294 +0x74f
main.formatPath(0x7ffeefbff9f3, 0x9, 0x11dc000, 0x0, 0x0)
	/private/tmp/shfmt-20200223-13327-c96be6/sh-3.0.2/cmd/shfmt/main.go:285 +0x2a8
main.walk(0x7ffeefbff9f3, 0x9, 0xc0000b1f18)
	/private/tmp/shfmt-20200223-13327-c96be6/sh-3.0.2/cmd/shfmt/main.go:205 +0x84
main.main1(0xc000070058)
	/private/tmp/shfmt-20200223-13327-c96be6/sh-3.0.2/cmd/shfmt/main.go:173 +0x2fb
main.main()
	/private/tmp/shfmt-20200223-13327-c96be6/sh-3.0.2/cmd/shfmt/main.go:63 +0x22

[ERROR] exit status 2: shfmt -d scripts/1 scripts/2


[RUN] shfmt -l scripts/1 scripts/2
panic: interface conversion: syntax.bufWriter is *syntax.colCounter, not *bufio.Writer

goroutine 1 [running]:
mvdan.cc/sh/v3/syntax.KeepPadding.func1(0xc0000d0000)
	/private/tmp/shfmt-20200223-13327-c96be6/sh-3.0.2/syntax/printer.go:58 +0xac
main.propsOptions(0x0, 0x0, 0xc0000d8800, 0xb, 0x10)
	/private/tmp/shfmt-20200223-13327-c96be6/sh-3.0.2/cmd/shfmt/main.go:257 +0x320
main.formatBytes(0xc0000d4000, 0x34, 0x600, 0x7ffeefbff9f3, 0x9, 0x8000, 0x8000)
	/private/tmp/shfmt-20200223-13327-c96be6/sh-3.0.2/cmd/shfmt/main.go:294 +0x74f
main.formatPath(0x7ffeefbff9f3, 0x9, 0x11dc000, 0x0, 0x0)
	/private/tmp/shfmt-20200223-13327-c96be6/sh-3.0.2/cmd/shfmt/main.go:285 +0x2a8
main.walk(0x7ffeefbff9f3, 0x9, 0xc0000b1f18)
	/private/tmp/shfmt-20200223-13327-c96be6/sh-3.0.2/cmd/shfmt/main.go:205 +0x84
main.main1(0xc000070058)
	/private/tmp/shfmt-20200223-13327-c96be6/sh-3.0.2/cmd/shfmt/main.go:173 +0x2fb
main.main()
	/private/tmp/shfmt-20200223-13327-c96be6/sh-3.0.2/cmd/shfmt/main.go:63 +0x22

[ERROR] exit status 2: shfmt -l scripts/1 scripts/2
```
