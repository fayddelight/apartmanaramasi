defmodule ElixirJobsWeb.HumanizeHelper do
  @moduledoc false
  use ElixirJobsWeb, :helper

  alias ElixirJobsWeb.DateHelper

  def human_get_place("adalar", default), do: get_place_text(:adalar, default)
  def human_get_place("arnavutköy", default), do: get_place_text(:arnavutköy, default)
  def human_get_place("ataşehir", default), do: get_place_text(:ataşehir, default)
  def human_get_place("bahçelievler", default), do: get_place_text(:bahçelievler, default)
  def human_get_place("bakırköy", default), do: get_place_text(:bakırköy, default)
  def human_get_place("bayrampaşa", default), do: get_place_text(:bayrampaşa, default)
  def human_get_place("bağcılar", default), do: get_place_text(:bağcılar, default)
  def human_get_place("beykoz", default), do: get_place_text(:beykoz, default)
  def human_get_place("beyoğlu", default), do: get_place_text(:beyoğlu, default)
  def human_get_place("beşiktaş", default), do: get_place_text(:beşiktaş, default)
  def human_get_place("büyükçekmece", default), do: get_place_text(:büyükçekmece, default)
  def human_get_place("çatalca", default), do: get_place_text(:çatalca, default)
  def human_get_place("eminönü", default), do: get_place_text(:eminönü, default)
  def human_get_place("esenler", default), do: get_place_text(:esenler, default)
  def human_get_place("esenyurt", default), do: get_place_text(:esenyurt, default)
  def human_get_place("eyüp", default), do: get_place_text(:eyüp, default)
  def human_get_place("fatih", default), do: get_place_text(:fatih, default)
  def human_get_place("gaziosmanpaşa", default), do: get_place_text(:gaziosmanpaşa, default)
  def human_get_place("göztepe", default), do: get_place_text(:göztepe, default)
  def human_get_place("güngören", default), do: get_place_text(:güngören, default)
  def human_get_place("kadıköy", default), do: get_place_text(:kadıköy, default)
  def human_get_place("kartal", default), do: get_place_text(:kartal, default)
  def human_get_place("kâğıthane", default), do: get_place_text(:kâğıthane, default)
  def human_get_place("küçükçekmece", default), do: get_place_text(:küçükçekmece, default)
  def human_get_place("maltepe", default), do: get_place_text(:maltepe, default)
  def human_get_place("pendik", default), do: get_place_text(:pendik, default)
  def human_get_place("silivri", default), do: get_place_text(:silivri, default)
  def human_get_place("şişli", default), do: get_place_text(:şişli, default)
  def human_get_place("tuzla", default), do: get_place_text(:tuzla, default)
  def human_get_place("ümraniye", default), do: get_place_text(:ümraniye, default)
  def human_get_place("üsküdar", default), do: get_place_text(:üsküdar, default)
  def human_get_place("zeytinburnu", default), do: get_place_text(:zeytinburnu, default)
  def human_get_place(option, default), do: get_place_text(option, default)

  def human_get_type("shared_flat", default), do: get_type_text(:shared_flat, default)
  def human_get_type("flat", default), do: get_type_text(:flat, default)
  def human_get_type("house", default), do: get_type_text(:house, default)
  def human_get_type(option, default), do: get_type_text(option, default)

  @doc "Returns a date formatted for humans."
  def readable_date(date, use_abbrevs? \\ true) do
    if use_abbrevs? && this_year?(date) do
      cond do
        today?(date) ->
          "Today"

        yesterday?(date) ->
          "Yesterday"

        true ->
          DateHelper.strftime(date, "%e %b")
      end
    else
      DateHelper.strftime(date, "%e %b %Y")
    end
  end

  def get_place_text(:adalar, _default), do: gettext("Adalar")
  def get_place_text(:arnavutköy, _default), do: gettext("Arnavutköy")
  def get_place_text(:ataşehir, _default), do: gettext("Ataşehir")
  def get_place_text(:bahçelievler, _default), do: gettext("Bahçelievler")
  def get_place_text(:bakırköy, _default), do: gettext("Bakırköy")
  def get_place_text(:bayrampaşa, _default), do: gettext("Bayrampaşa")
  def get_place_text(:bağcılar, _default), do: gettext("Bağcılar")
  def get_place_text(:beykoz, _default), do: gettext("Beykoz")
  def get_place_text(:beyoğlu, _default), do: gettext("Beyoğlu")
  def get_place_text(:beşiktaş, _default), do: gettext("Beşiktaş")
  def get_place_text(:büyükçekmece, _default), do: gettext("Büyükçekmece")
  def get_place_text(:çatalca, _default), do: gettext("Çatalca")
  def get_place_text(:eminönü, _default), do: gettext("Eminönü")
  def get_place_text(:esenler, _default), do: gettext("Esenler")
  def get_place_text(:esenyurt, _default), do: gettext("Esenyurt")
  def get_place_text(:eyüp, _default), do: gettext("Eyüp")
  def get_place_text(:fatih, _default), do: gettext("Fatih")
  def get_place_text(:gaziosmanpaşa, _default), do: gettext("Gaziosmanpaşa")
  def get_place_text(:göztepe, _default), do: gettext("Göztepe")
  def get_place_text(:güngören, _default), do: gettext("Güngören")
  def get_place_text(:kadıköy, _default), do: gettext("Kadıköy")
  def get_place_text(:kartal, _default), do: gettext("Kartal")
  def get_place_text(:kâğıthane, _default), do: gettext("Kâğıthane")
  def get_place_text(:küçükçekmece, _default), do: gettext("Küçükçekmece")
  def get_place_text(:maltepe, _default), do: gettext("Maltepe")
  def get_place_text(:pendik, _default), do: gettext("Pendik")
  def get_place_text(:silivri, _default), do: gettext("Silivri")
  def get_place_text(:şişli, _default), do: gettext("Şişli")
  def get_place_text(:tuzla, _default), do: gettext("Tuzla")
  def get_place_text(:ümraniye, _default), do: gettext("Ümraniye")
  def get_place_text(:üsküdar, _default), do: gettext("Üsküdar")
  def get_place_text(:zeytinburnu, _default), do: gettext("Zeytinburnu")
  def get_place_text(_, default), do: default

  def get_type_text(:shared_flat, _default), do: gettext("Shared flat")
  def get_type_text(:flat, _default), do: gettext("Flat")
  def get_type_text(:house, _default), do: gettext("House")
  def get_type_text(_, default), do: default

  ###
  # Private functions
  ###

  defp this_year?(date), do: date.year == DateTime.utc_now().year

  defp today?(date) do
    now = DateTime.utc_now()
    date.day == now.day && date.month == now.month && date.year == now.year
  end

  def yesterday?(date) do
    now = DateTime.utc_now()
    difference = DateTime.diff(now, date)
    difference < 2 * 24 * 60 * 60 && difference > 1 * 24 * 60 * 60
  end
end
