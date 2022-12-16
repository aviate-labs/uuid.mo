.PHONY: check test
check:
	find src -type f -name '*.mo' -print0 | xargs -0 $(shell vessel bin)/moc $(shell vessel sources 2>/dev/null) --check
