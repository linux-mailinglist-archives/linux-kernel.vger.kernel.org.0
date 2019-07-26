Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 915A675ED3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 08:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfGZGRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 02:17:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfGZGRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 02:17:19 -0400
Received: from localhost.localdomain (unknown [194.230.155.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BED821734;
        Fri, 26 Jul 2019 06:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564121838;
        bh=OO3X7RGhpqesdDNg9GvRiJ4V/WcavvtIxs+nPIOVGaE=;
        h=From:To:Cc:Subject:Date:From;
        b=oTi+BlUjwycnW49mUtrtZBi43I/9I3y7G9lVQZGWUTEI+0OQuUd8HlyHKvlKfM1zI
         7tnjs6liuqnrXs/Ye+2T8gY3x7iKiiNpomNUPaASresnT1d+PquNODCltQt75yheP5
         MsK3WHyXC1leYpOXauv4g8Nu28GzznDRodbGC1dY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: vendor-prefixes: Add Admatec AG
Date:   Fri, 26 Jul 2019 08:17:04 +0200
Message-Id: <20190726061705.14764-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Admatec AG.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
New patch
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6992bbbbffab..94c816f74209 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -43,6 +43,8 @@ patternProperties:
     description: AD Holdings Plc.
   "^adi,.*":
     description: Analog Devices, Inc.
+  "^admatec,.*":
+    description: Admatec AG
   "^advantech,.*":
     description: Advantech Corporation
   "^aeroflexgaisler,.*":
-- 
2.17.1

