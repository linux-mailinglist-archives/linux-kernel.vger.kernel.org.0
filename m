Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93CB6E989E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 10:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfJ3JBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 05:01:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58382 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfJ3JBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 05:01:20 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8A032D7248085039D2C7;
        Wed, 30 Oct 2019 17:01:18 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Wed, 30 Oct 2019 17:01:10 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <peterz@infradead.org>, <tglx@linutronix.de>, <mingo@redhat.com>
CC:     <dave.hansen@linux.intel.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <zhongjiang@huawei.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/ioremap: Use WARN_ONCE instead of printk() + WARN_ON_ONCE()
Date:   Wed, 30 Oct 2019 16:57:18 +0800
Message-ID: <1572425838-39158-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ONCE is more clear and simpler. Just replace it.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 arch/x86/mm/ioremap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index a39dcdb..3b74599 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -172,9 +172,8 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
 		return NULL;
 
 	if (!phys_addr_valid(phys_addr)) {
-		printk(KERN_WARNING "ioremap: invalid physical address %llx\n",
-		       (unsigned long long)phys_addr);
-		WARN_ON_ONCE(1);
+		WARN_ONCE(1, "ioremap: invalid physical address %llx\n",
+			  (unsigned long long)phys_addr);
 		return NULL;
 	}
 
-- 
1.7.12.4

