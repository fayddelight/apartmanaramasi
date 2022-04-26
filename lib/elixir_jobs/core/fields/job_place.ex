defmodule ElixirJobs.Core.Fields.District do
  @moduledoc """
  Field definition module to save in the database the type of an account
  """

  use Ecto.Type

  @values [:unknown, :adalar, :arnavutköy, :ataşehir, :avcılar, :bahçelievler, :bakırköy,
 :bayrampaşa, :bağcılar, :başakşehir, :beykoz, :beyoğlu, :beşiktaş,
 :büyükçekmece, :çatalca, :eminönü, :esenler, :esenyurt, :eyüp, :fatih,
 :gaziosmanpaşa, :göztepe, :güngören, :kadıköy, :kartal, :kâğıthane,
 :küçükçekmece, :maltepe, :pendik, :sarıyer, :silivri, :şişli, :tuzla,
 :ümraniye, :üsküdar, :zeytinburnu]

  def available_values, do: @values

  @doc false
  def type, do: :string

  @doc """
  Cast a district from the value input to verify that it's a registered value.

  ## Examples

    iex> cast(:adalar)
    {:ok, :adalar}

    iex> cast("adalar")
    {:ok, :adalar}

    iex> cast(:wadus)
    :error

  """
  @spec cast(atom()) :: {:ok, atom()} | :error
  def cast(value) when value in @values, do: {:ok, value}
  def cast(value) when is_binary(value), do: load(value)
  def cast(_value), do: :error

  @doc """
  Load a district value from the adapter to adapt it to the desired format in the app.

  ## Examples

    iex> load("adalar")
    {:ok, :adalar}

    iex> load("wadus")
    :error

  """
  @spec load(String.t()) :: {:ok, atom()} | :error
  def load(value) when is_binary(value) do
    @values
    |> Enum.find(fn k -> to_string(k) == value end)
    |> case do
      k when not is_nil(k) ->
        {:ok, k}

      _ ->
        :error
    end
  end

  def load(_), do: :error

  @doc """
  Translate the value in the app side to the database type.

  ## Examples

    iex> dump(:adalar)
    {:ok, "adalar"}

    iex> dump(:wadus)
    :error

  """
  @spec dump(atom()) :: {:ok, String.t()} | :error
  def dump(value) when value in @values, do: {:ok, to_string(value)}
  def dump(_), do: :error
end
