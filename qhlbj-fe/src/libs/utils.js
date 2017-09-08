import request from 'superagent'

function post(url, params, ext) {
  return new Promise((resolve, reject) => {
    request.post(url)
      .query(ext || {})
      .send(params)
      .end((err, res) => {
        if (err) {
          reject(err)
        } else {
          resolve(res)
        }
      })
  })
}

function get(url, ext) {
  return new Promise((resolve, reject) => {
    request.get(url)
      .query(ext || {})
      .end((err, res) => {
        if (err) {
          reject(err)
        } else {
          resolve(res)
        }
      })
  })
}

function patch(url, params, ext) {
  return new Promise((resolve, reject) => {
    request.patch(url)
      .query(ext || {})
      .send(params)
      .end((err, res) => {
        if (err) {
          reject(err)
        } else {
          resolve(res)
        }
      })
  })
}

function del(url, ext) {
  return new Promise((resolve, reject) => {
    request.delete(url)
      .query(ext || {})
      .end((err, res) => {
        if (err) {
          reject(err)
        } else {
          resolve(res)
        }
      })
  })
}

export { post, get, del, patch }
