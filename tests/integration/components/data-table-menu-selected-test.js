import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render, click } from '@ember/test-helpers';
import hbs from 'htmlbars-inline-precompile';

module('Integration | Component | data table menu selected', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders block only if data table selection is not empty', async function (assert) {
    await render(hbs`
      <RawDataTable>
        <:selection-menu>
          template block text
        </:selection-menu>
      </RawDataTable>
    `);
    assert.dom('.data-table-menu .item-count').doesNotExist();
  });

  test('it renders selection count in raw-data-table', async function (assert) {
    const john = { firstName: 'John', lastName: 'Doe', age: 20 };
    const jane = { firstName: 'Jane', lastName: 'Doe', age: 21 };
    const content = [john, jane];
    const fields = ['firstName', 'lastName', 'age'];

    this.set('content', content);
    this.set('fields', fields);
    this.set('selection', [ john ]);
    await render(hbs`
      <RawDataTable
        @content={{this.content}}
        @fields={{this.fields}}
        @enableSelection={{true}}
        @initialSelection={{this.selection}}>
      </RawDataTable>
    `);
    assert.dom('.data-table-menu .item-count').hasText('1 item(s) selected', 'item count 1');

    this.set('selection', [john, jane]);
    await render(hbs`
      <RawDataTable
        @content={{this.content}}
        @fields={{this.fields}}
        @enableSelection={{true}}
        @initialSelection={{this.selection}}>
      </RawDataTable>
    `);
    assert.dom('.data-table-menu .item-count').hasText('2 item(s) selected', 'item count 2');
  });

  test('calls clearSelection on cancel button click', async function (assert) {
    const john = { firstName: 'John', lastName: 'Doe', age: 20 };
    const jane = { firstName: 'Jane', lastName: 'Doe', age: 21 };
    const content = [john, jane];
    const fields = ['firstName', 'lastName', 'age'];

    this.set('content', content);
    this.set('fields', fields);
    this.set('selection', [ john ]);
    await render(hbs`
      <RawDataTable
        @content={{this.content}}
        @fields={{this.fields}}
        @enableSelection={{true}}
        @initialSelection={{this.selection}}>
      </RawDataTable>
    `);
    assert.dom('.data-table-menu button').hasText('Cancel', 'renders a cancel button');
    await click('.data-table-menu button');
    assert.dom('.data-table-menu .item-count').doesNotExist();
  });
  test('renders actions in selection-menu-actions block', async function (assert) {
    const john = { firstName: 'John', lastName: 'Doe', age: 20 };
    const jane = { firstName: 'Jane', lastName: 'Doe', age: 21 };
    const content = [john, jane];
    const fields = ['firstName', 'lastName', 'age'];

    this.set('content', content);
    this.set('fields', fields);
    this.set('selection', [ john ]);
    await render(hbs`
      <RawDataTable
        @content={{this.content}}
        @fields={{this.fields}}
        @enableSelection={{true}}
        @initialSelection={{this.selection}}>
        <:selection-menu-actions>
          template block text
        </:selection-menu-actions>
      </RawDataTable>
    `);
    assert.dom('.data-table-menu .item-count').hasText('1 item(s) selected', 'item count 1');
    assert.dom('.data-table-menu').containsText('template block text');
  });
});
