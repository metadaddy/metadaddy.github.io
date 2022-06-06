#!/bin/bash

# Wherever GlassFish is installed
GLASSFISH=/Applications/NetBeans/glassfish-v2ur2

# Your GlassFish domain
GFDOMAIN=domain1

# The autodeploy directory - if the above two settings are correct you should
# not need to change this
AUTODEPLOY=$GLASSFISH/domains/$GFDOMAIN/autodeploy

# Wherever you're putting your OpenSSO/Fedlet configuration directories
# By default, your home directory
CONFIG=~

if [ -e $AUTODEPLOY/fedlet.war_deployed ]
then
    echo -n Undeploying the fedlet
    rm $AUTODEPLOY/fedlet.war
    until [ -e $AUTODEPLOY/fedlet.war_undeployed ]
    do
        echo -n .
        sleep 1
    done
    echo Done
fi

if [ -e $AUTODEPLOY/opensso.war_deployed ]
then
    echo -n Undeploying OpenSSO
    rm $AUTODEPLOY/opensso.war
    until [ -e $AUTODEPLOY/opensso.war_undeployed ]
    do
        echo -n .
        sleep 1
    done
    echo Done
fi

echo Stopping $GFDOMAIN.
$GLASSFISH/bin/asadmin stop-domain $GFDOMAIN

if [ -e $CONFIG/fedlet ]
then
    echo Removing Fedlet config directory
    rm -rf $CONFIG/fedlet
fi

if [ -e $CONFIG/opensso ]
then
    echo Removing OpenSSO config directory
    rm -rf $CONFIG/opensso
fi

$GLASSFISH/bin/asadmin start-domain $GFDOMAIN
