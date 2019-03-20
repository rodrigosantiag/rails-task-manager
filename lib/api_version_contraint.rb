class ApiVersionConstraint
  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end

  def mathces?(req)
    @default || req.headers['Accept'].include?("application/vnd.taskmanager.v#{@version}")
  end
end
