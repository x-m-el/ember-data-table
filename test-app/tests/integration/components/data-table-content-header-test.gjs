import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import RawDataTable from 'ember-data-table/components/raw-data-table';

module('Integration | Component | data table content header', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template><RawDataTable /></template>);
    assert.dom('thead').exists({ count: 1 });
    assert.dom('thead').hasText('');
    // Template block usage:
    await render(
      <template>
        <RawDataTable>
          <:full-header>
            <thead>template block text</thead>
          </:full-header>
        </RawDataTable>
      </template>,
    );
    assert.dom('thead').hasText('template block text');
  });

  test('display column headers', async function (assert) {
    const fields = ['firstName', 'lastName', 'age'];
    await render(<template><RawDataTable @fields={{fields}} /></template>);
    assert.dom('thead tr').exists({ count: 1 }, 'displays 1 header row');
    assert.dom('thead tr th').exists({ count: 3 }, 'displays 3 column headers');
    assert
      .dom('thead tr th:first-child')
      .hasText('firstName', 'displays firstName as first header');
    assert
      .dom('thead tr th:nth-child(2)')
      .hasText('lastName', 'displays lastName as second column header');
    assert
      .dom('thead tr th:nth-child(3)')
      .hasText('age', 'displays age as third column header');
  });

  test('add selection column header if enabled', async function (assert) {
    const fields = ['firstName', 'lastName', 'age'];
    await render(
      <template>
        <RawDataTable @fields={{fields}} @enableSelection={{true}} />
      </template>,
    );
    assert.dom('thead tr').exists({ count: 1 }, 'displays 1 header row');
    assert.dom('thead tr th').exists({ count: 4 }, 'displays 4 column headers');
    assert
      .dom('thead tr th:first-child')
      .hasText('', 'displays selection as first header');
  });

  test('add line number column header if enabled', async function (assert) {
    const fields = ['firstName', 'lastName', 'age'];
    await render(
      <template>
        <RawDataTable @fields={{fields}} @enableLineNumbers={{true}} />
      </template>,
    );
    assert.dom('thead tr').exists({ count: 1 }, 'displays 1 header row');
    assert.dom('thead tr th').exists({ count: 4 }, 'displays 4 column headers');
    assert
      .dom('thead tr th:first-child')
      .hasText('', 'displays line number as first header');
  });

  test('display custom column headers', async function (assert) {
    const fields = ['firstName', 'lastName:Last_Name', 'age:Some__Age', {attribute: "birthday", label: "birth:__:day"}];
    await render(<template><RawDataTable @fields={{fields}} /></template>);
    assert.dom('thead tr').exists({ count: 1 }, 'displays 1 header row');
    assert.dom('thead tr th').exists({ count: 4 }, 'displays 4 column headers');
    assert
      .dom('thead tr th:first-child')
      .hasText('firstName', 'displays firstName as first header');
    assert
      .dom('thead tr th:nth-child(2)')
      .hasText('Last Name', 'displays lastName as second column header');
    assert
      .dom('thead tr th:nth-child(3)')
      .hasText('Some_Age', 'displays age as third column header');
    assert
      .dom('thead tr th:nth-child(4)')
      .hasText('birth:__:day', 'displays age as third column header');
  });
});
