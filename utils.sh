# Designed to be sourced by other scripts, doesn't actually do anything

USER_HOME=$(getent passwd ${SUDO_USER:-$USER} | cut -d: -f6)
USER=${SUDO_USER:-$USER}

SCRIPT_DIR=$(dirname $(realpath $0))

install_package () {
    status=$(dpkg-query -Wf'${db:Status-abbrev}' $1 2>/dev/null)
    if [[ $status == "ii " ]]; then
        echo "$1 already installed"
    else
    # Network glitches are a pain on a large install, so
    # give each install 3 chances
        for attempt in {1..3}
        do
           apt --yes install $1
           if [ "$?" -eq 0 ]; then
               break
           fi
        done
    fi
    
    # Even more of a pain is carrying on with the build
    # when we know a dependency is missing!
    if [ "$?" -ne 0 ]; then
        echo failed to get package: error $?
        exit $? 
    fi
}
