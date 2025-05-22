import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import hbs from 'htmlbars-inline-precompile';


module('Integration | Component | data table content header', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    // Set any properties with this.set('myProperty', 'value');
    // Handle any actions with this.on('myAction', function(val) { ... });

    await render(hbs`<RawDataTable />`);
    assert.dom('thead').exists({ count: 1 });
    assert.dom('thead').hasText('');
    // Template block usage:
    await render(hbs`
      <RawDataTable>
        <:full-header>
          <thead>template block text</thead>
        </:full-header>
      </RawDataTable>
    `);
    assert.dom('thead').hasText('template block text');
  });

  test('display column headers', async function (assert) {
    this.set('fields', ['firstName', 'lastName', 'age']);
    await render(hbs`<RawDataTable @fields={{this.fields}} />`);
    assert.dom('thead tr').exists({ count: 1 }, 'displays 1 header row');
    assert.dom('thead tr th').exists({ count: 3 }, 'displays 3 column headers');
    assert.dom('thead tr th:first-child').hasText('firstName', 'displays firstName as first header');
    assert.dom('thead tr th:nth-child(2)').hasText('lastName', 'displays lastName as second column header');
    assert.dom('thead tr th:nth-child(3)').hasText('age', 'displays age as third column header');
  });

  test('add selection column header if enabled', async function (assert) {
    this.set('fields', ['firstName', 'lastName', 'age']);
    await render(hbs`<RawDataTable @fields={{this.fields}} @enableSelection={{true}} />`);
    assert.dom('thead tr').exists({ count: 1 }, 'displays 1 header row');
    assert.dom('thead tr th').exists({ count: 4 }, 'displays 4 column headers');
    assert.dom('thead tr th:first-child').hasText('', 'displays selection as first header');
  });

  test('add line number column header if enabled', async function (assert) {
    this.set('fields', ['firstName', 'lastName', 'age']);
    await render(hbs`<RawDataTable @fields={{this.fields}} @enableLineNumbers={{true}} />`);
    assert.dom('thead tr').exists({ count: 1 }, 'displays 1 header row');
    assert.dom('thead tr th').exists({ count: 4 }, 'displays 4 column headers');
    assert.dom('thead tr th:first-child').hasText('', 'displays line number as first header');
  });
});
