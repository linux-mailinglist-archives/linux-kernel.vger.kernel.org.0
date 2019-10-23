Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAD5E1B1A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 14:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391740AbfJWMog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 08:44:36 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:52110 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391712AbfJWMo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:44:28 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6B6DDC08DD;
        Wed, 23 Oct 2019 12:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1571834667; bh=E8g39bo7xM+VQE70QKbT9O0p8rPYtJ1LN4ovj5afXJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P3vHRqK9YyBTGlfngyd0pcURocD1QogvCpA3c1brd3p6FopwFBcfh5reLnxfvsw/V
         0owo2qG3N+YtHG93tYxLMUIQM7jOmXbSlHCXwI0SljlTlRWQ9XXGYCLui4A2r6ES/W
         zCAzik01+QecObKeZPFLdryWlxRuqBtJ3OT4pLd+5wSNQ83crq0UxQt7nMTgABAdgo
         3pGhpiG59FMtQdccX7RKGdqroC8jfqbMwP4rlIZfXp8GLdXECN+93n8sScQJjCwRHV
         is26pe88JE8xdBrYl+PgWhiEtLhrt6oH1allMKHFQEQJbWc+RidTTilj0pLVkNZxZy
         1C7IqOAdGZpIA==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.73])
        by mailhost.synopsys.com (Postfix) with ESMTP id D17D9A0057;
        Wed, 23 Oct 2019 12:44:25 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 8/8] ARC: nSIM_700: remove unused network options
Date:   Wed, 23 Oct 2019 15:44:17 +0300
Message-Id: <20191023124417.5770-9-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191023124417.5770-1-Eugeniy.Paltsev@synopsys.com>
References: <20191023124417.5770-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have snps,arc-emac enabled in nSIM_700. It's obsolete and it's
not used anymore so remove its device tree node and disable
unused network options in defconfig.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/boot/dts/nsim_700.dts      | 16 ----------------
 arch/arc/configs/nsim_700_defconfig |  4 ++--
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/arch/arc/boot/dts/nsim_700.dts b/arch/arc/boot/dts/nsim_700.dts
index ae9bc21fe11b..f8832a15e174 100644
--- a/arch/arc/boot/dts/nsim_700.dts
+++ b/arch/arc/boot/dts/nsim_700.dts
@@ -52,22 +52,6 @@
 			no-loopback-test = <1>;
 		};
 
-		ethernet@c0fc2000 {
-			compatible = "snps,arc-emac";
-			reg = <0xc0fc2000 0x3c>;
-			interrupts = <6>;
-			mac-address = [ 00 11 22 33 44 55 ];
-			clock-frequency = <80000000>;
-			max-speed = <100>;
-			phy = <&phy0>;
-
-			#address-cells = <1>;
-			#size-cells = <0>;
-			phy0: ethernet-phy@0 {
-				reg = <1>;
-			};
-		};
-
 		arcpct0: pct {
 			compatible = "snps,arc700-pct";
 		};
diff --git a/arch/arc/configs/nsim_700_defconfig b/arch/arc/configs/nsim_700_defconfig
index 5c488140f537..326f6cde7826 100644
--- a/arch/arc/configs/nsim_700_defconfig
+++ b/arch/arc/configs/nsim_700_defconfig
@@ -35,8 +35,8 @@ CONFIG_DEVTMPFS=y
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 # CONFIG_BLK_DEV is not set
 CONFIG_NETDEVICES=y
-CONFIG_ARC_EMAC=y
-CONFIG_LXT_PHY=y
+# CONFIG_ETHERNET is not set
+# CONFIG_WLAN is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
-- 
2.21.0

