module WsModel
  class BeuWs < ActionWebService::Struct
    member :content, :string
    member :user, :string
  end

  class Credentials < ActionWebService::Struct
    member :username, :string
    member :password, :string
  end

end

class WsApi < ActionWebService::API::Base
  include WsModel

  api_method :login, :expects => [ Credentials ], :returns => [ :bool ]
  api_method :add, :expects => [ :string ], :returns => [ BeuWs ]
  api_method :list, :expects => [], :returns => [[ :string ]]
end
