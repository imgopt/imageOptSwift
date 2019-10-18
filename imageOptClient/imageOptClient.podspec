Pod::Spec.new do |spec|
  spec.name         = "imageOptClient"
  spec.version      = "0.0.1"
  spec.summary      = "imageOpt client library for iOS and tvOS"
  spec.description  = <<-DESC
	imageOpt client library, to construct parameterized imageOpt URL from plain image URL
                   DESC

  spec.homepage     = "https://github.com/imgopt/imageOptSwift"
  spec.license      = "MIT"
  spec.author             = { "Bhavesh Bhojani" => "bhavesh@imageopt.com" }
  spec.ios.deployment_target = "9.0"
  spec.tvos.deployment_target = "9.0"
  spec.source       = { :git => "https://github.com/imgopt/imageOptClient.git", :tag => "#{spec.version}" }
  spec.source_files  = "Sources/*.swift"
end
