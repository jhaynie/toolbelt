all:
	@docker build . --platform linux/x86_64 -t jhaynie/toolbelt:x86_64

push:
	@docker push jhaynie/toolbelt:x86_64