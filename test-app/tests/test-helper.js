import Application from 'test-app/app';
import config from 'test-app/config/environment';
import * as QUnit from 'qunit';
import { setApplication } from '@ember/test-helpers';
import { setup } from 'qunit-dom';
import { start } from 'ember-qunit';

QUnit.config.testTimeout = 60000;
QUnit.config.reorder = false;

setApplication(Application.create(config.APP));

setup(QUnit.assert);

start();
