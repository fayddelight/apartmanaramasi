defmodule ElixirJobsWeb.MicrodataHelper do
  @moduledoc false
  use ElixirJobsWeb, :helper

  alias ElixirJobs.Core.Schemas.Offer
  alias ElixirJobsWeb.DateHelper

  use Phoenix.HTML

  def render_microdata(%Plug.Conn{} = conn) do
    case get_microdata(conn) do
      microdata when is_map(microdata) ->
        "<script type=\"application/ld+json\">#{Jason.encode!(microdata)}</script>"

      microdatas when is_list(microdatas) ->
        microdatas
        |> Enum.map(fn data ->
          "<script type=\"application/ld+json\">#{Jason.encode!(data)}</script>"
        end)
        |> Enum.join("")

      _ ->
        ""
    end
  end

  defp get_microdata(%Plug.Conn{} = conn) do
    organization_microdata = [organization_microdata(conn)]

    site_microdata = [
      %{
        "@context" => "http://schema.org",
        "@type" => "WebSite",
        "maintainer" => organization_microdata,
        "url" => ElixirJobsWeb.Endpoint.url() <> "/"
      }
    ]

    offer_microdata =
      case conn.assigns do
        %{offer: %Offer{} = offer} ->
          [offer_microdata(conn, offer)]

        _ ->
          []
      end

    site_microdata ++ organization_microdata ++ offer_microdata
  end

  defp offer_microdata(conn, offer) do
    publication_date = offer.published_at || offer.inserted_at
    publication_date_str = DateHelper.strftime(publication_date, "%Y-%m-%d")

    flat_type =
      case offer.flat_type do
        :shared_flat -> gettext("Shared flat")
        :flat -> gettext("Flat")
        :house -> gettext("House")
        _ -> gettext("Unknown")
      end

    job_description =
      offer.summary
      |> text_to_html()
      |> safe_to_string()

    base = %{
      "@context" => "http://schema.org",
      "@type" => "JobPosting",
      "title" => offer.title,
      "description" => job_description,
      "datePosted" => publication_date_str,
      "flatType" => flat_type,
      "url" => offer_url(conn, :show, offer.slug),
      "hiringOrganization" => %{
        "@type" => "Organization",
        "@context" => "http://schema.org",
        "name" => offer.company
      },
      "jobLocation" => %{
        "@type" => "Place",
        "@context" => "http://schema.org",
        "address" => offer.location
      }
    }

# ???
#    case offer.district do
#      place when place in [:beyoğlu, :kadıköy] ->
#        Map.put(base, "flatLocationType", "TELECOMMUTE")
#
#      _ ->
#        base
#    end
  end

  defp organization_microdata(conn) do
    %{
      "url" => ElixirJobsWeb.Endpoint.url() <> "/",
      "sameAs" => ["https://twitter.com/jobs_elixir"],
      "name" => gettext("ElixirJobs"),
      "image" => static_url(conn, "/images/logo.png"),
      "brand" => %{
        "@type" => "Brand",
        "@context" => "http://schema.org",
        "name" => gettext("ElixirJobs"),
        "logo" => static_url(conn, "/images/logo.png"),
        "slogan" => gettext("Find your next job the right way")
      },
      "@type" => "Organization",
      "@context" => "http://schema.org"
    }
  end
end
