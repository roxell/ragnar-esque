# Ragnar Bisection

## Design

### Build

- Rebuild kernel (use build-kernel)
- Insert kernel into existing OE build output

Parameters:
- Kernel git url
- Machine

### Bisection

- LAVA for running tests

Parameters - Everything from 'Build', plus:
- good commit
- bad commit
- lava test case (in some format TBD)
