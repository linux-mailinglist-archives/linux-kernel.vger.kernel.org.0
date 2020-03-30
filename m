Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9EF919729F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 04:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbgC3Co5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Mar 2020 22:44:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33820 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728865AbgC3Co5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 22:44:57 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CBE2E902661E7DEFD10C;
        Mon, 30 Mar 2020 10:44:51 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.183) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Mon, 30 Mar 2020
 10:44:44 +0800
To:     <ebiederm@xmission.com>, <oleg@redhat.com>,
        <christian.brauner@ubuntu.com>, <tj@kernel.org>,
        <akpm@linux-foundation.org>, <guro@fb.com>,
        <joel@joelfernandes.org>, <linux-kernel@vger.kernel.org>
CC:     Mingfangsen <mingfangsen@huawei.com>,
        linfeilong <linfeilong@huawei.com>, <liuzhiqiang26@huawei.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: [PATCH] signal: use kill_proc_info instead of kill_pid_info in
 kill_something_info
Message-ID: <80236965-f0b5-c888-95ff-855bdec75bb3@huawei.com>
Date:   Mon, 30 Mar 2020 10:44:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.183]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


signal.c provides kill_proc_info, we can use it instead of kill_pid_info
in kill_something_info func gracefully.

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
 kernel/signal.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 9ad8dea93dbb..33c70f9f1728 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1552,12 +1552,8 @@ static int kill_something_info(int sig, struct kernel_siginfo *info, pid_t pid)
 {
 	int ret;

-	if (pid > 0) {
-		rcu_read_lock();
-		ret = kill_pid_info(sig, info, find_vpid(pid));
-		rcu_read_unlock();
-		return ret;
-	}
+	if (pid > 0)
+		return kill_proc_info(sig, info, pid);

 	/* -INT_MIN is undefined.  Exclude this case to avoid a UBSAN warning */
 	if (pid == INT_MIN)
-- 
2.19.1

