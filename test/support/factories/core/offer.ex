defmodule ElixirJobs.Factories.Core.Offer do
  @moduledoc false

  use ElixirJobs.Factories.Base, :offer

  alias ElixirJobs.Core.Fields.District
  alias ElixirJobs.Core.Fields.FlatType
  alias ElixirJobs.Core.Schemas.Offer

  def build_factory do
    %{
      title: Faker.Lorem.sentence(2),
      company: Faker.Lorem.sentence(2),
      location: Faker.StarWars.planet(),
      url: Faker.Internet.url(),
      contact_email: Faker.Internet.email(),
      summary: Faker.Lorem.sentence(8..10),
      district: Enum.random(District.available_values()),
      flat_type: Enum.random(FlatType.available_values())
    }
  end

  def get_schema, do: %Offer{}

  def get_changeset(attrs), do: Offer.changeset(%Offer{}, attrs)
end
