const SCROLL_LISTENERS = new Map();

window.addEventListener("add-scroll-area", (e) => {
  const scrollContainer = e.target;

  const firstChild = scrollContainer.firstElementChild;
  const lastChild = scrollContainer.lastElementChild;
  const scrollListener = () => {
    const hasOverflow =
      scrollContainer.scrollHeight > scrollContainer.clientHeight;
    const isBeforeEndOfScroll =
      scrollContainer.scrollTop + scrollContainer.clientHeight <
      scrollContainer.scrollHeight;

    if (!hasOverflow) {
      return;
    }

    if (scrollContainer.scrollTop > 0) {
      firstChild.classList.add("drop-shadow-sm");
      firstChild.classList.remove("opacity-0");
    } else {
      firstChild.classList.remove("drop-shadow-sm");
      firstChild.classList.add("opacity-0");
    }

    if (isBeforeEndOfScroll) {
      lastChild.classList.add("drop-shadow-sm");
      lastChild.classList.remove("opacity-0");
    } else {
      lastChild.classList.remove("drop-shadow-sm");
      lastChild.classList.add("opacity-0");
    }
  };

  // TODO: MIGHT BE PERFORMANCE HEAVY
  scrollContainer.addEventListener("scroll", scrollListener);
  const elementListeners = SCROLL_LISTENERS.get(scrollContainer) || [];

  SCROLL_LISTENERS.set(scrollContainer, [
    ...elementListeners,
    {
      type: "scroll",
      listener: scrollListener,
    },
  ]);
});

window.addEventListener("remove-scroll-area", (e) => {
  const element = e.target;
  const listeners = SCROLL_LISTENERS.get(scrollContainer) || [];

  listeners.forEach(({ type, listener }) => {
    element.removeEventListener(type, listener);
  });
});
