defmodule ElixirJobs.Core.Fields.FlatTypeTest do
  use ElixirJobs.DataCase

  alias ElixirJobs.Core.Fields.FlatType

  describe "FlatType.cast/1" do
    test "recognises valid flat types" do
      assert FlatType.cast(:shared_flat) == {:ok, :shared_flat}
      assert FlatType.cast("shared_flat") == {:ok, :shared_flat}
    end

    test "recognises invalid flat types" do
      assert FlatType.cast(:wadus) == :error
      assert FlatType.cast(0) == :error
    end
  end

  describe "FlatType.load/1" do
    test "translates valid flat types" do
      assert FlatType.load("shared_flat") == {:ok, :shared_flat}
    end

    test "does not translate invalid flat types" do
      assert FlatType.load("wadus") == :error
      assert FlatType.load(0) == :error
    end
  end

  describe "FlatType.dump/1" do
    test "translates valid flat types" do
      assert FlatType.dump(:shared_flat) == {:ok, "shared_flat"}
    end

    test "dump/1 does not translate invalid flat types" do
      assert FlatType.dump(:wadus) == :error
      assert FlatType.dump(0) == :error
    end
  end
end
