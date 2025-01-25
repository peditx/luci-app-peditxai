include $(TOPDIR)/rules.mk

PKG_NAME:=peditxai
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/peditxai
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=PeDitXai - Chat with DeepSeek
  DEPENDS:=+curl +luci
endef

define Package/peditxai/description
  A package to integrate DeepSeek chat with OpenWrt, featuring a settings page for API key configuration.
endef

define Build/Prepare
    mkdir -p $(PKG_BUILD_DIR)
    $(CP) ./src/* $(PKG_BUILD_DIR)/
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/peditxai/install
    $(INSTALL_DIR) $(1)/etc/config
    $(INSTALL_CONF) ./files/etc/config/peditxai $(1)/etc/config/

    $(INSTALL_DIR) $(1)/etc/init.d
    $(INSTALL_BIN) ./files/etc/init.d/peditxai $(1)/etc/init.d/

    $(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
    $(INSTALL_DATA) ./files/usr/lib/lua/luci/controller/peditxai.lua $(1)/usr/lib/lua/luci/controller/

    $(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/peditxai
    $(INSTALL_DATA) ./files/usr/lib/lua/luci/model/cbi/peditxai/settings.lua $(1)/usr/lib/lua/luci/model/cbi/peditxai/

    $(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/peditxai
    $(INSTALL_DATA) ./files/usr/lib/lua/luci/view/peditxai/chat.htm $(1)/usr/lib/lua/luci/view/peditxai/
    $(INSTALL_DATA) ./files/usr/lib/lua/luci/view/peditxai/chat.js $(1)/usr/lib/lua/luci/view/peditxai/

    $(INSTALL_DIR) $(1)/www/cgi-bin
    $(INSTALL_BIN) ./files/www/cgi-bin/peditxai_chat.sh $(1)/www/cgi-bin/

    $(INSTALL_DIR) $(1)/www/css
    $(INSTALL_DATA) ./files/www/css/peditxai.css $(1)/www/css/
endef

$(eval $(call BuildPackage,peditxai))
