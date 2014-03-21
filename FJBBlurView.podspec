Pod::Spec.new do |s|
  s.name     = 'FJBBlurView'
  s.version  = '0.0.1'
  s.platform = :ios, '6.0'
  s.summary  = 'Menu View Controller Library.'
  s.description = 'Library to provide a Blur View'
  s.homepage = 'https://github.com/fjbelchi/FJBBlurView'
  s.author   = { 'Francisco J. Belchi' => 'fjbelchi@gmail.com' }
  s.source   = { :git => 'https://github.com/fjbelchi/FJBBlurView.git', :tag => "#{s.version}" }
  s.source_files = 'src/*'
  s.requires_arc = true
  s.dependency  'GPUImage', '~> 0.1.2'
  s.license = { :type => 'MIT License', :file => 'LICENSE' }
end
