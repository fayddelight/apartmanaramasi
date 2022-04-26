defmodule ElixirJobs.Core.Schemas.OfferTest do
  use ElixirJobs.DataCase

  alias ElixirJobs.Core.Schemas.Offer
  alias ElixirJobs.Repo

  describe "Offer.changeset/2" do
    test "validates correct data" do
      attributes = params_for(:offer)

      result = Offer.changeset(%Offer{}, attributes)

      assert %Ecto.Changeset{} = result
      assert result.valid?
    end

    required_attrs = [
      :title,
      :company,
      :contact_email,
      :location,
      :url,
      :district,
      :flat_type,
      :summary
    ]

    Enum.each(required_attrs, fn attr ->
      test "validates that #{attr} is required" do
        attributes =
          :offer
          |> params_for()
          |> Map.delete(unquote(attr))

        changeset = Offer.changeset(%Offer{}, attributes)

        refute changeset.valid?
        assert Enum.any?(changeset.errors, &(elem(&1, 0) == unquote(attr)))
      end
    end)

    test "generates a slug if not passed" do
      attrs =
        :offer
        |> params_for()
        |> Map.delete(:slug)

      changeset = Offer.changeset(%Offer{}, attrs)

      assert changeset.valid?
      refute Ecto.Changeset.get_field(changeset, :slug) in [nil, ""]
    end

    test "slug can be passed" do
      attrs = params_for(:offer, slug: "hello-elixir")

      changeset = Offer.changeset(%Offer{}, attrs)

      assert changeset.valid?
      assert Ecto.Changeset.get_field(changeset, :slug) == "hello-elixir"
    end

    test "title length is checked" do
      attrs = params_for(:offer, title: "a")
      changeset = Offer.changeset(%Offer{}, attrs)

      refute changeset.valid?
      assert Enum.any?(changeset.errors, &(elem(&1, 0) == :title))

      attrs = params_for(:offer, title: Faker.Lorem.sentence(51))
      changeset = Offer.changeset(%Offer{}, attrs)

      refute changeset.valid?
      assert Enum.any?(changeset.errors, &(elem(&1, 0) == :title))
    end

    test "company length is checked" do
      attrs = params_for(:offer, company: "a")
      changeset = Offer.changeset(%Offer{}, attrs)

      refute changeset.valid?
      assert Enum.any?(changeset.errors, &(elem(&1, 0) == :company))

      attrs = params_for(:offer, company: Faker.Lorem.sentence(31))
      changeset = Offer.changeset(%Offer{}, attrs)

      refute changeset.valid?
      assert Enum.any?(changeset.errors, &(elem(&1, 0) == :company))
    end

    test "summary length is checked" do
      attrs = params_for(:offer, summary: "a")
      changeset = Offer.changeset(%Offer{}, attrs)

      refute changeset.valid?
      assert Enum.any?(changeset.errors, &(elem(&1, 0) == :summary))

      attrs = params_for(:offer, summary: Faker.Lorem.sentence(2001))
      changeset = Offer.changeset(%Offer{}, attrs)

      refute changeset.valid?
      assert Enum.any?(changeset.errors, &(elem(&1, 0) == :summary))
    end

    test "location length is checked" do
      attrs = params_for(:offer, location: "a")
      changeset = Offer.changeset(%Offer{}, attrs)

      refute changeset.valid?
      assert Enum.any?(changeset.errors, &(elem(&1, 0) == :location))

      attrs = params_for(:offer, location: Faker.Lorem.sentence(51))
      changeset = Offer.changeset(%Offer{}, attrs)

      refute changeset.valid?
      assert Enum.any?(changeset.errors, &(elem(&1, 0) == :location))
    end

    test "url length is checked" do
      attrs = params_for(:offer, url: Faker.Lorem.sentence(256))
      changeset = Offer.changeset(%Offer{}, attrs)

      refute changeset.valid?
      assert Enum.any?(changeset.errors, &(elem(&1, 0) == :url))
    end

    test "url format is checked" do
      # Not an URL at all
      attrs = params_for(:offer, url: "fake url")
      changeset = Offer.changeset(%Offer{}, attrs)

      refute changeset.valid?
      assert Enum.any?(changeset.errors, &(elem(&1, 0) == :url))

      # FTP address
      attrs = params_for(:offer, url: "ftp://google.es")
      changeset = Offer.changeset(%Offer{}, attrs)

      refute changeset.valid?
      assert Enum.any?(changeset.errors, &(elem(&1, 0) == :url))

      # No host
      attrs = params_for(:offer, url: "/wadus")
      changeset = Offer.changeset(%Offer{}, attrs)

      refute changeset.valid?
      assert Enum.any?(changeset.errors, &(elem(&1, 0) == :url))

      # Valid one
      attrs = params_for(:offer, url: "https://wadus.com/url")
      changeset = Offer.changeset(%Offer{}, attrs)

      assert changeset.valid?
      refute Enum.any?(changeset.errors, &(elem(&1, 0) == :url))
    end

    test "contact_email length is checked" do
      attrs = params_for(:offer, contact_email: "#{Faker.Lorem.characters(256)}@test.com")
      changeset = Offer.changeset(%Offer{}, attrs)

      refute changeset.valid?
      assert Enum.any?(changeset.errors, &(elem(&1, 0) == :contact_email))
    end

    test "contact_email format is checked" do
      # Not an email at all
      attrs = params_for(:offer, contact_email: "fake url")
      changeset = Offer.changeset(%Offer{}, attrs)

      refute changeset.valid?
      assert Enum.any?(changeset.errors, &(elem(&1, 0) == :contact_email))

      # Invalid address
      attrs = params_for(:offer, contact_email: "google.es")
      changeset = Offer.changeset(%Offer{}, attrs)

      refute changeset.valid?
      assert Enum.any?(changeset.errors, &(elem(&1, 0) == :contact_email))

      attrs = params_for(:offer, contact_email: "test_google.com")
      changeset = Offer.changeset(%Offer{}, attrs)

      refute changeset.valid?
      assert Enum.any?(changeset.errors, &(elem(&1, 0) == :contact_email))
    end

    test "district is validated" do
      # Not an URL at all
      attrs = params_for(:offer, district: "invent")
      changeset = Offer.changeset(%Offer{}, attrs)

      refute changeset.valid?
      assert Enum.any?(changeset.errors, &(elem(&1, 0) == :district))
    end

    test "flat_type is validated" do
      # Not an URL at all
      attrs = params_for(:offer, flat_type: "invent")
      changeset = Offer.changeset(%Offer{}, attrs)

      refute changeset.valid?
      assert Enum.any?(changeset.errors, &(elem(&1, 0) == :flat_type))
    end

    test "slug should be unique" do
      offer = insert(:offer)

      attrs = params_for(:offer, slug: offer.slug)
      changeset = Offer.changeset(%Offer{}, attrs)

      assert changeset.valid?

      {:error, changeset} = Repo.insert(changeset)

      refute changeset.valid?
      assert Enum.any?(changeset.errors, &(elem(&1, 0) == :slug))
    end
  end
end
