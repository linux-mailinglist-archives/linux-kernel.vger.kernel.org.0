Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1FFF10254A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 14:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfKSNWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 08:22:21 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:54534 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726736AbfKSNWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 08:22:20 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B6AADC04B5;
        Tue, 19 Nov 2019 13:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1574169740; bh=9QTEGRJcENaTi4DjOhtqNfA9DLY6BKQ15SnmReiHuB4=;
        h=From:To:Cc:Subject:Date:From;
        b=h6pv1IqIiYSRosFwWcL9Y+mun2ub/7SAcdBddKlWlqWdgNbSrHnrGxJvr7Fdh8lxt
         RlfiUGHKpA9IQvSUAx1wMgZ8dQDOJHhsT4IyfiKrFs3HUMywbecEszAj/OO6kqPNKr
         JFlWEBfi1LliZqd0mJw5rKmmZ2racZd/ybCRDYBRz5GDCL6r0Lf31RurcFje4AVK7c
         u0vxo3udik9oYU//V59MrWRktKSsSTj0V4FKf2Me0Gvv+48J0ry4lD8eMjG/5SDi6q
         bcmTML84gsYdsrqtHIwssmvN1Yc1hk3Bnzmu2T/7mR+qfQPSlocCFv7LodBSr7JGqi
         /Em4qBduCxt1A==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.76])
        by mailhost.synopsys.com (Postfix) with ESMTP id 8D60CA005D;
        Tue, 19 Nov 2019 13:22:17 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 1/2] ARC: [plat-axs10x]: use pgu pll instead of fixed clock
Date:   Tue, 19 Nov 2019 16:22:14 +0300
Message-Id: <20191119132215.3011-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use PLL driver instead of fixed-clock for PGU pixel clock.
That allows us to support wider range of graphic modes.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/boot/dts/axs10x_mb.dtsi | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arc/boot/dts/axs10x_mb.dtsi b/arch/arc/boot/dts/axs10x_mb.dtsi
index 08bcfed6b80f..f9a5c9ddcae7 100644
--- a/arch/arc/boot/dts/axs10x_mb.dtsi
+++ b/arch/arc/boot/dts/axs10x_mb.dtsi
@@ -61,12 +61,13 @@
 				clock-frequency = <25000000>;
 				#clock-cells = <0>;
 			};
+		};
 
-			pguclk: pguclk {
-				#clock-cells = <0>;
-				compatible = "fixed-clock";
-				clock-frequency = <74250000>;
-			};
+		pguclk: pguclk@10080 {
+			compatible = "snps,axs10x-pgu-pll-clock";
+			reg = <0x10080 0x10>, <0x110 0x10>;
+			#clock-cells = <0>;
+			clocks = <&input_clk>;
 		};
 
 		gmac: ethernet@18000 {
-- 
2.21.0

