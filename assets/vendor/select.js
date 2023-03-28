window.addEventListener("select_option", (e) => {
  let { field_id, option } = e.detail;
  let input = document.querySelector(`#${field_id}`);
  if (input) {
    input.value = option.value;
    input.dispatchEvent(new Event("change", { bubbles: true }));
  }
  let clickedOption = e.target;
  let inputId = `#${field_id}`;
  let container = document.querySelector(`${inputId}-dropdown`);
  let trigger = document.querySelector(`${inputId}-trigger`);
  let triggerValue = document.querySelector(`${inputId}-trigger-value`);

  let currentOption = container.querySelector("[data-selected='true']");
  let selectingSelectedOption =
    !!currentOption && currentOption === clickedOption;

  if (trigger) {
    trigger.dataset.value = true;
  }

  if (triggerValue) {
    triggerValue.innerText = option.label;
  }

  if (currentOption) {
    currentOption.dataset.selected = false;
  }

  if (!selectingSelectedOption) {
    clickedOption.dataset.selected = true;
  }
});
