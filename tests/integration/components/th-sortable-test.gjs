import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import { hbs } from 'ember-cli-htmlbars';

module('Integration | Component | th sortable', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    this.set('fields', ['title']);
    this.set('sortableFields', ['title']);

    await render(hbs`
      <RawDataTable
        @fields={{this.fields}}
        @sortableFields={{this.sortableFields}}
      />
    `);

    assert.dom('.data-table .sortable').exists({ count: 1 });
  });
});
