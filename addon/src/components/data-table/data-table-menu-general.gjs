import { hash } from '@ember/helper';

hash();
/* Used in: data-table/data-table-menu */
<template>
  {{yield
    (hash dataTable=@dataTable selectionIsEmpty=@dataTable.selectionIsEmpty)
  }}
</template>
