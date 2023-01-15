build_image:
	docker build -t sudohainguyen:latest .

run_img_local:
	docker run --rm -p 8080:80 sudohainguyen:latest
