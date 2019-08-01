Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCFC7D7AF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 10:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbfHAIci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 04:32:38 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:26982 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730133AbfHAIci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 04:32:38 -0400
Received: from localhost.localdomain ([176.167.121.156])
        by mwinf5d80 with ME
        id jkYb2000U3NZnML03kYcJj; Thu, 01 Aug 2019 10:32:36 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 01 Aug 2019 10:32:36 +0200
X-ME-IP: 176.167.121.156
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        allison@lohutok.net, tglx@linutronix.de, clg@kaod.org,
        groug@kaod.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] powerpc/xive: Add a check for memory allocation failure
Date:   Thu,  1 Aug 2019 10:32:42 +0200
Message-Id: <cc53462734dfeaf15b6bad0e626b483de18656b4.1564647619.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1564647619.git.christophe.jaillet@wanadoo.fr>
References: <cover.1564647619.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The result of this kzalloc is not checked. Add a check and corresponding
error handling code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Note that 'xive_irq_bitmap_add()' failures are not handled in
'xive_spapr_init()'
I guess that it is not really an issue. This function is _init, so if a
memory allocation occures here, it is likely that the system will
already be in bad shape.
Anyway, the check added here would at least keep the data linked in
'xive_irq_bitmaps' usable.
---
 arch/powerpc/sysdev/xive/spapr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
index b4f5eb9e0f82..52198131c75e 100644
--- a/arch/powerpc/sysdev/xive/spapr.c
+++ b/arch/powerpc/sysdev/xive/spapr.c
@@ -53,6 +53,10 @@ static int xive_irq_bitmap_add(int base, int count)
 	xibm->base = base;
 	xibm->count = count;
 	xibm->bitmap = kzalloc(xibm->count, GFP_KERNEL);
+	if (!xibm->bitmap) {
+		kfree(xibm);
+		return -ENOMEM;
+	}
 	list_add(&xibm->list, &xive_irq_bitmaps);
 
 	pr_info("Using IRQ range [%x-%x]", xibm->base,
-- 
2.20.1

