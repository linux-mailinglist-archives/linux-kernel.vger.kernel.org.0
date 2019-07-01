Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3F1C45D38
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 14:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfFNM5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 08:57:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38394 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726874AbfFNM5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:57:32 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DA54C41D436C5FD89996;
        Fri, 14 Jun 2019 20:57:25 +0800 (CST)
Received: from huawei.com (10.67.189.167) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Fri, 14 Jun 2019
 20:57:19 +0800
From:   Jiangfeng Xiao <xiaojiangfeng@huawei.com>
To:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <linus.walleij@linaro.org>,
        <xiaojiangfeng@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <nixiaoming@huawei.com>,
        <leeyou.li@huawei.com>
Subject: [PATCH] irqchip/gic: Add dependency for ARM_GIC_MAX_NR
Date:   Fri, 14 Jun 2019 20:57:09 +0800
Message-ID: <1560517029-19777-1-git-send-email-xiaojiangfeng@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.167]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_ARM_GIC_MAX_NR is enabled by default.
It is redundant in x86 and IA-64 where is
without GIC.

Signed-off-by: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
---
 drivers/irqchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 659c5e0..e338b471 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -19,6 +19,7 @@ config ARM_GIC_PM
 
 config ARM_GIC_MAX_NR
 	int
+	depends on ARM_GIC
 	default 2 if ARCH_REALVIEW
 	default 1
 
-- 
1.8.5.6

