defmodule ElixirJobsWeb.SeoHelper do
  @moduledoc """
  Module with SEO-related functions like the ones to generate descriptions,
  titles, etc.
  """

  use ElixirJobsWeb, :view

  import Phoenix.Controller, only: [view_module: 1, view_template: 1]

  @default_page_title "Find your next flat the right way"
  @default_page_description "Apartmanaramasi helps students to find their next shared flat and future flatmates to spread their offers. Use our search engine to find your next flat."

  alias ElixirJobs.Core.Schemas.Offer
  alias ElixirJobsWeb.ErrorView
  alias ElixirJobsWeb.OfferView
  alias ElixirJobsWeb.PageView

  def page_title(%Plug.Conn{} = conn) do
    get_page_title(view_module(conn), view_template(conn), conn.assigns, conn.params)
  end

  def page_title(_), do: gettext(@default_page_title)

  def page_description(%Plug.Conn{} = conn) do
    get_page_description(view_module(conn), view_template(conn), conn.assigns)
  end

  def page_description(_), do: gettext(@default_page_description)

  defp get_page_title(OfferView, "new.html", _, _), do: gettext("Publish a flat")

  defp get_page_title(OfferView, action, _, params)
       when action in [:index_filtered, :search] do
    flat_type =
      params
      |> Map.get("filters", %{})
      |> Map.get("flat_type", "")

    district =
      params
      |> Map.get("filters", %{})
      |> Map.get("district", "")

    case {flat_type, district} do
      {"shared_flat", ""} -> gettext("shared flat offers")
      {"flat", ""} -> gettext("Flat offers")
      {"house", ""} -> gettext("House offers")
      {"", "beyoğlu"} -> gettext("Flat offers in Beyoğlu")
      {"", "kadıköy"} -> gettext("Flat offers in Kadıköy")
      _ -> gettext(@default_page_title)
    end
  end

  defp get_page_title(OfferView, "show.html", %{:offer => %Offer{} = offer}, _),
    do: "#{offer.title} @ #{offer.company}"

  defp get_page_title(ErrorView, "404.html", _, _),
    do: gettext("Not Found")

  defp get_page_title(ErrorView, "500.html", _, _),
    do: gettext("Internal Error")

  defp get_page_title(PageView, "about.html", _, _), do: gettext("About")

  defp get_page_title(AuthView, action, _, _) when action in [:new, :create],
    do: gettext("Log in")

  defp get_page_title(_, _, _, _), do: gettext(@default_page_title)

  defp get_page_description(OfferView, "new.html", _),
    do:
      gettext(
        "Post your flat offer to reach potential prospects!"
      )

  defp get_page_description(OfferView, "show.html", %{:offer => %Offer{} = offer}) do
    offer.summary
    |> HtmlSanitizeEx.strip_tags()
    |> String.slice(0, 100)
  end

  defp get_page_description(PageView, "about.html", _),
    do:
      gettext(
        "Built on Elixir + Phoenix, apartmanaramasi is a project that aims to help people in Turkey to find their next dream flat."
      )

  defp get_page_description(_, _, _), do: gettext(@default_page_description)
end
