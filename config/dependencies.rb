# dependencies are generated using a strict version, don't forget to edit the dependency versions when upgrading.
merb_gems_version = "1.0.12"
dm_gems_version   = "0.10.0"
do_gems_version   = "0.10.0"

# For more information about each component, please read http://wiki.merbivore.com/faqs/merb_components
dependency "extlib", "0.9.13"
dependency "merb-core", merb_gems_version 
dependency "merb-action-args", merb_gems_version
dependency "merb-assets", merb_gems_version  
# dependency("merb-cache", merb_gems_version) do
#   Merb::Cache.setup do
#     register(Merb::Cache::FileStore) unless Merb.cache
#   end
# end
dependency "merb-helpers", merb_gems_version 
# dependency "merb-mailer", merb_gems_version  
dependency "merb-slices", merb_gems_version  
dependency "merb-auth-core", merb_gems_version
dependency "merb-auth-more", merb_gems_version
dependency "merb-auth-slice-password", merb_gems_version
dependency "merb-param-protection", merb_gems_version
# dependency "merb-exceptions", merb_gems_version

dependency "data_objects", do_gems_version
dependency "do_sqlite3", do_gems_version # If using another database, replace this
dependency "dm-core", dm_gems_version         
dependency "dm-aggregates", dm_gems_version   
dependency "dm-timestamps", dm_gems_version  
dependency "dm-validations", dm_gems_version  
# dependency "dm-sweatshop", dm_gems_version
dependency "dm-serializer", dm_gems_version
dependency "dm-pagination", "0.3.7"

dependency "merb_datamapper", merb_gems_version

dependency "teamon-merb-colorful-logger", "0.1.4", :require_as => "merb-colorful-logger"
dependency "teamon-merb-flash", "0.1.4", :require_as => "merb-flash"
dependency "teamon-merb-ext", "0.1.1", :require_as => "merb-ext"
# dependency "merb-ext", "0.1.1"
dependency "mini_magick", "1.2.5"
dependency "rubyzip", "0.9.1", :require_as => "zip/zip"
dependency "RedCloth", "4.2.2"