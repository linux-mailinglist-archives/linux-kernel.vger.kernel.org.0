Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44ED313DA9B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 13:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgAPMvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 07:51:41 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:25746 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgAPMvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 07:51:41 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 00GCp0LN004484;
        Thu, 16 Jan 2020 21:51:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 00GCp0LN004484
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1579179062;
        bh=KmqleiAw0MVSjh4HEf5T+ImDC/VDq4dszju/GsZ7wC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FBL346imjwYWy9xiVxhENfVVWXygIiVFIdVxSwSDCULelopHtV1UMIJbA4nzIcwv5
         81WTYEh3s/NKoi7hnQjCKpogpRoZGPQS0jT8LROSuWYVvK289EXjXdysnhyEnSTj6s
         6zoubgPv6J32r8ptB4y6W0FIMI5NUhgQziGc5TMezy11ZgHKyRYINP9hHa7lyytlgv
         Zk+6Uzkx6SQrcBVBwKCb4zarPV4yVKf2C/uWiCwwf/242u04mapoVNZ57DBUA2oVEP
         AZkIMQpaEXgJTUDDWwVqEFXR4f37a9wJUGxRUlrhrV7nqFi6p/mC5rErPtx7rPnZvk
         tKoLkL3SWr3EQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: uniphier: add reset-names to NAND controller node
Date:   Thu, 16 Jan 2020 21:50:45 +0900
Message-Id: <20200116125045.17581-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116125045.17581-1-yamada.masahiro@socionext.com>
References: <20200116125045.17581-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Denali NAND controller IP has separate reset control for the
controller core and registers.

Add the reset-names, and one more phandle accordingly. This is the
approved DT-binding.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 3 ++-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 3 ++-
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index 8ec40a0b8b1e..5b18bda9c5a6 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -633,7 +633,8 @@
 			pinctrl-0 = <&pinctrl_nand>;
 			clock-names = "nand", "nand_x", "ecc";
 			clocks = <&sys_clk 2>, <&sys_clk 3>, <&sys_clk 3>;
-			resets = <&sys_rst 2>;
+			reset-names = "nand", "reg";
+			resets = <&sys_rst 2>, <&sys_rst 2>;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index b658f2b641e2..f2dc5f695020 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -937,7 +937,8 @@
 			pinctrl-0 = <&pinctrl_nand>;
 			clock-names = "nand", "nand_x", "ecc";
 			clocks = <&sys_clk 2>, <&sys_clk 3>, <&sys_clk 3>;
-			resets = <&sys_rst 2>;
+			reset-names = "nand", "reg";
+			resets = <&sys_rst 2>, <&sys_rst 2>;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index d6f6cee4d549..73e7e1203b09 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -795,7 +795,8 @@
 			pinctrl-0 = <&pinctrl_nand>;
 			clock-names = "nand", "nand_x", "ecc";
 			clocks = <&sys_clk 2>, <&sys_clk 3>, <&sys_clk 3>;
-			resets = <&sys_rst 2>;
+			reset-names = "nand", "reg";
+			resets = <&sys_rst 2>, <&sys_rst 2>;
 		};
 	};
 };
-- 
2.17.1

