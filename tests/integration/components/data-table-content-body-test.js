import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { click, render } from '@ember/test-helpers';
import hbs from 'htmlbars-inline-precompile';

module('Integration | Component | data table content body', function (hooks) {
  setupRenderingTest(hooks);

  test('display rows', async function (assert) {
    const content = [
      { firstName: 'John', lastName: 'Doe', age: 20 },
      { firstName: 'Jane', lastName: 'Doe', age: 21 },
    ];
    const fields= ['firstName', 'lastName', 'age'];

    this.set('content', content);
    this.set('fields', fields);
    await render(hbs`
      <RawDataTable
        @content={{this.content}}
        @fields={{this.fields}}
      />
    `);

    assert.dom('tbody>tr').exists({ count: 2 }, 'displays 2 rows');
    assert.dom('tbody>tr:first-child td').exists({ count: 3 }, 'displays 3 columns');
    assert.dom('tbody>tr:first-child td:first-child').hasText('John', 'displays firstName in first column');
    assert.dom('tbody>tr:first-child td:nth-child(2)').hasText('Doe', 'displays lastName in second column');
    assert.dom('tbody>tr:first-child td:nth-child(3)').hasText('20', 'displays age in third column');
  });

  test('add checkboxes for selection if enabled and allow initial selection', async function (assert) {
    const john = { firstName: 'John', lastName: 'Doe', age: 20 };
    const jane = { firstName: 'Jane', lastName: 'Doe', age: 21 };
    const jeff = { firstName: 'Jeff', lastName: 'Doe', age: 22 };
    const content = [john, jane, jeff];
    const fields = ['firstName', 'lastName', 'age'];
    const selection = [jane];

    this.set('content', content);
    this.set('fields', fields);
    this.set('initialSelection', selection);
    await render(hbs`
      <RawDataTable
        @content={{this.content}}
        @fields={{this.fields}}
        @initialSelection={{this.initialSelection}}
        @enableSelection={{true}}
      />
    `);

    assert.dom('tbody>tr:first-child td').exists({ count: 4 }, 'displays 4 columns');
    assert.dom('tbody>tr.selected').exists({ count: 1 }, 'displays 1 selected row');
    assert.dom('tbody>tr input[type="checkbox"]').exists({ count: 3 }, 'displays a checkbox on each row');
    assert.dom('tbody>tr input[type="checkbox"]:checked').isChecked('displays 1 checked checkbox');
  });

  test('toggles selection if checkbox is clicked', async function (assert) {
    const john = { firstName: 'John', lastName: 'Doe', age: 20 };
    const jane = { firstName: 'Jane', lastName: 'Doe', age: 21 };
    const jeff = { firstName: 'Jeff', lastName: 'Doe', age: 22 };
    const content = [john, jane, jeff];
    const fields = ['firstName', 'lastName', 'age'];
    const selection = [jane];

    this.set('content', content);
    this.set('fields', fields);
    this.set('selection', selection);
    await render(hbs`
      <RawDataTable
        @content={{this.content}}
        @fields={{this.fields}}
        @enableSelection={{true}}
        @initialSelection={{this.selection}}
      />
    `);

    assert.dom('tbody>tr input[type="checkbox"]:checked').isChecked('displays 1 checked checkbox before selecting a row');
    await click('tbody>tr:first-child input[type="checkbox"]');
    assert.dom('tbody>tr input[type="checkbox"]:checked').isChecked('displays 2 checked checkboxes after selecting a row');
  });

  test('add line numbers if enabled', async function (assert) {
    const john = { firstName: 'John', lastName: 'Doe', age: 20 };
    const jane = { firstName: 'Jane', lastName: 'Doe', age: 21 };
    const jeff = { firstName: 'Jeff', lastName: 'Doe', age: 22 };
    const content = [john, jane, jeff];
    const fields = ['firstName', 'lastName', 'age'];

    this.set('content', content);
    this.set('fields', fields);
    await render(hbs`
      <RawDataTable
        @content={{this.content}}
        @fields={{this.fields}}
        @enableLineNumbers={{true}}
      />
    `);

    assert.dom('tbody>tr:first-child td').exists({ count: 4 }, 'displays 4 columns');
    assert.dom('tbody>tr:first-child td:first-child').hasText('1', 'displays offset 1 on the first row');
    assert.dom('tbody>tr:nth-child(2) td:first-child').hasText('2', 'displays offset 2 on the second row');
    assert.dom('tbody>tr:nth-child(3) td:first-child').hasText('3', 'displays offset 3 on the third row');

    this.set('page', 2);
    this.set('size', 5);
    await render(hbs`
      <RawDataTable
        @content={{this.content}}
        @fields={{this.fields}}
        @enableLineNumbers={{true}}
        @page={{this.page}}
        @size={{this.size}}
      />
    `);

    assert.dom('tbody>tr:first-child td').exists({ count: 4 }, 'displays 4 columns on page 3');
    assert.dom('tbody>tr:first-child td:first-child').hasText('11', 'displays offset 11 on the first row on page 3');
    assert.dom('tbody>tr:nth-child(2) td:first-child').hasText('12', 'displays offset 12 on the second row on page 3');
    assert.dom('tbody>tr:nth-child(3) td:first-child').hasText('13', 'displays offset 13 on the third row of page 3');
  });

  test('displays no data message if there is no data', async function (assert) {
    const noDataMessage = 'No data';
    const dataTable = {
      parsedFields: ['firstName', 'lastName', 'age'],
      selection: []
    };

    this.set('noDataMessage', noDataMessage);
    this.set('dataTable', dataTable);
    await render(hbs`
      <RawDataTable
        @noDataMessage={{this.noDataMessage}}
        @dataTable={{this.dataTable}}
      />
    `);
    assert.dom('td.no-data-message').exists({ count: 1 }, 'displays a no data message if no content');
    assert.dom('td.no-data-message').hasText('No data', 'displays message "No data" if no content');

    const emptyContent = [];
    this.set('emptyContent', emptyContent);
    this.set('noDataMessage', noDataMessage);
    this.set('dataTable', dataTable);
    await render(hbs`
      <RawDataTable
        @content={{this.emptyContent}}
        @noDataMessage={{this.noDataMessage}}
        @dataTable={{this.dataTable}}
      />
    `);
    assert.dom('td.no-data-message').exists({ count: 1 }, 'displays a no data message if empty content');
    assert.dom('td.no-data-message').hasText('No data', 'displays message "No data" if empty content');

    const content = ['foo', 'bar'];
    this.set('content', content);
    this.set('noDataMessage', noDataMessage);
    this.set('dataTable', dataTable);
    await render(hbs`
      <RawDataTable
        @content={{this.content}}
        @noDataMessage={{this.noDataMessage}}
        @dataTable={{this.dataTable}}
      />
    `);
    assert.dom('td.no-data-message').doesNotExist('displays no message when there is content');
  });
});
