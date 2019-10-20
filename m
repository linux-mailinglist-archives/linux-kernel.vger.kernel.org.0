Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED6BDDC43
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2019 06:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfJTEIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Oct 2019 00:08:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:37192 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726303AbfJTEIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 00:08:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C69D2B2EA;
        Sun, 20 Oct 2019 04:08:28 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        info@synology.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] dt-bindings: arm: realtek: Document RTD1296 and Synology DS418
Date:   Sun, 20 Oct 2019 06:08:16 +0200
Message-Id: <20191020040817.16882-8-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191020040817.16882-1-afaerber@suse.de>
References: <20191020040817.16882-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define compatible strings for Realtek RTD1296 SoC and Synology
DiskStation DS418 NAS.

Cc: info@synology.com
Acked-by: Rob Herring <robh@kernel.org>
[AF: Converted to json-schema]
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v1 -> v2:
 * Converted to YAML schema
 
 Documentation/devicetree/bindings/arm/realtek.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/realtek.yaml b/Documentation/devicetree/bindings/arm/realtek.yaml
index 6ea3a79825cc..ab59de17152d 100644
--- a/Documentation/devicetree/bindings/arm/realtek.yaml
+++ b/Documentation/devicetree/bindings/arm/realtek.yaml
@@ -27,4 +27,10 @@ properties:
               - probox2,ava # ProBox2 AVA
               - zidoo,x9s # Zidoo X9S
           - const: realtek,rtd1295
+
+      # RTD1296 SoC based boards
+      - items:
+          - enum:
+              - synology,ds418 # Synology DiskStation DS418
+          - const: realtek,rtd1296
 ...
-- 
2.16.4

