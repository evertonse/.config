
PROJECT := evertonsantos_202100011379_opencl

install: $(shell ls ./.config/)
	python3 ./install -y

clean:
	rm -rf *.bin

push: 
	 git add . && git commit -m "$$(date)" && git push

pull:
	git pull

