Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 207B51478C1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 08:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbgAXHDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 02:03:14 -0500
Received: from relay.sw.ru ([185.231.240.75]:53128 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgAXHDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 02:03:13 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1iuszZ-000865-4r; Fri, 24 Jan 2020 10:02:57 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 4/7] fpid_next should increase position index
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.com>, Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <4f87c6ad-f114-30bb-8506-c32274ce2992@virtuozzo.com>
Date:   Fri, 24 Jan 2020 10:02:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if seq_file .next fuction does not change position index,
read after some lseek can generate unexpected output.

https://bugzilla.kernel.org/show_bug.cgi?id=206283
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 kernel/trace/ftrace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index ca25210..7c64b2b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7033,9 +7033,10 @@ static void *fpid_next(struct seq_file *m, void *v, loff_t *pos)
 	struct trace_array *tr = m->private;
 	struct trace_pid_list *pid_list = rcu_dereference_sched(tr->function_pids);
 
-	if (v == FTRACE_NO_PIDS)
+	if (v == FTRACE_NO_PIDS) {
+		(*pos)++;
 		return NULL;
-
+	}
 	return trace_pid_next(pid_list, v, pos);
 }
 
-- 
1.8.3.1

