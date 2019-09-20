Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A70E0B8AE8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 08:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437243AbfITGI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 02:08:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2745 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408280AbfITGIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:08:53 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9BAFBE8CC058B90DA027;
        Fri, 20 Sep 2019 14:08:51 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 20 Sep 2019 14:08:43 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>
CC:     <wangkefeng.wang@huawei.com>
Subject: [PATCH 01/32] alpha: Use pr_warn instead of pr_warning
Date:   Fri, 20 Sep 2019 14:25:13 +0800
Message-ID: <20190920062544.180997-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
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

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/alpha/kernel/perf_event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_event.c
index 4341ccf5c0c4..e7a59d927d78 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -824,7 +824,7 @@ static void alpha_perf_event_irq_handler(unsigned long la_ptr,
 	if (unlikely(la_ptr >= alpha_pmu->num_pmcs)) {
 		/* This should never occur! */
 		irq_err_count++;
-		pr_warning("PMI: silly index %ld\n", la_ptr);
+		pr_warn("PMI: silly index %ld\n", la_ptr);
 		wrperfmon(PERFMON_CMD_ENABLE, cpuc->idx_mask);
 		return;
 	}
@@ -847,7 +847,7 @@ static void alpha_perf_event_irq_handler(unsigned long la_ptr,
 	if (unlikely(!event)) {
 		/* This should never occur! */
 		irq_err_count++;
-		pr_warning("PMI: No event at index %d!\n", idx);
+		pr_warn("PMI: No event at index %d!\n", idx);
 		wrperfmon(PERFMON_CMD_ENABLE, cpuc->idx_mask);
 		return;
 	}
-- 
2.20.1

