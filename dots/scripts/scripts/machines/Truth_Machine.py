#!/usr/bin/env python3

import random
import secrets

q = input("Question: ")

choice = 0
val = 0
arrPossible = []

print("Calculating Probability, Please wait...")
for x in range(99937324):
    val = random.randint(0, 10000)
    if val == 24:
        arrPossible.append(24)
    if val == 373 or val == 373 * 2:
        arrPossible.append(373)
    if val == 999 or val == 999 * 2:
        arrPossible.append(999)

choice = secrets.choice(arrPossible)

print("Computation Complete\n")
if choice == 373 or choice == 999:
    print(f"You are encouraged to pursue this endeavour.\nGood Results are likely.")
elif choice == 24:
    print(f"It is highly recommended that you pursue this endeavour!")
elif choice == 373 * 2 or choice == 999 * 2:
    print(
        f"Pursuing this endeavour has a very low success rate. Pursuing is not recommended"
    )
