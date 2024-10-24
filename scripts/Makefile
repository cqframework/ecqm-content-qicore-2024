.PHONY: lint
lint:
	poetry run mypy --config-file mypy.ini .

.PHONY: fmt
fmt: # Formats the code in the src/ and test/ directories using black.
	poetry run isort .
	poetry run black .

.PHONY: typecheck
typecheck: # Performs type checking in the src/ and test/ directories using mypy.
	PYTHONPATH=./ poetry run mypy --config-file mypy.ini .
