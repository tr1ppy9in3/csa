
### gcc -std=c17  -O2 -o ../bin/bench main.c
run 1: 0.001850 s, sum 67107067
run 2: 0.002099 s, sum 67107067
run 3: 0.001846 s, sum 67107067
run 4: 0.001823 s, sum 67107067
run 5: 0.001904 s, sum 67107067
median 0.001850 s, min 0.001823, max 0.002099, ns/element 0.44

### gcc -std=c17 -O2 -march=x86-64-v3 -o ../bin/bench-v3 main.c
run 1: 0.001672 s, sum 67107067
run 2: 0.001755 s, sum 67107067
run 3: 0.001717 s, sum 67107067
run 4: 0.001794 s, sum 67107067
run 5: 0.001665 s, sum 67107067
median 0.001717 s, min 0.001665, max 0.001794, ns/element 0.41