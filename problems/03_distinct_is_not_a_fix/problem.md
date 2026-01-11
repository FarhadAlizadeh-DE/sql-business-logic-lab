# Problem 03 — DISTINCT is not a fix

## Business question
How many **customers bought at least one product in category = 'Merch'**?

## The trap
When joins produce duplicate rows, many people add DISTINCT to the final SELECT.
This hides duplication symptoms without fixing the underlying join grain.

DISTINCT may return the correct number *by accident* — but the query logic remains wrong
and will break as soon as requirements change.

## Goal
Solve the problem by fixing the join logic or aggregation grain,
not by masking duplicates with DISTINCT.

## Why `wrong.sql` is wrong
DISTINCT hides duplicate rows caused by item-level joins.
The result may be correct today, but the logic is fragile and can break as soon as requirements change.

## Rule of thumb
If you feel the need to add DISTINCT to fix duplication, you are probably aggregating at the wrong grain.
