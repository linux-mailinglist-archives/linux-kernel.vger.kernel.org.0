Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2098DF11D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 17:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbfJUPTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 11:19:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:32880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfJUPS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:18:59 -0400
Received: from localhost.localdomain (unknown [194.230.155.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 630512084B;
        Mon, 21 Oct 2019 15:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571671139;
        bh=pZPt95h86j2DHhnebWftea1csHW0nl72tOQFiaF7e7s=;
        h=From:To:Cc:Subject:Date:From;
        b=B+V5q5QOX1c1zdAcO+okPLxM00nUGbUp/oXP1f+mDySsn0k+0Oj7M+RxFdLWyYgpI
         l0d6LFMNu9gjvDJarn1j3+DhSHNH0rV6RQmhvYtfi/9UtpTeac83PnxpulmStAiFE6
         kUjEzAZSQjPsWvX23l+UNISYTzMdxvnP40evQXJM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] dt-bindings: display: st,stm32-dsi: Fix white spaces
Date:   Mon, 21 Oct 2019 17:18:47 +0200
Message-Id: <20191021151847.13891-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded indentation in blank line and space at end of line.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/display/st,stm32-dsi.yaml  | 2 +-
 Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/st,stm32-dsi.yaml b/Documentation/devicetree/bindings/display/st,stm32-dsi.yaml
index de6c99198cbe..3be76d15bf6c 100644
--- a/Documentation/devicetree/bindings/display/st,stm32-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/st,stm32-dsi.yaml
@@ -108,7 +108,7 @@ examples:
         resets = <&rcc DSI_R>;
         reset-names = "apb";
         phy-dsi-supply = <&reg18>;
-        
+
         #address-cells = <1>;
         #size-cells = <0>;
 
diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml b/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
index a40197ab281e..bf8ad916e9b0 100644
--- a/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
+++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
@@ -37,7 +37,7 @@ properties:
   port:
     type: object
     description:
-      "Video port for DPI RGB output. 
+      "Video port for DPI RGB output.
       ltdc has one video port with up to 2 endpoints:
       - for external dpi rgb panel or bridge, using gpios.
       - for internal dpi input of the MIPI DSI host controller.
-- 
2.17.1

