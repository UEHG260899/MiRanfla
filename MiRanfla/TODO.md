
## TODOS

### General

1. Play around with NavStack using path

### AddGasLogView

1. When adding a new gaslog since the model for the form is a struct, each time we re enter the screen, the same id is being created for the log.
   find a way to refresh it each time we enter the screen.

### CarAdapter

1. Find a way to not send default parameters in the init
2. Separate gas log handling logic to another adapter

### CarInfoView

1. See if we can just refresh onAppear instead of passing the data from the init.

### GasLogCellView

1. Fix date localization.
