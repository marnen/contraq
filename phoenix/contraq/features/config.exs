defmodule WhiteBreadConfig do
  use WhiteBread.SuiteConfiguration

  suite name:          "All",
        context:       DefaultContext,
        feature_paths: ["features/"]
end
