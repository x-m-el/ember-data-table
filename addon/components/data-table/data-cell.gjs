{{!-- Used in: data-table/data-cells --}}
{{yield (hash
    firstColumnField=@firstColumnField
    otherColumnFields=@otherColumnFields
    item=@item
    rowLink=@rowLink
    rowLinkModel=@rowLinkModel
    rowClicked=@rowClicked
    label=@column.label
    fields=@fields
    isCustom=this.isCustom
    hasCustomFields=this.hasCustomFields
    attribute=@column.attribute
    renderCustomBlock=this.renderCustomBlock
    value=(get @item @column.attribute))}}