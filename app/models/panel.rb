class Panel < ActiveRecord::Base
	mount_uploader :logo, LogoUploader
end