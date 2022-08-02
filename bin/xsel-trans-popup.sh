#!/usr/bin/bash

~/bin/popup.py \
	5000   \
	"`xsel |\
	  trans -indent 4 -show-prompt-message n -show-languages n -show-translation-phonetics n :ru |\
	  ansifilter -H | sed -e 's/#[0-9a-fA-F]\{6\}/white/g'`"
