import Component from '@glimmer/component';

export default class DataTableDataCellsComponent extends Component {
  get firstColumnField() {
    return this.args.fields?.[0] || null;
  }

  get otherColumnFields() {
    if (this.args.fields?.length) {
      let [, ...fields] = this.args.fields;
      return fields;
    } else {
      return [];
    }
  }
}

{{!-- Used in: data-table/row --}}
{{yield (hash
    firstColumnField=this.firstColumnField
    otherColumnFields=this.otherColumnFields
    item=@item
    rowLink=@rowLink
    rowLinkModel=@rowLinkModel
    rowClicked=@rowClicked
    fields=@fields
    DataCell=(component
    "data-table/data-cell"
      firstColumnField=this.firstColumnField
      otherColumnFields=this.otherColumnFields
      item=@item
      rowLink=@rowLink
      rowLinkModel=@rowLinkModel
      rowClicked=@rowClicked
      fields=@fields))}}
