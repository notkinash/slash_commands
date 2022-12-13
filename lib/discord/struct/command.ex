defmodule Discord.Struct.Command do
  @moduledoc false
  defstruct [
    :id,
    :type,
    :application_id,
    :guild_id,
    :name,
    :name_localizations,
    :description,
    :description_localizations,
    :options,
    :default_member_permissions,
    :dm_permission,
    :default_permission,
    :nsfw,
    :version
  ]

  @spec serialize(keyword() | map()) :: Discord.Struct.Command
  def serialize(command) when is_map_key(command, :name) do
    struct(__MODULE__, command)
  end

  def serialize(command) when is_map_key(command, "name") do
    Map.new(command, fn {key, value} -> {String.to_existing_atom(key), value} end)
    |> serialize()
  end

  def serialize(command) do
    %__MODULE__{
      id: Keyword.get(command, :id),
      type: Keyword.get(command, :type),
      application_id: Keyword.get(command, :application_id),
      guild_id: Keyword.get(command, :guild_id),
      name: Keyword.get(command, :name),
      name_localizations: Keyword.get(command, :name_localizations),
      description: Keyword.get(command, :description),
      description_localizations: Keyword.get(command, :description_localizations),
      options: Keyword.get(command, :options),
      default_member_permissions: Keyword.get(command, :default_member_permissions),
      dm_permission: Keyword.get(command, :dm_permission),
      default_permission: Keyword.get(command, :default_permission),
      nsfw: Keyword.get(command, :nsfw),
      version: Keyword.get(command, :version)
    }
  end

  defimpl Jason.Encoder do
    def encode(value, opts) do
      Map.from_struct(value)
      |> Map.filter(fn {_, val} -> val != nil end)
      |> Jason.Encode.map(opts)
    end
  end
end
