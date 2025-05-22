import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import { hbs } from 'ember-cli-htmlbars';

module('Integration | Component | text search', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders by default', async function (assert) {
    this.set('filter', '');
    await render(hbs`
      <RawDataTable
        @filter={{this.filter}}
        @updateFilter={{fn (mut this.filter)}}
      />
    `);
    assert.dom('.raw-data-table .data-table-search').exists({ count: 1 });
  });

  test('it does not render if filter is not set', async function (assert) {
    await render(hbs`
      <RawDataTable
      />
    `);
    assert.dom('.raw-data-table .data-table-search').doesNotExist();
  });

  test('it does not render if enableSearch is false', async function (assert) {
    this.set('filter', '');
    await render(hbs`
      <RawDataTable
        @enableSearch={{false}}
        @filter={{this.filter}}
        @updateFilter={{fn (mut this.filter)}}
      />
    `);
    assert.dom('.raw-data-table .data-table-search').doesNotExist();
  });
});
