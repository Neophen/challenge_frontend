defmodule FrontendChallengeWeb.Components.Select do
  @moduledoc """
  Implement the select component here.
  """

  use Phoenix.Component

  import FrontendChallengeWeb.CoreComponents

  alias Phoenix.HTML.FormField

  @type t() :: %{value: String.t(), label: String.t()}

  attr(:title, :string, required: true)
  attr(:field, FormField, required: true)
  attr(:data, :list, required: true)

  @spec select(assigns :: map()) :: Rendered.t()
  def select(%{field: field} = assigns) do
    assigns = assign(assigns, :errors, Enum.map(field.errors, &translate_error(&1)))

    ~H"""
    <input type="hidden" id={@field.id} name={@field.name} value={@field.value} />

    <div>
      Implement here.
    </div>

    <.error :for={msg <- @errors}><%= msg %></.error>
    """
  end
end
