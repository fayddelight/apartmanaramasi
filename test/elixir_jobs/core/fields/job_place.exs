defmodule ElixirJobs.Core.Fields.DistrictTest do
  use ElixirJobs.DataCase

  alias ElixirJobs.Core.Fields.District

  describe "District.cast/1" do
    test "recognises valid districts" do
      assert District.cast(:adalar) == {:ok, :adalar}
      assert District.cast("adalar") == {:ok, :adalar}
    end

    test "recognises invalid districts" do
      assert District.cast(:wadus) == :error
      assert District.cast(0) == :error
    end
  end

  describe "District.load/1" do
    test "translates valid districts" do
      assert District.load("adalar") == {:ok, :adalar}
    end

    test "does not translate invalid districts" do
      assert District.load("wadus") == :error
      assert District.load(0) == :error
    end
  end

  describe "District.dump/1" do
    test "translates valid districts" do
      assert District.dump(:adalar) == {:ok, "adalar"}
    end

    test "dump/1 does not translate invalid districts" do
      assert District.dump(:wadus) == :error
      assert District.dump(0) == :error
    end
  end
end
