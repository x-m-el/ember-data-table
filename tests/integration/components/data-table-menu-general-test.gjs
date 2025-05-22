import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import hbs from 'htmlbars-inline-precompile';

module('Integration | Component | data table menu general', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(hbs`<RawDataTable />`);

    assert.dom('.data-table-menu').exists({ count: 1 }, 'Menu container exists');
  });

  test('it renders block only if data table selection is empty', async function (assert) {
    const john = { firstName: 'John', lastName: 'Doe', age: 20 };
    const jane = { firstName: 'Jane', lastName: 'Doe', age: 21 };
    const jeff = { firstName: 'Jeff', lastName: 'Doe', age: 22 };
    const content = [john, jane, jeff];
    const fields = ['firstName', 'lastName', 'age'];

    this.set('content', content);
    this.set('fields', fields);

    // Test with empty selection
    await render(hbs`
      <RawDataTable
        @content={{this.content}}
        @fields={{this.fields}}
        @enableSelection={{true}}>
        <:general-menu>
          template block text
        </:general-menu>
      </RawDataTable>
    `);
    assert.dom('.data-table-menu').containsText('template block text');

    // Test with non-empty selection
    const selection = [jane];
    this.set('initialSelection', selection);
    await render(hbs`
      <RawDataTable
        @content={{this.content}}
        @fields={{this.fields}}
        @enableSelection={{true}}
        @initialSelection={{this.initialSelection}}>
        <:general-menu>
          template block text
        </:general-menu>
      </RawDataTable>
    `);

    assert.dom('.data-table-menu').doesNotContainText('template block text');
  });
});
