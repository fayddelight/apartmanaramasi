defmodule ElixirJobs.Core.Queries.Offer do
  @moduledoc """
  Module to build queries related to the Offer schema
  """

  import Ecto.Query, warn: false

  def build(query, opts) do
    Enum.reduce(opts, query, fn
      {:published, true}, q ->
        q
        |> published()
        |> order_published()

      {:published, false}, q ->
        unpublished(q)

      {:district, value}, q ->
        by_district(q, value)

      {:flat_type, value}, q ->
        by_flat_type(q, value)

      {:search_text, text}, q ->
        by_text(q, text)

      _, q ->
        q
    end)
  end

  def by_id(query, id) do
    from o in query, where: o.id == ^id
  end

  def by_slug(query, slug) do
    from o in query, where: o.slug == ^slug
  end

  def by_flat_type(query, values) when is_list(values) do
    from o in query, where: o.flat_type in ^values
  end

  def by_flat_type(query, value) do
    from o in query, where: o.flat_type == ^value
  end

  def by_district(query, values) when is_list(values) do
    from o in query, where: o.district in ^values
  end

  def by_district(query, value) do
    from o in query, where: o.district == ^value
  end

  def by_text(query, text) when is_binary(text) do
    text
    |> String.split(" ")
    |> Enum.map(&"%#{&1}%")
    |> Enum.reduce(query, fn keyword, q ->
      from o in q,
        where:
          ilike(o.title, ^keyword) or ilike(o.company, ^keyword) or ilike(o.summary, ^keyword) or
            ilike(o.location, ^keyword)
    end)
  end

  def published(query) do
    from o in query,
      where: not is_nil(o.published_at) and o.published_at <= ^DateTime.utc_now()
  end

  def unpublished(query) do
    from o in query, where: is_nil(o.published_at)
  end

  def order_published(query) do
    from o in query, order_by: [desc: o.published_at]
  end
end
