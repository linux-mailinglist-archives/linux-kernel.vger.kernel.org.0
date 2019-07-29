Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9F9791ED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 19:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387588AbfG2RUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 13:20:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387518AbfG2RUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 13:20:19 -0400
Received: from localhost.localdomain (unknown [194.230.155.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4826B206BA;
        Mon, 29 Jul 2019 17:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564420818;
        bh=SE7D4UW949P+LhXzehMT6r003HA4cD5w+3etvxplmHs=;
        h=From:To:Cc:Subject:Date:From;
        b=uUcJ1kpkTOuUtrrS4TyO6Vq2XZw/h+h3iTHlcQDzTnw1jVo5jyeRYdLVIWBGo+U04
         W3gwImWmXA1veYvQqTuH1eTgyuVjRNo0Qws2FNwyjKREPQFLbdVbcxgxNOxElKtIsS
         NF0WSvI4koRYwgzX+fUjuCgT7mb5EQHuMz9HR5eo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: vendor-prefixes: Add Admatec GmbH and Anvo-Systems
Date:   Mon, 29 Jul 2019 19:20:06 +0200
Message-Id: <20190729172007.3275-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Admatec GmbH (not to be confused with Admatec AG
in Switzerland) and Anvo-Systems Dresden GmbH.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v2:
1. Use admatecde vendor prefix.
2. Add Anvo-Systems Dresden GmbH.

Changes since v1:
New patch
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6992bbbbffab..2a644fb01bb4 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -43,6 +43,8 @@ patternProperties:
     description: AD Holdings Plc.
   "^adi,.*":
     description: Analog Devices, Inc.
+  "^admatecde,.*":
+    description: Admatec GmbH
   "^advantech,.*":
     description: Advantech Corporation
   "^aeroflexgaisler,.*":
@@ -81,6 +83,8 @@ patternProperties:
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

