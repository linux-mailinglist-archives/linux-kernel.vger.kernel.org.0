Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44841123A0B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 23:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfLQW3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 17:29:25 -0500
Received: from gloria.sntech.de ([185.11.138.130]:48036 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbfLQW3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:29:20 -0500
Received: from ip5f5a5f74.dynamic.kabel-deutschland.de ([95.90.95.116] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ihLLA-0001IQ-Gs; Tue, 17 Dec 2019 23:29:16 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     dri-devel@lists.freedesktop.org
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, maxime@cerno.tech,
        heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH v4 1/3] dt-bindings: Add vendor prefix for Xinpeng Technology
Date:   Tue, 17 Dec 2019 23:29:04 +0100
Message-Id: <20191217222906.19943-1-heiko@sntech.de>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

Shenzhen Xinpeng Technology Co., Ltd produces for example display panels.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6046f4555852..85e7c26a05c7 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1056,6 +1056,8 @@ patternProperties:
     description: Extreme Engineering Solutions (X-ES)
   "^xillybus,.*":
     description: Xillybus Ltd.
+  "^xinpeng,.*":
+    description: Shenzhen Xinpeng Technology Co., Ltd
   "^xlnx,.*":
     description: Xilinx
   "^xunlong,.*":
-- 
2.24.0

