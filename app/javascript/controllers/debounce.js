const debounce = (func, wait) => {
  console.log('I am debounce');
  let timeout;
  return (...args) => {
    const context = this;
    clearTimeout(timeout);
    timeout = setTimeout(() => func.apply(context, args), wait);
  };
}
export { debounce } ;