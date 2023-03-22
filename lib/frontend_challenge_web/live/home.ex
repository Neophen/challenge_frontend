defmodule FrontendChallengeWeb.Live.Home do
  use FrontendChallengeWeb, :live_view

  import FrontendChallengeWeb.Components.Select

  alias Ecto.Changeset

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:list_data_few, random_data(1, 2))
      |> assign(:list_data_default, random_data(4, 6))
      |> assign(:list_data_many, random_data(30, 35))
      |> assign(:form, to_form(changeset(), as: form_key()))

    {:ok, socket, temporary_assigns: [form: nil]}
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <div class="relative bg-white p-6 md:rounded-md md:shadow-md">
      <.form for={@form} phx-change="validate" phx-submit="validate">
        <div class="flex flex-col gap-4">
          <h2>Select with few data</h2>
          <.select title="Select 1" field={@form[:select1]} data={@list_data_few} />

          <h2>Select with normal data</h2>
          <.select title="Select 2" field={@form[:select2]} data={@list_data_default} />

          <h2>Select with many data</h2>
          <.select title="Select 3" field={@form[:select3]} data={@list_data_many} />

          <.button>Validate</.button>
        </div>
      </.form>
    </div>
    """
  end

  defp form_key(), do: :default

  @impl Phoenix.LiveView
  def handle_event("validate", %{"default" => params}, socket) do
    form =
      params
      |> changeset()
      |> Map.put(:action, :validate)
      |> to_form(as: form_key())

    {:noreply, assign(socket, :form, form)}
  end

  defp changeset(params \\ %{}) do
    types = %{select1: :string, select2: :string, select3: :string}
    fields = Map.keys(types)

    {%{}, types}
    |> Changeset.cast(params, fields)
    |> Changeset.validate_required(fields)
  end

  defp random_data(min_size, max_size) when min_size < max_size do
    Enum.map(1..Enum.random(min_size..max_size), fn _i ->
      random_number = Enum.random(100..10_000)

      %{
        value: random_number,
        label: "Item #{random_number}"
      }
    end)
  end
end
