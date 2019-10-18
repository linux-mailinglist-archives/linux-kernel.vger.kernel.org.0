Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1800FDBC90
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 07:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504315AbfJRFGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 01:06:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4270 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2504029AbfJRFFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:05:10 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BFAA95EC249E71A351C5;
        Fri, 18 Oct 2019 11:19:30 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Fri, 18 Oct 2019 11:19:21 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Petr Mladek <pmladek@suse.com>, <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH v2 04/33] riscv: Use pr_warn instead of pr_warning
Date:   Fri, 18 Oct 2019 11:18:21 +0800
Message-ID: <20191018031850.48498-4-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018031850.48498-1-wangkefeng.wang@huawei.com>
References: <20191018031710.41052-1-wangkefeng.wang@huawei.com>
 <20191018031850.48498-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
pr_warning"), removing pr_warning so all logging messages use a
consistent <prefix>_warn style. Let's do it.

Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Acked-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/riscv/kernel/module.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 70bb94ae61c5..b7401858d872 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -315,8 +315,8 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 			/* Ignore unresolved weak symbol */
 			if (ELF_ST_BIND(sym->st_info) == STB_WEAK)
 				continue;
-			pr_warning("%s: Unknown symbol %s\n",
-				   me->name, strtab + sym->st_name);
+			pr_warn("%s: Unknown symbol %s\n",
+				me->name, strtab + sym->st_name);
 			return -ENOENT;
 		}
 
-- 
2.20.1

