const _ = require('lodash');
const asyncHandler = (fn) => {
  return (req, res, next) => {
    fn(req, res, next).catch(next);
  };
};

const pick = ({object, keys}) => _.pick(object, keys);


module.exports = {
  asyncHandler,
  pick,
};
