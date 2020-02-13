Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2685C15BDB4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 12:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbgBMLfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 06:35:25 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10618 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbgBMLfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 06:35:24 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 339FAE8E5905136164A6;
        Thu, 13 Feb 2020 19:35:19 +0800 (CST)
Received: from euler.huawei.com (10.175.104.193) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Thu, 13 Feb 2020 19:35:09 +0800
From:   Hongbo Yao <yaohongbo@huawei.com>
To:     <paulmck@kernel.or>
CC:     <linux-kernel@vger.kernel.org>, <yaohongbo@huawei.com>,
        <chenzhou10@huawei.com>, <dave@stgolabs.net>,
        <josh@joshtriplett.org>
Subject: [PATCH -next] torture: avoid build error without CONFIG_RCU_TORTURE_TEST
Date:   Thu, 13 Feb 2020 19:49:52 +0800
Message-ID: <20200213114952.4638-1-yaohongbo@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.193]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If TORTURE_TEST=y(selected by TORTURE_LOCK_TEST) and RCU_TORTURE_TEST=n,
the following error is seen while building kernel/torture.c

kernel/torture.c: In function torture_onoff:
kernel/torture.c:239:3: error: implicit declaration of function
rcutorture_sched_setaffinity; did you mean __NR_ia32_sched_setaffinity?
[-Werror=implicit-function-declaration]
   rcutorture_sched_setaffinity(current->pid, cpumask_of(0));

Using sched_setaffnity() instead of rcutorture_sched_setaffinity() to
avoid the error.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: bc3db9afb849 ("EXP: rcutorture hack to force CPU hotplug onto CPU 0")
Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
---
 kernel/torture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index b29adec50e01..834214cbd1cd 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -236,7 +236,7 @@ torture_onoff(void *arg)
 			schedule_timeout_interruptible(HZ / 10);
 			continue;
 		}
-		rcutorture_sched_setaffinity(current->pid, cpumask_of(0));
+		sched_setaffinity(current->pid, cpumask_of(0));
 		cpu = (torture_random(&rand) >> 4) % (maxcpu + 1);
 		if (!torture_offline(cpu,
 				     &n_offline_attempts, &n_offline_successes,
-- 
2.17.1

