Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0BDE35DA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 16:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409449AbfJXOov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 10:44:51 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:45782 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407467AbfJXOov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 10:44:51 -0400
Received: from ramsan ([84.195.182.253])
        by michel.telenet-ops.be with bizsmtp
        id HSkp210095USYZQ06SkprT; Thu, 24 Oct 2019 16:44:49 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNeM5-0006kY-3X; Thu, 24 Oct 2019 16:44:49 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNeM5-0007EU-1v; Thu, 24 Oct 2019 16:44:49 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] ARM: dts: imx53: Spelling s/configration/configuration/
Date:   Thu, 24 Oct 2019 16:44:43 +0200
Message-Id: <20191024144443.27761-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix misspelling of "configuration".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/imx53-usbarmory.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-usbarmory.dts b/arch/arm/boot/dts/imx53-usbarmory.dts
index ee6263d1c2d3ddf4..f34993a490ee86cb 100644
--- a/arch/arm/boot/dts/imx53-usbarmory.dts
+++ b/arch/arm/boot/dts/imx53-usbarmory.dts
@@ -120,7 +120,7 @@
 	};
 
 	/*
-	 * UART mode pin header configration
+	 * UART mode pin header configuration
 	 * 3 - GPIO5[26], pull-down 100K
 	 * 4 - GPIO5[27], pull-down 100K
 	 * 5 - TX, pull-up 100K
-- 
2.17.1

