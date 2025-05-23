import { isEmpty } from '@ember/utils';
import { get as emberGet } from '@ember/object';

// Same as the ember `get`, but returns the original object if the path does not exist.
export default function get(obj, path) {
  if(isEmpty(path)) return obj;
  return emberGet(obj, path);
}
