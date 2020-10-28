# Genome join operator

##### Description

The `genome join operator` joins two tables based on overlapping genomic intervals.

##### Usage

Input projection|.
---|---
`row1`           | character, chromosome name (left table) 
`row2`           | numeric, range start position (left table)
`row3`           | numeric, range end position (left table)
`column`        | character, document ID of the right table

Input parameters|.
---|---
`columns`        | comma-separated columns names representing `chromosome`, `start` and `end` in the right table.

Output relations|.
---|---
`variables`        | variables from the right table

##### Details

This operator is a wrapper of the `genome_join` function of the `fuzzyjoin` [R package](https://www.rdocumentation.org/packages/fuzzyjoin/versions/0.1.6/topics/genome_join).

##### See Also

[join_GFF_operator](https://github.com/tercen/join_GFF_operator)
, [read_vcf_operator](https://github.com/tercen/read_vcf_operator)

