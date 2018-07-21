mkdir $env:userprofile\go

@(
  "github.com/nsf/gocode"
, "golang.org/x/tools/cmd/godoc"
, "github.com/urfave/cli"
, "github.com/nsf/termbox-go"
, "github.com/mattn/go-colorable"
, "github.com/julienroland/keyboard-termbox"
, "github.com/goreleaser/goreleaser"
, "github.com/loadoff/excl"
, "github.com/mholt/archiver/cmd/archiver"
, "github.com/otiai10/copy"
, "github.com/tealeg/xlsx"
, "golang.org/x/oauth2"
, "golang.org/x/oauth2/google"
, "google.golang.org/api/gmail/v1"
) | % { go get $_ }
