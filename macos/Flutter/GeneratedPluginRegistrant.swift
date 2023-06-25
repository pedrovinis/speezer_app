//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import app_links
import protocol_handler
import screen_retriever
import url_launcher_macos
import window_manager

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  AppLinksMacosPlugin.register(with: registry.registrar(forPlugin: "AppLinksMacosPlugin"))
  ProtocolHandlerPlugin.register(with: registry.registrar(forPlugin: "ProtocolHandlerPlugin"))
  ScreenRetrieverPlugin.register(with: registry.registrar(forPlugin: "ScreenRetrieverPlugin"))
  UrlLauncherPlugin.register(with: registry.registrar(forPlugin: "UrlLauncherPlugin"))
  WindowManagerPlugin.register(with: registry.registrar(forPlugin: "WindowManagerPlugin"))
}
