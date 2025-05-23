import Controller from '@ember/controller';
import { tracked } from '@glimmer/tracking';
export default class SimpleTableEdController extends Controller {
  queryParams = ['size', 'page', 'filter', 'sort'];

  @tracked size = 10;
  @tracked page = 0;
  @tracked filter = '';
  @tracked sort = '';
  @tracked isLoadingModel = false;
}
