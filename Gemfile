# Set bundle path to ./gems
bundle_path "gems"

# dependencies are generated using a strict version, don't forget to edit the dependency versions when upgrading.
merb_gems_version = "1.1.0.pre"
dm_gems_version   = "0.10.0"
do_gems_version   = "0.10.0"

# If you did disable json for Merb, comment out this line.
# Don't use json gem version lower than 1.1.7! Older version have a security bug
gem "json_pure", ">= 1.1.7", :require_as => "json"
gem "extlib", ">= 0.9.13"
gem "templater", ">= 1.0.0"
gem "randexp", "0.1.4"

# For more information about each component, please read http://wiki.merbivore.com/faqs/merb_components
gem "merb-core", merb_gems_version
gem "merb-action-args", merb_gems_version
gem "merb-assets", merb_gems_version
# gem("merb-cache", merb_gems_version) do
#   Merb::Cache.setup do
#     register(Merb::Cache::FileStore) unless Merb.cache
#   end
# end
gem "merb-helpers", merb_gems_version
# gem "merb-mailer", merb_gems_version
# gem "merb-slices", merb_gems_version
# gem "merb-auth-core", merb_gems_version
# gem "merb-auth-more", merb_gems_version
# gem "merb-auth-slice-password", merb_gems_version
gem "merb-param-protection", merb_gems_version
gem "merb-exceptions", merb_gems_version
gem "merb-gen", merb_gems_version
gem "merb-haml", merb_gems_version

gem "data_objects", do_gems_version
gem "do_postgres", do_gems_version
gem "dm-core", dm_gems_version
gem "dm-aggregates", dm_gems_version
gem "dm-migrations", dm_gems_version
gem "dm-timestamps", dm_gems_version
gem "dm-types", dm_gems_version
gem "dm-validations", dm_gems_version
gem "dm-serializer", dm_gems_version
gem "dm-sweatshop", dm_gems_version

gem "merb_datamapper", merb_gems_version

gem "dm-pagination", "0.4.0"
gem "merb-colorful-logger", "0.1.5"
gem "merb-flash", "0.1.5"
# gem "merb-i18n", "0.2.3"
gem "merb-ext", "0.1.2"

# gem "mini_magick", "1.2.5"
# gem "rubyzip", "0.9.1", :require_as => "zip/zip"
gem "RedCloth", "4.2.2"
