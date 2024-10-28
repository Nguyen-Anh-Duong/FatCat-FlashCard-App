const _ = require('lodash');

const pick = ({object, keys}) => _.pick(object, keys);


module.exports = {
  pick,
};
