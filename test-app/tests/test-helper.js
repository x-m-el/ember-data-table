import Application from 'test-app/app';
import config from 'test-app/config/environment';
import * as QUnit from 'qunit';
import { setApplication } from '@ember/test-helpers';
import { setup } from 'qunit-dom';
import { start } from 'ember-qunit';

// Enable better error stack traces in tests
QUnit.config.stackTrace = {
  separator: '\n',  // default is ' | '
  filter: false     // disable stack filtering
};

// Configure QUnit for source maps
QUnit.config.urlConfig.push({
  id: 'sourcemaps',
  label: 'Enable Source Maps',
  tooltip: 'Enable source maps for better stack traces',
  value: true
});

QUnit.config.testTimeout = 60000;
QUnit.config.reorder = false;

setApplication(Application.create(config.APP));

setup(QUnit.assert);

start();
