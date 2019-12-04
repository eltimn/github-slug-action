#!/usr/bin/env bats

@test "Short long hash with default length 8" {
  test_short_sha \
    "a35a1a486a260cfd99c5b6f8c6034a2929ba9b3f" \
    "a35a1a48"
}

@test "Short long hash with length 7" {
  test_short_sha \
    "a35a1a486a260cfd99c5b6f8c6034a2929ba9b3f" \
    "a35a1a4" \
    "7"
}

# Load short_sha function
source entrypoint.sh > /dev/null 2>&1

test_short_sha(){
  given="${1}"
  expected="${2}"

  if [ "$#" == 3 ]; then
    export INPUT_SHORT_SHA_LENGTH=$3
  fi

  actual="$(short_sha ${given})"
  echo "expected : [${expected}], actual : [${actual}]"
  [ "${actual}" == "${expected}" ]
}