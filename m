Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7AEF194B13
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 23:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgCZWCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 18:02:55 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40033 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgCZWCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 18:02:55 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1jHaaS-0006HL-EY; Thu, 26 Mar 2020 23:02:52 +0100
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1jHaaS-0008J5-4t; Thu, 26 Mar 2020 23:02:52 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 6/8] dt-bindings: add vendor prefix for Linux Automation GmbH
Date:   Thu, 26 Mar 2020 23:02:10 +0100
Message-Id: <20200326220213.28632-6-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200326220213.28632-1-a.fatoum@pengutronix.de>
References: <20200326220213.28632-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Automation GmbH[0] was founded in 2019 in order to develop
electronics for embedded Linux. Add its vendor prefix so it may be used
in future board and device compatibles.

[0]: https://www.linux-automation.com

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Robert Schwebel <rsc@linux-automation.com>
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 v1 -> v2:
 - Added Rob's Ack
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9e67944bec9c..bef6841428a2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -561,6 +561,8 @@ patternProperties:
     description: LSI Corp. (LSI Logic)
   "^lwn,.*":
     description: Liebherr-Werk Nenzing GmbH
+  "^lxa,.*":
+    description: Linux Automation GmbH
   "^macnica,.*":
     description: Macnica Americas
   "^mapleboard,.*":
-- 
2.26.0.rc2

