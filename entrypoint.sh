#!/bin/sh -l

INPUT_SHORT_SHA_LENGTH=${INPUT_SHORT_SHA_LENGTH:-8}

slug_ref() {
    echo "$1" \
         | tr "[:upper:]" "[:lower:]" \
         | sed -r 's#refs/[^\/]*/##;s/[~\^]+//g;s/[^a-zA-Z0-9]+/-/g;s/^-+\|-+$//g;s/^-*//;s/-*$//' \
         | cut -c1-63
}

short_sha(){
  echo "$1" \
        | cut -c1-${INPUT_SHORT_SHA_LENGTH}
}

echo ::set-env name=GITHUB_REF_SLUG::"$(slug_ref "$GITHUB_REF")"
echo ::set-env name=GITHUB_HEAD_REF_SLUG::"$(slug_ref "$GITHUB_HEAD_REF")"
echo ::set-env name=GITHUB_BASE_REF_SLUG::"$(slug_ref "$GITHUB_BASE_REF")"
echo ::set-env name=GITHUB_SHA_SHORT::"$(short_sha "$GITHUB_SHA")"
