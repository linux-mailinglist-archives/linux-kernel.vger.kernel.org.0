Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF04311C459
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 04:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfLLDns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 22:43:48 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:48054 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727381AbfLLDnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 22:43:47 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 31912E95EE8E62413E16;
        Thu, 12 Dec 2019 11:43:45 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Thu, 12 Dec 2019 11:43:36 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <chenzhou10@huawei.com>
Subject: [PATCH] sched/fair: fix function name in comment
Date:   Thu, 12 Dec 2019 11:40:51 +0800
Message-ID: <20191212034051.161513-1-chenzhou10@huawei.com>
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

Function name "init_sched_domains" has been modified to
"sched_init_domains" in commit 8d5dc5126bb2
("sched/topology: Small cleanup"). Fix the function name
"init_sched_domains" in comment.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 08a233e..c872fd4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9512,7 +9512,7 @@ void update_max_interval(void)
  * It checks each scheduling domain to see if it is due to be balanced,
  * and initiates a balancing operation if so.
  *
- * Balancing parameters are set up in init_sched_domains.
+ * Balancing parameters are set up in sched_init_domains.
  */
 static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 {
-- 
2.7.4

