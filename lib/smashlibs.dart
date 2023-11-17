library smashlibs;

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:path/path.dart' as PATH;
import 'package:after_layout/after_layout.dart';
import 'package:dart_hydrologis_db/dart_hydrologis_db.dart';
import 'package:dart_hydrologis_utils/dart_hydrologis_utils.dart' as HU;
import 'package:dart_jts/dart_jts.dart' as JTS;
import 'package:device_info_plus/device_info_plus.dart'
    if (dart.library.html) 'web_stubs.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/gestures.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:proj4dart/proj4dart.dart' as proj4dart;
import 'package:flutter_screen_wake/flutter_screen_wake.dart';
import 'package:share_extend/share_extend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smashlibs/com/hydrologis/flutterlibs/utils/logging.dart';
import 'package:smashlibs/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wkt_parser/wkt_parser.dart' as wkt_parser;
import 'package:collection/collection.dart';
import 'package:flutter_map/flutter_map.dart' hide Projection;
import 'package:flutter_map/flutter_map.dart' as FM;
import 'package:flutter_map/src/core/bounds.dart';
import 'package:flutter_map/src/map/flutter_map_state.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:mapsforge_flutter/core.dart';
import 'package:mapsforge_flutter/datastore.dart';
import 'package:mapsforge_flutter/maps.dart' hide Projection;
import 'package:mapsforge_flutter/src/graphics/implementation/fluttertilebitmap.dart';
import 'package:mapsforge_flutter/src/layer/job/job.dart';
import 'package:mapsforge_flutter/src/layer/job/jobresult.dart';
import 'package:synchronized/synchronized.dart';
import 'package:gpx/gpx.dart' hide Bounds;
import 'package:rainbow_color/rainbow_color.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:image/image.dart' as IMG;
import 'package:geoimage/geoimage.dart';
import 'package:dart_postgis/dart_postgis.dart';
import 'package:flutter_geopackage/flutter_geopackage.dart' as GPKG;
import 'package:dart_shp/dart_shp.dart' as SHP;
import 'package:url_launcher/url_launcher_string.dart';
import 'package:geojson_vi/geojson_vi.dart' as GEOJSON;
import 'package:flutter_map_dragmarker/flutter_map_dragmarker.dart';
import 'package:flutter_map_line_editor/flutter_map_line_editor.dart';
import 'package:badges/badges.dart' as badges;
import 'package:tuple/tuple.dart';
import 'package:http/http.dart' as HTTP;
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart'
    hide ImageSource;

part 'com/hydrologis/dartlibs/dartlibs.dart';
part 'com/hydrologis/flutterlibs/camera/camera.dart';
part 'com/hydrologis/flutterlibs/gps/gps.dart';
part 'com/hydrologis/flutterlibs/filesystem/filemanagement.dart';
part 'com/hydrologis/flutterlibs/filesystem/workspace.dart';
part 'com/hydrologis/flutterlibs/gss/gss_server_api.dart';
part 'com/hydrologis/flutterlibs/gss/gss_utilities.dart';
part 'com/hydrologis/flutterlibs/forms/forms.dart';
part 'com/hydrologis/flutterlibs/forms/forms_widgets.dart';
part 'com/hydrologis/flutterlibs/network/download_file_listtile.dart';
part 'com/hydrologis/flutterlibs/network/download_file_progress.dart';
part 'com/hydrologis/flutterlibs/network/network_helper.dart';
part 'com/hydrologis/flutterlibs/theme/colors.dart';
part 'com/hydrologis/flutterlibs/theme/icons.dart';
part 'com/hydrologis/flutterlibs/theme/theme.dart';
part 'com/hydrologis/flutterlibs/ui/dialogs.dart';
part 'com/hydrologis/flutterlibs/ui/progress.dart';
part 'com/hydrologis/flutterlibs/ui/sld.dart';
part 'com/hydrologis/flutterlibs/ui/tables.dart';
part 'com/hydrologis/flutterlibs/ui/ui.dart';
part 'com/hydrologis/flutterlibs/utils/device.dart';
part 'com/hydrologis/flutterlibs/utils/permissions.dart';
part 'com/hydrologis/flutterlibs/utils/preferences.dart';
part 'com/hydrologis/flutterlibs/utils/projection.dart';
part 'com/hydrologis/flutterlibs/utils/elevcolor.dart';
part 'com/hydrologis/flutterlibs/utils/elevation.dart';
part 'com/hydrologis/flutterlibs/utils/screen.dart';
part 'com/hydrologis/flutterlibs/utils/notifier.dart';
part 'com/hydrologis/flutterlibs/utils/share.dart';
part 'com/hydrologis/flutterlibs/utils/validators.dart';
part 'com/hydrologis/flutterlibs/projectdb/project_db.dart';
part 'com/hydrologis/flutterlibs/projectdb/images.dart';
part 'com/hydrologis/flutterlibs/projectdb/logs.dart';
part 'com/hydrologis/flutterlibs/projectdb/notes.dart';
part 'com/hydrologis/flutterlibs/projectdb/othertables.dart';

// maps
part 'com/hydrologis/flutterlibs/maps/mapview.dart';
part 'com/hydrologis/flutterlibs/maps/toolbar_tools.dart';
part 'com/hydrologis/flutterlibs/maps/models/map_state.dart';
part 'com/hydrologis/flutterlibs/maps/tools/ruler_state.dart';
part 'com/hydrologis/flutterlibs/maps/tools/info_tool_state.dart';
part 'com/hydrologis/flutterlibs/maps/tools/geometryeditor_state.dart';
part 'com/hydrologis/flutterlibs/maps/tools/feature_attributes_viewer.dart';
part 'com/hydrologis/flutterlibs/maps/tools/tools.dart';
part 'com/hydrologis/flutterlibs/maps/models/mapbuilder.dart';
part 'com/hydrologis/flutterlibs/maps/layersource.dart';
part 'com/hydrologis/flutterlibs/maps/layermanager.dart';
part 'com/hydrologis/flutterlibs/maps/layer.dart';
part 'com/hydrologis/flutterlibs/maps/layers/mapsforge.dart';
part 'com/hydrologis/flutterlibs/maps/layers/tiles.dart';
part 'com/hydrologis/flutterlibs/maps/layers/wms.dart';
part 'com/hydrologis/flutterlibs/maps/layers/gpx.dart';
part 'com/hydrologis/flutterlibs/maps/layers/mbtiles.dart';
part 'com/hydrologis/flutterlibs/maps/layers/postgis.dart';
part 'com/hydrologis/flutterlibs/maps/layers/geoimage.dart';
part 'com/hydrologis/flutterlibs/maps/layers/geopackage.dart';
part 'com/hydrologis/flutterlibs/maps/layers/shapefile.dart';
part 'com/hydrologis/flutterlibs/maps/layers/geocaching.dart';
part 'com/hydrologis/flutterlibs/maps/layers/geojson.dart';
part 'com/hydrologis/flutterlibs/maps/plugins/pluginshandler.dart';
part 'com/hydrologis/flutterlibs/maps/plugins/center_cross_plugin.dart';
part 'com/hydrologis/flutterlibs/maps/plugins/ruler_plugin.dart';
part 'com/hydrologis/flutterlibs/maps/plugins/scale_plugin.dart';
part 'com/hydrologis/flutterlibs/maps/plugins/feature_info_plugin.dart';
part 'com/hydrologis/flutterlibs/maps/utils.dart';
part 'com/hydrologis/flutterlibs/utils/experimentals.dart';
