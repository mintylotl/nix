#!/usr/bin/env python3

import random
import secrets

heads = input("Choice 1 (Heads): ")
tails = input("Choice 2 (Tails): ")

val = 0.0
perc = 0
arrPossible = []

print("Choosing, Please wait...")
for x in range(99937324):
    val = random.uniform(0, 1)

if val < 0.5:
    perc = val / 0.5 * 100
else:
    perc = val * 100

print("Computation Complete\n")
print(f"With a certainty of {perc}%, You should: ")

if val < 0.5:
    print(heads)
else:
    print(tails)
