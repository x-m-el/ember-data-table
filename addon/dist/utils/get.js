
import { isEmpty } from '@ember/utils';
import { get as get$1 } from '@ember/object';

// Same as the ember `get`, but returns the original object if the path does not exist.
function get(obj, path) {
  if (isEmpty(path)) return obj;
  return get$1(obj, path);
}

export { get as default };
//# sourceMappingURL=get.js.map
