all:
	@docker build . --platform linux/x86_64 -t jhaynie/toolbet:x86_64

push:
	@docker push jhaynie/toolbet:x86_64