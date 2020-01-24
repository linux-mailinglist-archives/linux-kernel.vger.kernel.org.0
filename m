Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D32C71478C5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 08:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbgAXHDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 02:03:32 -0500
Received: from relay.sw.ru ([185.231.240.75]:53186 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgAXHDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 02:03:31 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1iuszd-00086C-Ll; Fri, 24 Jan 2020 10:03:01 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 5/7] eval_map_next should increase position index
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.com>, Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <7ad85b22-1866-977c-db17-88ac438bc764@virtuozzo.com>
Date:   Fri, 24 Jan 2020 10:03:01 +0300
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
 kernel/trace/trace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ddb7e7f..a337764 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5361,14 +5361,12 @@ static void *eval_map_next(struct seq_file *m, void *v, loff_t *pos)
 	 * Paranoid! If ptr points to end, we don't want to increment past it.
 	 * This really should never happen.
 	 */
+	(*pos)++;
 	ptr = update_eval_map(ptr);
 	if (WARN_ON_ONCE(!ptr))
 		return NULL;
 
 	ptr++;
-
-	(*pos)++;
-
 	ptr = update_eval_map(ptr);
 
 	return ptr;
-- 
1.8.3.1

