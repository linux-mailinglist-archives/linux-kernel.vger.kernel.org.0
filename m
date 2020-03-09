Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D363517E13F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 14:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgCINcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 09:32:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11610 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726427AbgCINcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 09:32:41 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 24BECA8427454E02611F;
        Mon,  9 Mar 2020 21:32:09 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Mon, 9 Mar 2020
 21:31:59 +0800
From:   Cheng Jian <cj.chengjian@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>, <bobo.shaobowang@huawei.com>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <mhiramat@kernel.org>
Subject: [PATCH v2] kretprobe: check re-registration of the same kretprobe earlier
Date:   Mon, 9 Mar 2020 21:39:13 +0800
Message-ID: <1583761153-13876-1-git-send-email-cj.chengjian@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our system encountered a use-after-free when re-register the same
kretprobe, it access the kretprobe_instance in rp->free_instances
which has been released already.

Prevent re-registration has been implemented for kprobe before, but
it's too late for kretprobe. We must check the re-registration before
re-initializing the kretprobe, otherwise it will destroy the data and
struct of the kretprobe registered, it can lead to use-after-free,
memory leak, system crash, and even other unexpected behaviors.

Use check_kprobe_rereg() to check re-registration, also give a warning
message.

Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 2625c24..9cb2a0d 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1946,6 +1946,14 @@ int register_kretprobe(struct kretprobe *rp)
 		}
 	}
 
+	/*
+	 * Return error if it's being re-registered,
+	 * also give a warning message to the developer.
+	 */
+	ret = check_kprobe_rereg(&rp->kp);
+	if (WARN_ON(ret))
+		return ret;
+
 	rp->kp.pre_handler = pre_handler_kretprobe;
 	rp->kp.post_handler = NULL;
 	rp->kp.fault_handler = NULL;
-- 
2.7.4

