Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86798DBC91
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 07:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504324AbfJRFG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 01:06:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4273 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2504028AbfJRFFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:05:10 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C5D4E57CB106CEA62421;
        Fri, 18 Oct 2019 11:19:30 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Fri, 18 Oct 2019 11:19:22 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Petr Mladek <pmladek@suse.com>, <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Sergey Senozhatsky" <sergey.senozhatsky@gmail.com>
Subject: [PATCH v2 06/33] sparc: Use pr_warn instead of pr_warning
Date:   Fri, 18 Oct 2019 11:18:23 +0800
Message-ID: <20191018031850.48498-6-wangkefeng.wang@huawei.com>
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

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/sparc/kernel/smp_64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index a8275fea4b70..9b4506373353 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1673,9 +1673,9 @@ void __init setup_per_cpu_areas(void)
 					    pcpu_alloc_bootmem,
 					    pcpu_free_bootmem);
 		if (rc)
-			pr_warning("PERCPU: %s allocator failed (%d), "
-				   "falling back to page size\n",
-				   pcpu_fc_names[pcpu_chosen_fc], rc);
+			pr_warn("PERCPU: %s allocator failed (%d), "
+				"falling back to page size\n",
+				pcpu_fc_names[pcpu_chosen_fc], rc);
 	}
 	if (rc < 0)
 		rc = pcpu_page_first_chunk(PERCPU_MODULE_RESERVE,
-- 
2.20.1

