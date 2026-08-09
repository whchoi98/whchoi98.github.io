#!/bin/bash
# Tests for secret-scan.sh detection patterns.
# True positives MUST match; false positives must NOT match.
# Sensitive-looking tokens are constructed at runtime via string concatenation
# to avoid triggering GitHub Push Protection.

# --- True positive tests ---
assert_grep_match "TP: AWS Access Key ID" 'AKIA[0-9A-Z]{16}' "AKIAIOSFODNN7EXAMPLE"

GH_PREFIX="ghp_"
GH_BODY="AbCdEfGhIjKlMnOpQrStUvWxYz0123456789"
assert_grep_match "TP: GitHub PAT" 'ghp_[A-Za-z0-9]{36}' "${GH_PREFIX}${GH_BODY}"

SLACK_PREFIX="xoxb-"
SLACK_BODY="123456789012-1234567890123-abcdef"
assert_grep_match "TP: Slack Bot Token" 'xoxb-[0-9]+-[A-Za-z0-9]+' "${SLACK_PREFIX}${SLACK_BODY}"

ANT_PREFIX="sk-ant-"
ANT_BODY=$(printf 'a%.0s' $(seq 1 95))
assert_grep_match "TP: Anthropic API Key" 'sk-ant-[A-Za-z0-9-]{90,}' "${ANT_PREFIX}${ANT_BODY}"

STRIPE_PREFIX="sk_live_"
STRIPE_BODY="4eC39HqLyjWDarjtT1zdp7dc"
assert_grep_match "TP: Stripe Secret Key" 'sk_live_[A-Za-z0-9]{24,}' "${STRIPE_PREFIX}${STRIPE_BODY}"

GOOG_PREFIX="AIza"
GOOG_BODY="SyA1234567890abcdefghijklmnopqrstuv"
assert_grep_match "TP: Google API Key" 'AIza[A-Za-z0-9_-]{35}' "${GOOG_PREFIX}${GOOG_BODY}"

assert_grep_match "TP: Password assignment" 'password\s*[:=]\s*["\x27][^"\x27]{8,}' 'password = "hunter2hunter2"'

# --- False positive tests ---
assert_grep_no_match "FP: Normal base64" 'AKIA[0-9A-Z]{16}' "dGhpcyBpcyBhIHRlc3Q="
assert_grep_no_match "FP: AKIA prefix too short" 'AKIA[0-9A-Z]{16}' "AKIA123"
assert_grep_no_match "FP: Empty password" 'password\s*[:=]\s*["\x27][^"\x27]{8,}' 'password = ""'
assert_grep_no_match "FP: Short password placeholder" 'password\s*[:=]\s*["\x27][^"\x27]{8,}' 'password = "xxx"'
assert_grep_no_match "FP: Slack doc mention" 'xoxb-[0-9]+-[A-Za-z0-9]+' "the token format is xoxb-NUMBER"

# --- Fixture files ---
assert_file_exists "fixture: secret-samples.txt" "tests/fixtures/secret-samples.txt"
assert_file_exists "fixture: false-positives.txt" "tests/fixtures/false-positives.txt"

# Every pattern-relevant line in false-positives.txt must not trigger the AWS key pattern
FP_CONTENT=$(cat tests/fixtures/false-positives.txt)
assert_grep_no_match "FP fixture: no AWS key matches" 'AKIA[0-9A-Z]{16}' "$FP_CONTENT"
