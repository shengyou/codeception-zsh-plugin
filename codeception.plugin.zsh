# Codeception command completion

# Functions
_codeception_get_command_list () {
    vendor/bin/codecept \
    	| sed "1,/Available commands/d" \
    	| awk '/^  [a-z]+/ { print $1 }'
}

_codeception () {
    if [ -f vendor/bin/codecept ]; then
        compadd `_codeception_get_command_list`
    fi
}

# Functions

# Completion setup
compdef _codeception vendor/bin/codecept
compdef _codeception codecept

# Alias
alias codecept='vendor/bin/codecept'
