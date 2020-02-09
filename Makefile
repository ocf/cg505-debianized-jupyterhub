DEBIANZED_JUPYTERHUB_TAG := v1.0.0-1

.PHONY: pull
pull: clean
	mkdir -p debianized-jupyterhub
	wget -O repo.tar.gz https://github.com/1and1/debianized-jupyterhub/archive/${DEBIANZED_JUPYTERHUB_TAG}.tar.gz
	# Places the contents of the top-level extracted dir in the dir debianized-jupyterhub
	tar -xzf repo.tar.gz -C debianized-jupyterhub --strip-components 1

.PHONY: package_%
package_%: pull
	(cd debianized-jupyterhub && ./build.sh debian:$*)
	cp -r dist ../dist_$*

.PHONY: clean
clean:
	rm -rf dist_*
	rm -f repo.tar.gz
	rm -rf debianized-jupyterhub

.PHONY: test
test: ;
