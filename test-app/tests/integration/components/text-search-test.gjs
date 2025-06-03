import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import RawDataTable from 'ember-data-table/components/raw-data-table';
import { fn } from '@ember/helper';

module('Integration | Component | text search', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders by default', async function (assert) {
    await render(
      <template>
        <RawDataTable
          @filter=""
        />
      </template>,
    );
    assert.dom('.raw-data-table .data-table-search').exists({ count: 1 });
  });

  test('it does not render if filter is not set', async function (assert) {
    await render(<template><RawDataTable /></template>);
    assert.dom('.raw-data-table .data-table-search').doesNotExist();
  });

  test('it does not render if enableSearch is false', async function (assert) {
    await render(
      <template>
        <RawDataTable
          @enableSearch={{false}}
          @filter=""
        />
      </template>,
    );
    assert.dom('.raw-data-table .data-table-search').doesNotExist();
  });

  test('@searchPlaceholder text is rendered', async function (assert) {
    const searchPlaceholder = 'Search Placeholder Text';
    await render(
      <template>
        <RawDataTable @searchPlaceholder={{searchPlaceholder}} @filter="" />
      </template>,
    );
    assert.dom('.raw-data-table .data-table-search input').hasAttribute('placeholder', searchPlaceholder, 'renders @searchPlaceholder');
  });
});
