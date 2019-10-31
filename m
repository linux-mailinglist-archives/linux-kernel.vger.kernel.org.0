Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54A61EBA45
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 00:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfJaXQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 19:16:35 -0400
Received: from palmtree.beeroclock.net ([178.79.160.154]:43064 "EHLO
        palmtree.beeroclock.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJaXQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 19:16:34 -0400
X-Greylist: delayed 308 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Oct 2019 19:16:34 EDT
Received: from beros.lan (89-160-129-47.du.xdsl.is [89.160.129.47])
        by palmtree.beeroclock.net (Postfix) with ESMTPSA id 1AADE1F691;
        Thu, 31 Oct 2019 23:11:25 +0000 (UTC)
From:   Karl Palsson <karlp@tweak.net.au>
To:     mripard@kernel.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Karl Palsson <karlp@tweak.net.au>
Subject: [PATCH 1/3] ARM: dts: sunxi: h3/h5: add missing uart2 rts/cts pins
Date:   Thu, 31 Oct 2019 23:11:02 +0000
Message-Id: <20191031231104.30725-1-karlp@tweak.net.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uart1 and uart3 had existing pin definitions for the rts/cts pairs.
Add definitions for uart2 as well.

Signed-off-by: Karl Palsson <karlp@tweak.net.au>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 84977d4eb97a..2d8637300321 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -472,6 +472,11 @@
 				function = "uart2";
 			};
 
+			uart2_rts_cts_pins: uart2-rts-cts-pins {
+				pins = "PA2", "PA3";
+				function = "uart2";
+			};
+
 			uart3_pins: uart3-pins {
 				pins = "PA13", "PA14";
 				function = "uart3";
-- 
2.20.1

