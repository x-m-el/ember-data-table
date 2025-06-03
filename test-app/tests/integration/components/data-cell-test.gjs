import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import RawDataTable from 'ember-data-table/components/raw-data-table';
import { hash } from '@ember/helper';

module('Integration | Component | data-table/data-cell', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders custom fields as custom', async function (assert) {
    const content = [{ firstName: 'John', lastName: 'Doe', age: 20 }];
    // Template block usage:
    await render(
      <template>
        <RawDataTable
          @content={{content}}
          @fields="firstName lastName age"
          @customFields="age notExisting"
        >
          <:data-cell as |cell|>
            <td>{{cell.attribute}}</td>
          </:data-cell>
        </RawDataTable>
      </template>,
    );

    assert
      .dom('tbody>tr:first-child td')
      .exists({ count: 3 }, 'displays 3 columns');
    assert
      .dom('tbody>tr:first-child td:first-child')
      .hasText('John', 'displays firstName in first column');
    assert
      .dom('tbody>tr:first-child td:nth-child(2)')
      .hasText('Doe', 'displays lastName in second column');
    assert
      .dom('tbody>tr:first-child td:nth-child(3)')
      .hasText('age', 'displays custom block in third column');
    assert
      .dom('tbody')
      .doesNotIncludeText('20', 'Only display custom block, not the age value');
    assert
      .dom('tbody')
      .doesNotIncludeText(
        'notExisting',
        'only show @customFields custom blocks for fields also passed to @fields',
      );
  });

  test('it renders custom fields as components', async function (assert) {
    const content = [{ firstName: 'John', lastName: 'Doe', age: 20 }];
    const ageTemplate = <template>
      <td>Custom {{@cell.attribute}} component</td>
    </template>;

    await render(
      <template>
        <RawDataTable
          @content={{content}}
          @fields="firstName lastName age"
          @customFields={{hash age=(component ageTemplate)}}
        />
      </template>,
    );

    assert
      .dom('tbody>tr:first-child td')
      .exists({ count: 3 }, 'displays 3 columns');
    assert
      .dom('tbody>tr:first-child td:first-child')
      .hasText('John', 'displays firstName in first column');
    assert
      .dom('tbody>tr:first-child td:nth-child(2)')
      .hasText('Doe', 'displays lastName in second column');
    assert
      .dom('tbody>tr:first-child td:nth-child(3)')
      .hasText(
        'Custom age component',
        'displays custom component in third column',
      );
    assert
      .dom('tbody')
      .doesNotIncludeText(
        '20',
        'Only display custom component, not the age value',
      );
  });
});
