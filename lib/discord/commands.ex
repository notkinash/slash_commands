defmodule Discord.Commands do
  @moduledoc """
  API for Discord Application Commands.
  """
  use Tesla

  alias Discord.Struct.Command

  @token Application.compile_env!(:slash_commands, :token)
  @api_version Application.compile_env!(:slash_commands, :api_version)
  @application_id Application.compile_env!(:slash_commands, :application_id)

  plug(
    Tesla.Middleware.BaseUrl,
    "https://discord.com/api/v#{@api_version}/applications/#{@application_id}"
  )

  plug(Tesla.Middleware.Headers, [{"authorization", "Bot #{@token}"}])
  plug(Tesla.Middleware.JSON)

  @doc """
  Fetches all global commands and returns as a list of `Discord.Struct.Command`.

  ## Parameters
    - `with_localizations?` if you want to get commands with localizations. Default: `false`.
  """
  @spec fetch_global_commands(boolean()) :: {:ok, list(Command)} | {:error, any()}
  def fetch_global_commands(with_localizations? \\ false) do
    case get("/commands", query: [with_localizations: with_localizations?]) do
      {:ok, response} ->
        {:ok, Enum.map(response.body, &Command.serialize/1)}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Check `fetch_global_commands/1`.
  """
  @spec fetch_global_commands!(boolean()) :: list(Command)
  def fetch_global_commands!(with_localizations? \\ false) do
    response = get!("/commands", query: [with_localizations: with_localizations?])
    Enum.map(response.body, &Command.serialize/1)
  end
end
