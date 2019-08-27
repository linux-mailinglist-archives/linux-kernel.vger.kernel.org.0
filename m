Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 851319DE84
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 09:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbfH0HPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 03:15:48 -0400
Received: from regular1.263xmail.com ([211.150.70.197]:36252 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfH0HPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:15:48 -0400
Received: from zhangzj?rock-chips.com (unknown [192.168.167.153])
        by regular1.263xmail.com (Postfix) with ESMTP id C11D9690;
        Tue, 27 Aug 2019 15:15:27 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P15961T139881246357248S1566890113084555_;
        Tue, 27 Aug 2019 15:15:17 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <3ad0733fd004bc1499c4d958c0965038>
X-RL-SENDER: zhangzj@rock-chips.com
X-SENDER: zhangzj@rock-chips.com
X-LOGIN-NAME: zhangzj@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Elon Zhang <zhangzj@rock-chips.com>
To:     heiko@sntech.de, mark.rutland@arm.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Elon Zhang <zhangzj@rock-chips.com>
Subject: [PATCH v1 1/1] ARM: dts: rockchip: set crypto default disabled on rk3288
Date:   Tue, 27 Aug 2019 15:14:39 +0800
Message-Id: <20190827071439.14767-1-zhangzj@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not every board needs to enable crypto node, so the node should
be set default disabled in rk3288.dtsi and enabled in specific
board dts file.

Signed-off-by: Elon Zhang <zhangzj@rock-chips.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index cc893e154fe5..d509aa24177c 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -984,7 +984,7 @@
 		clock-names = "aclk", "hclk", "sclk", "apb_pclk";
 		resets = <&cru SRST_CRYPTO>;
 		reset-names = "crypto-rst";
-		status = "okay";
+		status = "disabled";
 	};
 
 	iep_mmu: iommu@ff900800 {
-- 
2.17.1



