# Codeception command completion

# Functions
_codeception_get_command_list () {
    vendor/bin/codecept \
    	| sed "1,/Available commands/d" \
    	| awk '/^  [a-z]+/ { print $1 }'
}

_codeception () {
  local curcontext="$curcontext" state line
  typeset -A opt_args

  _arguments \
    '1: :->commands'\
    '2: :->args'\
    '*: :->opts'

  if [ -f vendor/bin/codecept ]; then
    case $state in
      	commands)
        	compadd `_codeception_get_command_list`
        	;;
        args)
			case $words[2] in
				generate:cept|generate:cest|generate:pageobject|generate:phpunit|generate:scenarios|generate:stepobject|generate:suite|generate:test)
					compadd functional acceptance unit
					;;
			esac
			;;
      	*)
			compadd `vendor/bin/codecept $words[2] -h --no-ansi | sed "1,/Options:/d" | sed '/^$/d' | awk '{ print $1 }'`
			;;
    esac
  fi
}

# Completion setup
compdef _codeception vendor/bin/codecept
compdef _codeception codecept

# Alias
alias codecept='vendor/bin/codecept'
