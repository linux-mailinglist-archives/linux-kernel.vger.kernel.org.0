Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDA0136594
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 03:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730988AbgAJC4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 21:56:40 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:56794 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730936AbgAJC4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 21:56:40 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 64759B2F520DC42A384D;
        Fri, 10 Jan 2020 10:56:37 +0800 (CST)
Received: from huawei.com (10.175.104.225) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Fri, 10 Jan 2020
 10:56:31 +0800
From:   Hewenliang <hewenliang4@huawei.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <bsegall@google.com>, <mgorman@suse.de>,
        <linux-kernel@vger.kernel.org>
CC:     <hewenliang4@huawei.com>
Subject: [PATCH] idle: fix spelling mistake "iterrupts" -> "interrupts"
Date:   Thu, 9 Jan 2020 21:56:04 -0500
Message-ID: <20200110025604.34373-1-hewenliang4@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling misake in comments of cpuidle_idle_call. Fix it.

Signed-off-by: Hewenliang <hewenliang4@huawei.com>
---
 kernel/sched/idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index f65ef1e2f204..d29ebe8c63dd 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -158,7 +158,7 @@ static void cpuidle_idle_call(void)
 	/*
 	 * Suspend-to-idle ("s2idle") is a system state in which all user space
 	 * has been frozen, all I/O devices have been suspended and the only
-	 * activity happens here and in iterrupts (if any).  In that case bypass
+	 * activity happens here and in interrupts (if any). In that case bypass
 	 * the cpuidle governor and go stratight for the deepest idle state
 	 * available.  Possibly also suspend the local tick and the entire
 	 * timekeeping to prevent timer interrupts from kicking us out of idle
-- 
2.19.1

