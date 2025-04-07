nextflow.enable.dsl=2

workflow {
    check_java()
    check_python()
    check_env_vars()
}

process check_java {
    label 'debug'
    """
    echo ">>> JAVA VERSION"
    java -version
    echo
    echo "JAVA_HOME: \$JAVA_HOME"
    echo "PATH: \$PATH"
    """
}

process check_python {
    label 'debug'
    """
    echo ">>> PYTHON VERSION"
    python3 --version || which python3
    echo
    echo ">>> PIP VERSION"
    pip --version || which pip
    """
}

process check_env_vars {
    label 'debug'
    """
    echo ">>> ENVIRONMENT VARIABLES"
    env | grep -E 'JAVA|PYTHON|PATH|SDKMAN' | sort
    """
}
