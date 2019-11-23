Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3139F108066
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2019 21:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfKWUiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Nov 2019 15:38:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:34312 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726752AbfKWUiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 15:38:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E19C3AEB8;
        Sat, 23 Nov 2019 20:38:08 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v4 1/8] dt-bindings: arm: realtek: Add RTD1195 and MeLE X1000
Date:   Sat, 23 Nov 2019 21:37:52 +0100
Message-Id: <20191123203759.20708-2-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191123203759.20708-1-afaerber@suse.de>
References: <20191123203759.20708-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Realtek RTD1195 SoC and MeLE X1000 TV box.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v1 -> v2 -> v3 -> v4: Unchanged
 
 Documentation/devicetree/bindings/arm/realtek.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/realtek.yaml b/Documentation/devicetree/bindings/arm/realtek.yaml
index ab59de17152d..091616880d25 100644
--- a/Documentation/devicetree/bindings/arm/realtek.yaml
+++ b/Documentation/devicetree/bindings/arm/realtek.yaml
@@ -14,6 +14,12 @@ properties:
     const: '/'
   compatible:
     oneOf:
+      # RTD1195 SoC based boards
+      - items:
+          - enum:
+              - mele,x1000 # MeLE X1000
+          - const: realtek,rtd1195
+
       # RTD1293 SoC based boards
       - items:
           - enum:
-- 
2.16.4

