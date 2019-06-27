Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 647CC58448
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 16:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfF0OMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 10:12:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50242 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726370AbfF0OMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 10:12:09 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 184AB6F65FC6F0EE6CEA;
        Thu, 27 Jun 2019 22:12:07 +0800 (CST)
Received: from huawei.com (10.67.189.167) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Thu, 27 Jun 2019
 22:11:57 +0800
From:   Jiangfeng Xiao <xiaojiangfeng@huawei.com>
To:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <linus.walleij@linaro.org>,
        <xiaojiangfeng@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] irqchip/gic: Add dependency for ARM_GIC
Date:   Thu, 27 Jun 2019 22:11:47 +0800
Message-ID: <1561644707-25191-1-git-send-email-xiaojiangfeng@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.167]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not every arch has ARM_GIC, it is strange
to see ARM_GIC_MAX_NR in the .config file
of the x86 and IA-64 architecture. so fix
build by adding necessary dependency.

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

