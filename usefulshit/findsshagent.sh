echo "-----------------"
echo "Going to init ssh"

function sshagent_export_if_exists {
    SSH_AGENT=`find /tmp -uid $(id -u) -type s -name agent.\* 2>/dev/null`
    echo 'We go this agent :: ' $SSH_AGENT

    if [ $? ] ; then
        export SSH_AUTH_SOCK=$SSH_AGENT
        ssh-add -l
    fi
}

sshagent_export_if_exists

echo "Finished"
echo "-----------------"
