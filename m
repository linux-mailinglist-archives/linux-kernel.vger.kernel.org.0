Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13DB414353C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 02:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgAUBg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 20:36:56 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9672 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727009AbgAUBgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 20:36:55 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2A1821F9D21F6B68683B;
        Tue, 21 Jan 2020 09:36:53 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Tue, 21 Jan 2020 09:36:43 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <benh@kernel.crashing.org>, <paulus@samba.org>,
        <mpe@ellerman.id.au>
CC:     <gregkh@linuxfoundation.org>, <nivedita@alum.mit.edu>,
        <tglx@linutronix.de>, <allison@lohutok.net>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH -next] powerpc/maple: fix comparing pointer to 0
Date:   Tue, 21 Jan 2020 09:31:53 +0800
Message-ID: <20200121013153.9937-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:
./arch/powerpc/platforms/maple/setup.c:232:15-16:
	WARNING comparing pointer to 0

Compare pointer-typed values to NULL rather than 0.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 arch/powerpc/platforms/maple/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index 47f7310..00a0780 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -229,7 +229,7 @@ static void __init maple_init_IRQ(void)
 	root = of_find_node_by_path("/");
 	naddr = of_n_addr_cells(root);
 	opprop = of_get_property(root, "platform-open-pic", &opplen);
-	if (opprop != 0) {
+	if (opprop) {
 		openpic_addr = of_read_number(opprop, naddr);
 		has_isus = (opplen > naddr);
 		printk(KERN_DEBUG "OpenPIC addr: %lx, has ISUs: %d\n",
-- 
2.7.4

