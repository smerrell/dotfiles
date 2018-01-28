function op_signin
	set cmd (op signin $argv | sed '/#/d; s/export/set -gx/; s/=/ /; s/"//g')
eval $cmd
end
