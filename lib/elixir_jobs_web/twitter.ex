defmodule ElixirJobsWeb.Twitter do
  @moduledoc """
  Twitter-related functions to ease the publishing of new offers in that social
  network.
  """

  alias ElixirJobs.Core.Schemas.Offer
  alias ElixirJobsWeb.Router.Helpers, as: RouterHelpers

  alias ElixirJobsWeb.HumanizeHelper

  @short_link_length 25
  @twitter_limit 140
  @tags [
    "job",
    "myelixirstatus",
    "elixirlang"
  ]

  def publish(%Plug.Conn{} = conn, %Offer{} = offer) do
    text = get_text(offer)
    tags = get_tags()
    url = get_url(conn, offer)

    status_length = String.length(text) + String.length(tags) + 3 + @short_link_length

    status =
      case status_length do
        n when n <= @twitter_limit ->
          Enum.join([text, tags, url], " ")

        n ->
          exceed = n - @twitter_limit
          max_text_length = String.length(text) - exceed

          short_text =
            text
            |> String.slice(0, max_text_length - 3)
            |> Kernel.<>("...")

          Enum.join([short_text, tags, url], " ")
      end

    ExTwitter.update(status)
  end

  defp get_text(%Offer{company: company, title: title, district: district}) do
    "#{title} @ #{company} / #{HumanizeHelper.human_get_place(district, "Unknown Place")}"
  end

  defp get_tags do
    @tags
    |> Enum.map(&"##{&1}")
    |> Enum.join(" ")
  end

  defp get_url(%Plug.Conn{} = conn, %Offer{slug: slug}) do
    RouterHelpers.offer_url(conn, :show, slug)
  end
end
