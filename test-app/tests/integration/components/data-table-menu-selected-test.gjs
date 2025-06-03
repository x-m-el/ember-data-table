import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render, click } from '@ember/test-helpers';
import RawDataTable from 'ember-data-table/components/raw-data-table';

module('Integration | Component | data table menu selected', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders block only if data table selection is not empty', async function (assert) {
    await render(
      <template>
        <RawDataTable>
          <:selection-menu>
            template block text
          </:selection-menu>
        </RawDataTable>
      </template>,
    );
    assert.dom('.data-table-menu .item-count').doesNotExist();
  });

  test('it renders selection count in raw-data-table', async function (assert) {
    const john = { firstName: 'John', lastName: 'Doe', age: 20 };
    const jane = { firstName: 'Jane', lastName: 'Doe', age: 21 };
    const content = [john, jane];
    const fields = ['firstName', 'lastName', 'age'];
    const selection = [john];

    await render(
      <template>
        <RawDataTable
          @content={{content}}
          @fields={{fields}}
          @enableSelection={{true}}
          @initialSelection={{selection}}
        />
      </template>,
    );
    assert
      .dom('.data-table-menu .item-count')
      .hasText('1 item(s) selected', 'item count 1');

    const selection2 = [john, jane];
    await render(
      <template>
        <RawDataTable
          @content={{content}}
          @fields={{fields}}
          @enableSelection={{true}}
          @initialSelection={{selection2}}
        />
      </template>,
    );
    assert
      .dom('.data-table-menu .item-count')
      .hasText('2 item(s) selected', 'item count 2');
  });

  test('calls clearSelection on cancel button click', async function (assert) {
    const john = { firstName: 'John', lastName: 'Doe', age: 20 };
    const jane = { firstName: 'Jane', lastName: 'Doe', age: 21 };
    const content = [john, jane];
    const fields = ['firstName', 'lastName', 'age'];
    const selection = [john];

    await render(
      <template>
        <RawDataTable
          @content={{content}}
          @fields={{fields}}
          @enableSelection={{true}}
          @initialSelection={{selection}}
        />
      </template>,
    );
    assert
      .dom('.data-table-menu button')
      .hasText('Cancel', 'renders a cancel button');
    await click('.data-table-menu button');
    assert.dom('.data-table-menu .item-count').doesNotExist();
  });

  test('renders actions in selection-menu-actions block', async function (assert) {
    const john = { firstName: 'John', lastName: 'Doe', age: 20 };
    const jane = { firstName: 'Jane', lastName: 'Doe', age: 21 };
    const content = [john, jane];
    const fields = ['firstName', 'lastName', 'age'];
    const selection = [john];

    await render(
      <template>
        <RawDataTable
          @content={{content}}
          @fields={{fields}}
          @enableSelection={{true}}
          @initialSelection={{selection}}
        >
          <:selection-menu-actions>
            template block text
          </:selection-menu-actions>
        </RawDataTable>
      </template>,
    );
    assert
      .dom('.data-table-menu .item-count')
      .hasText('1 item(s) selected', 'item count 1');
    assert.dom('.data-table-menu').containsText('template block text');
  });
});
