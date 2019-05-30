Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B25702E99F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 02:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfE3AIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 20:08:55 -0400
Received: from regular1.263xmail.com ([211.150.70.202]:38746 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfE3AIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 20:08:55 -0400
Received: from jay.xu?rock-chips.com (unknown [192.168.167.164])
        by regular1.263xmail.com (Postfix) with ESMTP id F0F36265;
        Thu, 30 May 2019 08:08:52 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P6465T140561499830016S1559174930113109_;
        Thu, 30 May 2019 08:08:52 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <7226ec3af7018d2e8926de38c05e9585>
X-RL-SENDER: jay.xu@rock-chips.com
X-SENDER: xjq@rock-chips.com
X-LOGIN-NAME: jay.xu@rock-chips.com
X-FST-TO: xjq@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Jianqun Xu <jay.xu@rock-chips.com>
To:     jay.xu@rock-chips.com, heiko@sntech.de, mark.rutland@arm.com,
        robh+dt@kernel.org
Cc:     zhangzj@rock-chips.com, manivannan.sadhasivam@linaro.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 1/1] arm64: dts: rockchip: add core dtsi file for RK3399Pro SoCs
Date:   Thu, 30 May 2019 08:08:48 +0800
Message-Id: <20190530000848.28106-1-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529074752.19388-1-jay.xu@rock-chips.com>
References: <20190529074752.19388-1-jay.xu@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds core dtsi file for Rockchip RK3399Pro SoCs,
include rk3399.dtsi. Also enable pciei0/pcie_phy for AP to
talk to NPU part inside SoC.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
changes since v2:
- only enable pcie0 and pcie_phy nodes, thanks for Heiko and manivannan

changes since v1:
- remove dfi and dmc

 arch/arm64/boot/dts/rockchip/rk3399pro.dtsi | 22 +++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399pro.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro.dtsi
new file mode 100644
index 000000000000..bb5ebf6608b9
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399pro.dtsi
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (c) 2019 Fuzhou Rockchip Electronics Co., Ltd.
+
+#include "rk3399.dtsi"
+
+/ {
+	compatible = "rockchip,rk3399pro";
+};
+
+/* Default to enabled since AP talk to NPU part over pcie */
+&pcie_phy {
+	status = "okay";
+};
+
+/* Default to enabled since AP talk to NPU part over pcie */
+&pcie0 {
+	ep-gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
+	num-lanes = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_clkreqn_cpm>;
+	status = "okay";
+};
-- 
2.17.1



