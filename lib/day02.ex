defmodule AOC.Day02 do
  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> parse_game()
      |> calculate_max()
      |> set_possibility()
    end)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> parse_game()
      |> calculate_max()
      |> calculate_power()
    end)
    |> Enum.sum()
  end

  defp calculate_power(%{maxes: maxes}) do
    maxes |> Map.values() |> Enum.product()
  end

  defp set_possibility(%{id: id, maxes: maxes}) do
    if maxes.red <= 12 and maxes.green <= 13 and maxes.blue <= 14 do
      id
    else
      0
    end
  end

  defp calculate_max(%{grabs: grabs} = game) do
    maxes =
      Enum.reduce(grabs, %{red: 0, blue: 0, green: 0}, fn grab, maxes ->
        Enum.reduce(grab, maxes, fn {color, blocks}, maxes ->
          Map.update(maxes, color, blocks, fn current -> max(current, blocks) end)
        end)
      end)

    %{id: game.id, maxes: maxes}
  end

  defp parse_game("Game " <> rest) do
    {id, ": " <> rest} = Integer.parse(rest)

    grabs =
      rest
      |> String.split("; ", trim: true)
      |> Enum.map(fn game ->
        game
        |> String.split(", ", trim: true)
        |> Enum.map(fn block ->
          {blocks, " " <> color} = Integer.parse(block)
          {String.to_atom(color), blocks}
        end)
      end)

    %{id: id, grabs: grabs}
  end
end
