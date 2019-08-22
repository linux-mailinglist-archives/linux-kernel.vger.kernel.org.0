Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6EA98B25
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 08:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731584AbfHVGCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 02:02:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730758AbfHVGCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 02:02:48 -0400
Received: from localhost.localdomain (unknown [194.230.147.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72F6D21848;
        Thu, 22 Aug 2019 06:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566453768;
        bh=PdtTcSZjjJb+bU2tlX229LVd2lD6fC6ue5lm35NYCHw=;
        h=From:To:Cc:Subject:Date:From;
        b=SJmF9qAvaqsYn+FzYMbnPOQGSw0yFX4dJEP99kmXhonsbnior6Lh8dM8qXSRPR9fE
         3Jiyc78yBhYV3yaCCEcTWIiZxhI+ik3f2BTccYu159tACCncJgANdplrewmdVwDFtv
         rFIPvKANKkuCcLTsKDWAZwd3mWtLeVNL5RDRfKD4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v7 1/4] dt-bindings: vendor-prefixes: Add Anvo-Systems
Date:   Thu, 22 Aug 2019 08:02:35 +0200
Message-Id: <20190822060238.3887-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Anvo-Systems Dresden GmbH.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v4:
None

Changes since v3:
1. Add Rob's tag,
2. Remove Admatec (not needed anymore).

Changes since v2:
1. Use admatecde vendor prefix.
2. Add Anvo-Systems Dresden GmbH.

Changes since v1:
New patch
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6992bbbbffab..519889f5aec8 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -81,6 +81,8 @@ patternProperties:
     description: Analogix Semiconductor, Inc.
   "^andestech,.*":
     description: Andes Technology Corporation
+  "^anvo,.*":
+    description: Anvo-Systems Dresden GmbH
   "^apm,.*":
     description: Applied Micro Circuits Corporation (APM)
   "^aptina,.*":
-- 
2.17.1

