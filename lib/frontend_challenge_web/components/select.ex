defmodule FrontendChallengeWeb.Components.Select do
  @moduledoc """
  Implement the select component here.
  """

  use Phoenix.Component

  import FrontendChallengeWeb.CoreComponents

  alias Phoenix.HTML.FormField
  alias Phoenix.LiveView.JS

  @type t() :: %{value: String.t(), label: String.t()}

  attr(:title, :string, required: true)
  attr(:field, FormField, required: true)
  attr(:data, :list, required: true)

  @spec select(assigns :: map()) :: Rendered.t()
  def select(%{field: field} = assigns) do
    assigns = assign(assigns, :errors, Enum.map(field.errors, &translate_error(&1)))

    ~H"""
    <input type="hidden" id={@field.id} name={@field.name} value={@field.value} />

    <div class="group relative">
      <.select_trigger title={@title} field={@field} data={@data} />
      <.select_dropdown title={@title} field={@field} data={@data} />
    </div>

    <.error :for={msg <- @errors}><%= msg %></.error>
    """
  end

  attr(:title, :string, required: true)
  attr(:field, FormField, required: true)
  attr(:data, :list, required: true)

  defp select_trigger(assigns) do
    ~H"""
    <button
      type="button"
      id={"#{@field.id}-trigger"}
      phx-click={show_content(@field.id)}
      data-value={has_value(@field.value)}
      class="group block w-full rounded-lg border border-grey-400 bg-white py-3 px-4 text-left hover:border-lavender-600 focus:outline-none focus-visible:border-lavender-600"
    >
      <div class={[
        "max-w-max font-sans text-grey-500 transition group-hover:text-lavender-800 group-focus:text-lavender-800",
        "group-data-true:animate-label group-data-true:absolute group-data-true:-translate-y-5 group-data-true:bg-white group-data-true:px-1 group-data-true:text-xs group-data-true:font-bold"
      ]}>
        <%= @title %>
      </div>
      <div id={"#{@field.id}-trigger-value"} class="hidden group-data-true:block">
        <%= get_option_label(@field.value, @data) %>
      </div>
    </button>
    """
  end

  attr(:title, :string, required: true)
  attr(:field, FormField, required: true)
  attr(:data, :list, required: true)
  attr(:class, :string, default: "flex")

  defp select_dropdown(assigns) do
    ~H"""
    <div
      id={"#{@field.id}-dropdown"}
      class={[
        "origin-bottom scale-y-0 transition-transform duration-200 ease-in-out md:origin-top",
        "drop-shadow-sm top-0 z-10 flex-col overflow-hidden bg-white md:rounded-lg",
        "fixed left-0 right-0 h-screen",
        "md:absolute md:top-[-4px] md:left-[-1px] md:right-[-1px] md:h-auto md:max-h-[496px] md:min-h-[360px]",
        @class
      ]}
      phx-click-away={hide_content(@field.id)}
    >
      <button
        phx-click={hide_content(@field.id)}
        type="button"
        class="block w-full bg-white p-4 text-left font-sans text-grey-800 drop-shadow-sm md:hidden"
      >
        Cancel
      </button>
      <div class="bg-white p-4 md:px-6 md:pb-6 md:pt-8">
        <h1 class="text-xl font-bold leading-6 text-grey-800 md:leading-6">
          <%= @title %>
        </h1>
      </div>

      <ul class="overflow-y-scroll grow divide-y divide-grey-200 scroll-shadows">
        <.select_option :for={option <- @data} field={@field} option={option} />
      </ul>
    </div>
    """
  end

  attr(:field, FormField, required: true)
  attr(:option, :any, required: true)

  defp select_option(assigns) do
    ~H"""
    <li>
      <button
        type="button"
        class={[
          "group flex w-full items-center p-4 text-left text-grey-800 hover:bg-grey-100 focus:outline-none focus-visible:bg-grey-100",
          "data-[selected]:bg-lavender-100"
        ]}
        phx-click={on_select_option(@field.id, @option)}
        data-selected={is_selected?(@field.value, @option.value)}
        data-id={@option.value}
      >
        <span class="flex-1 truncate">
          <%= @option.label %>
        </span>
        <p class="hidden group-data-[selected]:block">V</p>
      </button>
    </li>
    """
  end

  defp get_dropdown_id(id) do
    "##{id}-dropdown"
  end

  defp show_content(js \\ %JS{}, id) do
    js
    |> JS.remove_class("scale-y-0", to: get_dropdown_id(id))
  end

  defp hide_content(js \\ %JS{}, id) do
    js
    |> JS.add_class("scale-y-0", to: get_dropdown_id(id))
  end

  defp on_select_option(js \\ %JS{}, id, option) do
    js
    |> hide_content(id)
    |> JS.dispatch("select_option", detail: %{field_id: id, option: option})
  end

  defp get_option_label(value, items) do
    item = get_item_by_value(value, items)

    case is_nil(item) do
      true -> nil
      false -> item.label
    end
  end

  defp get_item_by_value(value, items) do
    Enum.find(items, fn item -> to_string(item.value) == to_string(value) end)
  end

  defp is_selected?(value, _option) when is_nil(value), do: false

  defp is_selected?(value, option) do
    to_string(value) === to_string(option)
  end

  defp has_value(value) when is_nil(value), do: "false"
  defp has_value(_value = ""), do: "false"
  defp has_value(_value), do: "true"
end
