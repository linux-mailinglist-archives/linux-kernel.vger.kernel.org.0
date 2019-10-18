Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67867DBC88
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 07:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504273AbfJRFGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 01:06:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58184 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733173AbfJRFGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:06:31 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 00CA92E612082A8887EB;
        Fri, 18 Oct 2019 11:19:46 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Fri, 18 Oct 2019 11:19:35 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Petr Mladek <pmladek@suse.com>, <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH v2 26/33] trace: Use pr_warn instead of pr_warning
Date:   Fri, 18 Oct 2019 11:18:43 +0800
Message-ID: <20191018031850.48498-26-wangkefeng.wang@huawei.com>
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

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 kernel/trace/trace_benchmark.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_benchmark.c b/kernel/trace/trace_benchmark.c
index 80e0b2aca703..2e9a4746ea85 100644
--- a/kernel/trace/trace_benchmark.c
+++ b/kernel/trace/trace_benchmark.c
@@ -178,14 +178,14 @@ static int benchmark_event_kthread(void *arg)
 int trace_benchmark_reg(void)
 {
 	if (!ok_to_run) {
-		pr_warning("trace benchmark cannot be started via kernel command line\n");
+		pr_warn("trace benchmark cannot be started via kernel command line\n");
 		return -EBUSY;
 	}
 
 	bm_event_thread = kthread_run(benchmark_event_kthread,
 				      NULL, "event_benchmark");
 	if (IS_ERR(bm_event_thread)) {
-		pr_warning("trace benchmark failed to create kernel thread\n");
+		pr_warn("trace benchmark failed to create kernel thread\n");
 		return PTR_ERR(bm_event_thread);
 	}
 
-- 
2.20.1

