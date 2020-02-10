DEBIANZED_JUPYTERHUB_TAG := c3a0e625c6393a1f85d221353c2cfcfc02a76912

.PHONY: pull
pull_%:
	mkdir -p debianized-jupyterhub-$*
	wget -O repo-$*.tar.gz https://github.com/1and1/debianized-jupyterhub/archive/${DEBIANZED_JUPYTERHUB_TAG}.tar.gz
	# Places the contents of the top-level extracted dir in the dir debianized-jupyterhub
	tar -xzf repo-$*.tar.gz -C debianized-jupyterhub-$* --strip-components 1

.PHONY: package_%
package_%: pull_%
	(cd debianized-jupyterhub-$* && ./build.sh debian:$*)
	cp -r debianized-jupyterhub-$*/dist dist_$*

.PHONY: clean
clean:
	rm -rf dist_*
	rm -f repo-*.tar.gz
	rm -rf debianized-jupyterhub-*

.PHONY: test
test: ;
