import DataTableDataTableMenuGeneral from './data-table-menu-general.js';
import DataTableDataTableMenuSelected from './data-table-menu-selected.js';
import { hash } from '@ember/helper';

/* Used in: data-table.hbs */
<template>
  {{#let
    (component DataTableDataTableMenuGeneral dataTable=@dataTable)
    (component DataTableDataTableMenuSelected dataTable=@dataTable)
    as |general selected|
  }}
    {{yield
      (hash
        General=general
        Selected=selected
        enableSelection=@dataTable.enableSelection
      )
    }}
  {{/let}}
</template>
