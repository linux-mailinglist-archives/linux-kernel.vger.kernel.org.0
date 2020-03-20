Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C85418D616
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 18:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbgCTRlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 13:41:49 -0400
Received: from v6.sk ([167.172.42.174]:51938 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbgCTRlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 13:41:45 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id CA86C61092;
        Fri, 20 Mar 2020 17:41:43 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 09/10] dt-bindings: serial: Move Marvell compatible string to 8250 binding doc
Date:   Fri, 20 Mar 2020 18:41:06 +0100
Message-Id: <20200320174107.29406-10-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320174107.29406-1-lkundrak@v3.sk>
References: <20200320174107.29406-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These ports are compatible with NS8250 and handled by the same driver.
Get rid of the extra document that fails to document the properties that
are actually supported.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 Documentation/devicetree/bindings/serial/8250.txt        | 2 ++
 Documentation/devicetree/bindings/serial/mrvl-serial.txt | 4 ----
 2 files changed, 2 insertions(+), 4 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/mrvl-serial.txt

diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Documentation/devicetree/bindings/serial/8250.txt
index 55700f20f6ee8..a543702859e2f 100644
--- a/Documentation/devicetree/bindings/serial/8250.txt
+++ b/Documentation/devicetree/bindings/serial/8250.txt
@@ -26,6 +26,8 @@ Required properties:
 	- "aspeed,ast2400-vuart"
 	- "aspeed,ast2500-vuart"
 	- "nuvoton,npcm750-uart"
+	- "mrvl,mmp-uart"
+	- "mrvl,pxa-uart"
 	- "serial" if the port type is unknown.
 - reg : offset and length of the register set for the device.
 - interrupts : should contain uart interrupt.
diff --git a/Documentation/devicetree/bindings/serial/mrvl-serial.txt b/Documentation/devicetree/bindings/serial/mrvl-serial.txt
deleted file mode 100644
index d744340de887c..0000000000000
--- a/Documentation/devicetree/bindings/serial/mrvl-serial.txt
+++ /dev/null
@@ -1,4 +0,0 @@
-PXA UART controller
-
-Required properties:
-- compatible : should be "mrvl,mmp-uart" or "mrvl,pxa-uart".
-- 
2.25.1

