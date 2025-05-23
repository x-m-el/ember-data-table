
function attributeToSortParams(attribute) {
  const attr = attribute.replace(/([a-z])([A-Z])/g, '$1-$2').toLowerCase();
  return {
    asc: attr,
    desc: `-${attr}`
  };
}

export { attributeToSortParams as default };
//# sourceMappingURL=attribute-to-sort-params.js.map
