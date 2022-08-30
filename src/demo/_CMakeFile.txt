
execute_process (
    COMMAND bash -c "env ; date +'%F %T' ;  ./run.sh ; "
    OUTPUT_VARIABLE outVar
)
