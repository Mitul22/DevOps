const request = require('supertest');
const express = require('express');
const app = require('../index'); // your main file

describe('GET /', () => {
  it('responds with Hello World', (done) => {
    request(app).get('/')
      .expect('Hello World', done);
  });
});
