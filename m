Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECE8610C5A3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 10:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfK1JHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 04:07:54 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:40788 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725789AbfK1JHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 04:07:53 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 538A8517B63887E92DE5;
        Thu, 28 Nov 2019 17:07:51 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Thu, 28 Nov 2019 17:07:48 +0800
From:   Daode Huang <huangdaode@hisilicon.com>
To:     <tglx@linutronix.de>, <jason@lakedaemon.net>, <maz@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <fabien.dessenne@st.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] irqchip/stm32: Fix "WARNING: invalid free of devm_ allocated
Date:   Thu, 28 Nov 2019 17:04:40 +0800
Message-ID: <1574931880-168682-1-git-send-email-huangdaode@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since devm_ allocated data can be automaitcally released, it's no
need to free it apparently, just remove it.

Fixes: cfbf9e497094 ("irqchip/stm32: Use a platform driver for
stm32mp1-exti device")
Signed-off-by: Daode Huang <huangdaode@hisilicon.com>
---
 drivers/irqchip/irq-stm32-exti.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index e00f2fa..46ec0af 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -779,8 +779,6 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
 	irq_domain_remove(domain);
 out_unmap:
 	iounmap(host_data->base);
-	kfree(host_data->chips_data);
-	kfree(host_data);
 	return ret;
 }
 
-- 
2.8.1

