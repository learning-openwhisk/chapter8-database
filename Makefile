include _config.mk

all: 
	echo TODO

bind: bind.done

bind.done: 
	wsk package bind /whisk.system/cloudant demodb \
	-p username "$(CLOUDANT_USER)" \
    -p password "$(CLOUDANT_PASS)" \
    -p host "$(CLOUDANT_USER).cloudant.com" \
    -p dbname demodb
	wsk action invoke demodb/create-database -r
	touch bind.done

unbind: 
	-wsk action invoke demodb/delete-database -r
	wsk package delete demodb
	rm bind.done

import.done:
	bash import.sh
	touch import.done

clean:
	wsk action invoke demodb/delete-database -r
	wsk action invoke demodb/create-database -r
	rm import.done

.PHONY: bind unbind 
