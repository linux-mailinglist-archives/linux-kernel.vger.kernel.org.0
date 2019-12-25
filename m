Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6977D12A7BE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Dec 2019 12:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfLYLy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Dec 2019 06:54:26 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8187 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbfLYLyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 06:54:25 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DFCD07D8244006852EF5;
        Wed, 25 Dec 2019 19:54:23 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 25 Dec 2019
 19:54:16 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <benh@kernel.crashing.org>, <paulus@samba.org>,
        <mpe@ellerman.id.au>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] powerpc/pmac/smp: Fix old-style declaration
Date:   Wed, 25 Dec 2019 19:49:43 +0800
Message-ID: <20191225114943.17216-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There expect the 'static' keyword to come first in a declaration

arch/powerpc/platforms/powermac/smp.c:664:1: warning: static is not at beginning of declaration [-Wold-style-declaration]
arch/powerpc/platforms/powermac/smp.c:665:1: warning: static is not at beginning of declaration [-Wold-style-declaration]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/powerpc/platforms/powermac/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index f95fbde..7233b85 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -661,8 +661,8 @@ static void smp_core99_gpio_tb_freeze(int freeze)
 #endif /* !CONFIG_PPC64 */
 
 /* L2 and L3 cache settings to pass from CPU0 to CPU1 on G4 cpus */
-volatile static long int core99_l2_cache;
-volatile static long int core99_l3_cache;
+static volatile long int core99_l2_cache;
+static volatile long int core99_l3_cache;
 
 static void core99_init_caches(int cpu)
 {
-- 
2.7.4


