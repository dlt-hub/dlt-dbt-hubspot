from typing import TypedDict, Sequence


class TableReference(TypedDict, total=False):
    columns: Sequence[str]
    referenced_table: str
    referenced_columns: Sequence[str]
