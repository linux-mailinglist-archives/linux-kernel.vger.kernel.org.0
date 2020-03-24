Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7444191411
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 16:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgCXPTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 11:19:43 -0400
Received: from v6.sk ([167.172.42.174]:58138 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbgCXPTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:19:43 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id C2DBE60EEE;
        Tue, 24 Mar 2020 15:19:41 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: Add vendor prefix for Chrontel, Inc.
Date:   Tue, 24 Mar 2020 16:19:29 +0100
Message-Id: <20200324151931.449985-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200324151931.449985-1-lkundrak@v3.sk>
References: <20200324151931.449985-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chrontel makes encoders for video displays and perhaps other stuff.
Their web site is http://www.chrontel.com/.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Rob Herring <robh@kernel.org>

---
Changes since v1:
- Collect Rob's ack

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a2da166df1bc7..0ab86d876f4d2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -185,6 +185,8 @@ patternProperties:
     description: ChipOne
   "^chipspark,.*":
     description: ChipSPARK
+  "^chrontel,.*":
+    description: Chrontel, Inc.
   "^chrp,.*":
     description: Common Hardware Reference Platform
   "^chunghwa,.*":
-- 
2.26.0.rc2

