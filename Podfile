platform :ios, '12.0'

target 'Niebo' do
  use_frameworks!

  pod 'Moya/RxSwift',      '~> 10.0'
  pod 'Then',              '~> 2.3'
  pod 'RxSwiftExt',        '~> 3.2'
  pod 'RxCocoa',           '~> 4.0'
  pod 'SnapKit',           '~> 4.0.0'
  pod 'RxDataSources',     '~> 3.0'
  pod 'ReachabilitySwift', '~> 4.1.0'

  target 'NieboFramework' do
  end

  target 'NieboTests' do
    inherit! :search_paths
    pod 'RxBlocking', '~> 4.0'
    pod 'RxTest',     '~> 4.0'
  end

end
