Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9811A10D1D4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2019 08:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfK2HeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Nov 2019 02:34:07 -0500
Received: from mail-eopbgr730098.outbound.protection.outlook.com ([40.107.73.98]:32294
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726360AbfK2HeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 02:34:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVNkYhk1JpZ78z6HIQb+zfHcqImuYpmvR6o93cujZHHJWmY/GKGq9f4hVJEPmCCaNUIXcdejdiZv+9+b0gu7JaEX9fdrwD5Ojqbqg9tRyothgrK8p4m5pxyLXL5uAem9MeWsupnHmXYsAfKElZ1xf7Yfn1O7Kas4/6bhg6EwdtFMeFoDTHQMLUsADIos7FKwmYj+xHH1nYtMVg5MRZYnxp8oTecbrAU0msNBUdqtyt8i66VO9GfVupELXVzqqgzWAZtJqT8fPt76talbmvp/4rPOXE7n46ak/YS6s9g8GgtxCZjB7ZG8Bto54v9gtwKJpZJ6afhSQZZLDG5Hp3a0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5+GYu9VYFD1uOnMGbRWIfFjJqLaFA4oX3QHgEOliP0=;
 b=jaHyfTXYdWEwERLWR3+HFtmeadAP3lTsP2C/HuuCFDR4DUgo08lizWvrQqyOGNJvOdqZUGadG15Pk299hnfcM5qtip8LUVnreOXrwjJsGU7BcqzajXo62UUsSseG7N+FbadxJaL9L//qLukx0qUi7ntx42CpFSL3Y/hgZragV+XFoga4svhEc6FgEL3OZvAE1xEIy5hb6Fh6pK02CmtioxVxK6k6N5uVcJlyj1cKoG4AzytFoM2PAYtu9nQjI0Urj85Xz1zfgDLWp6LIL7N7a/2tMdbUFQ5rI0AuXb+1aI25xpe2wyC0j1KlgNWLqHF2w17mOMv6Fe9NeOkSViFfQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5+GYu9VYFD1uOnMGbRWIfFjJqLaFA4oX3QHgEOliP0=;
 b=lVkSrMaL5pL0YdrsMZqqBeldzXAEeuYVd6qZibwgFzzfPmYg6XBBVeCRtosKR3HpJRB/L4X8vaTQUqWRfhVcqY9j/D8ZyM1rDTPJF79T/YAhcp5WeVvIuZwQh/flQygIyN2K0XPqvZPZfnlJpz7R7p67ZD594+THc/3n5yOVp+8=
Received: from SN6PR04MB4543.namprd04.prod.outlook.com (52.135.120.29) by
 SN6PR04MB4606.namprd04.prod.outlook.com (52.135.120.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Fri, 29 Nov 2019 07:34:03 +0000
Received: from SN6PR04MB4543.namprd04.prod.outlook.com
 ([fe80::859:2d31:1f00:fa16]) by SN6PR04MB4543.namprd04.prod.outlook.com
 ([fe80::859:2d31:1f00:fa16%5]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 07:34:03 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>
CC:     Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Sheng Pan <span@analogixsemi.com>
Subject: [PATCH v6 1/2] dt-bindings: drm/bridge: anx7625: MIPI to DP
 transmitter binding
Thread-Topic: [PATCH v6 1/2] dt-bindings: drm/bridge: anx7625: MIPI to DP
 transmitter binding
Thread-Index: AQHVpodfM9pIQWhfxUGYdHn9Ng0hsQ==
Date:   Fri, 29 Nov 2019 07:34:03 +0000
Message-ID: <67ccead807b7d0a50df479cab2c9d325041224bc.1575012508.git.xji@analogixsemi.com>
References: <cover.1575012508.git.xji@analogixsemi.com>
In-Reply-To: <cover.1575012508.git.xji@analogixsemi.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:202:16::22) To SN6PR04MB4543.namprd04.prod.outlook.com
 (2603:10b6:805:a8::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xji@analogixsemi.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [114.247.245.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8111e855-5496-406f-df40-08d7749e81eb
x-ms-traffictypediagnostic: SN6PR04MB4606:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB46065716B84A2B0313FF33FAC7460@SN6PR04MB4606.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(39850400004)(396003)(136003)(189003)(199004)(76176011)(6512007)(478600001)(36756003)(5660300002)(25786009)(107886003)(6486002)(256004)(6506007)(446003)(186003)(2501003)(8936002)(11346002)(4326008)(2616005)(99286004)(86362001)(81156014)(81166006)(8676002)(52116002)(110136005)(2906002)(7416002)(66476007)(64756008)(3846002)(54906003)(305945005)(66946007)(66446008)(102836004)(66066001)(71190400001)(6436002)(316002)(6116002)(14454004)(66556008)(386003)(118296001)(26005)(7736002)(6306002)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4606;H:SN6PR04MB4543.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analogixsemi.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jAStlCs1pTodvE8lnjqXxjZrrXbWzLZD42Sksq/fFWIh6PkTtrTjOnGt+LNq5TnkxbRewNO5RIt5SQIG6xu5+LU88Nd31J7NChHFKEezVoi8umguZuojxcPrrmIjyj9Yf/8JIpqD5g5AVNybO2I1e19DcvYSX5700xCmVK10ubLICzOBAhQ52YU8Ac/4HyAkDCIpKWTcTUk3lV/eL5xXn6e1ANsPY2n36XHj3Cj17ePsUV2EWt7zfPnqAXX9R95s2FlnXaoWYOkfqUHKmgjIy3fuk0VAz0MfGlKJzlmLxNRyMIG7zp0m8SsLXEae+eRL6bFF60rqmlFaJzZElA5NHybkm/DkMWSm8M3sO9qIkU5yyYUDKWGk8hnoXY+md3PqjB8ksVEPbwNXFEWnjG6oEfuzMemGpaGx/riajcO/LGXGY5zSscE4V56gVOnl2CnUgTIRnmZDiW/X7RAUTl/uAGu3KLZ6msLmravDzzRsBSs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1FB9F5F8891DEE4BAD5C4268094E75EE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8111e855-5496-406f-df40-08d7749e81eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 07:34:03.2986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fgcw2jkhma+7cMyePMSRSDaS4N0E7kB4OcyoP7RH9kIDo2TZZRNgNXrwqm1hhhFSuP0DpphzNeQnFZP4OA4oYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4606
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ANX7625 is an ultra-low power 4K Mobile HD Transmitter designed
for portable device. It converts MIPI to DisplayPort 1.3 4K.

You can add support to your board with binding.

Example:
	anx7625_bridge: encoder@58 {
		compatible =3D "analogix,anx7625";
		reg =3D <0x58>;
		status =3D "okay";
		panel-flags =3D <1>;
		enable-gpios =3D <&pio 45 GPIO_ACTIVE_HIGH>;
		reset-gpios =3D <&pio 73 GPIO_ACTIVE_HIGH>;
		#address-cells =3D <1>;
		#size-cells =3D <0>;

		port@0 {
		  reg =3D <0>;
		  anx_1_in: endpoint {
		    remote-endpoint =3D <&mipi_dsi>;
		  };
		};

		port@2 {
		  reg =3D <2>;
		  anx_1_out: endpoint {
		    remote-endpoint =3D <&panel_in>;
		  };
		};
	};

Signed-off-by: Xin Ji <xji@analogixsemi.com>
---
 .../bindings/display/bridge/anx7625.yaml           | 91 ++++++++++++++++++=
++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/anx762=
5.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/anx7625.yaml =
b/Documentation/devicetree/bindings/display/bridge/anx7625.yaml
new file mode 100644
index 0000000..1149ebb
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/anx7625.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019 Analogix Semiconductor, Inc.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/display/bridge/anx7625.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Analogix ANX7625 SlimPort (4K Mobile HD Transmitter)
+
+maintainers:
+  - Xin Ji <xji@analogixsemi.com>
+
+description: |
+  The ANX7625 is an ultra-low power 4K Mobile HD Transmitter
+  designed for portable devices.
+
+properties:
+  "#address-cells": true
+  "#size-cells": true
+
+  compatible:
+    items:
+      - const: analogix,anx7625
+
+  reg:
+    maxItems: 1
+
+  panel-flags:
+    description: indicate the panel is internal or external.
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  enable-gpios:
+    description: used for power on chip control, POWER_EN pin D2.
+    maxItems: 1
+
+  reset-gpios:
+    description: used for reset chip control, RESET_N pin B7.
+    maxItems: 1
+
+  port@0:
+    type: object
+    description:
+      A port node pointing to MIPI DSI host port node.
+
+  port@1:
+    type: object
+    description:
+      A port node pointing to MIPI DPI host port node.
+
+  port@2:
+    type: object
+    description:
+      A port node pointing to panel port node.
+
+required:
+  - "#address-cells"
+  - "#size-cells"
+  - compatible
+  - reg
+  - port@0
+  - port@2
+
+example:
+  - |
+    anx7625_bridge: encoder@58 {
+        compatible =3D "analogix,anx7625";
+        reg =3D <0x58>;
+        status =3D "okay";
+        panel-flags =3D <1>;
+        enable-gpios =3D <&pio 45 GPIO_ACTIVE_HIGH>;
+        reset-gpios =3D <&pio 73 GPIO_ACTIVE_HIGH>;
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        port@0 {
+          reg =3D <0>;
+          anx_1_in: endpoint {
+            remote-endpoint =3D <&mipi_dsi>;
+          };
+        };
+
+        port@2 {
+          reg =3D <2>;
+          anx_1_out: endpoint {
+            remote-endpoint =3D <&panel_in>;
+          };
+        };
+    };
--=20
2.7.4

