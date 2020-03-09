Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9400517E8E1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 20:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgCITn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 15:43:26 -0400
Received: from v6.sk ([167.172.42.174]:34614 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgCITn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:43:26 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 0EE1561302;
        Mon,  9 Mar 2020 19:43:24 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 06/17] dt-bindings: clock: Add MMP3 compatible string
Date:   Mon,  9 Mar 2020 20:42:43 +0100
Message-Id: <20200309194254.29009-7-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200309194254.29009-1-lkundrak@v3.sk>
References: <20200309194254.29009-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This binding describes the PMUs that are found on MMP3 as well. Add the
compatible strings and adjust the description.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Rob Herring <robh@kernel.org>

---
Changes since v1:
- Collected Rob's Reviewed-by tag

 .../devicetree/bindings/clock/marvell,mmp2-clock.yaml  | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/marvell,mmp2-clock.yaml b/Documentation/devicetree/bindings/clock/marvell,mmp2-clock.yaml
index c5fc2ad0236dd..e2b6ac96bbcb0 100644
--- a/Documentation/devicetree/bindings/clock/marvell,mmp2-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/marvell,mmp2-clock.yaml
@@ -4,14 +4,14 @@
 $id: http://devicetree.org/schemas/clock/marvell,mmp2-clock.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Marvell MMP2 Clock Controller
+title: Marvell MMP2 and MMP3 Clock Controller
 
 maintainers:
   - Lubomir Rintel <lkundrak@v3.sk>
 
 description: |
-  The MMP2 clock subsystem generates and supplies clock to various
-  controllers within the MMP2 SoC.
+  The clock subsystem on MMP2 or MMP3 generates and supplies clock to various
+  controllers within the SoC.
 
   Each clock is assigned an identifier and client nodes use this identifier
   to specify the clock which they consume.
@@ -20,7 +20,9 @@ description: |
 
 properties:
   compatible:
-    const: marvell,mmp2-clock # controller compatible with MMP2 SoC
+    enum:
+      - marvell,mmp2-clock # controller compatible with MMP2 SoC
+      - marvell,mmp3-clock # controller compatible with MMP3 SoC
 
   reg:
     items:
-- 
2.25.1

