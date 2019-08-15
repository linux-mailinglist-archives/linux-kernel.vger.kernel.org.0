Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7698E4C0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 08:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbfHOGGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 02:06:31 -0400
Received: from mx.aristanetworks.com ([162.210.129.12]:5131 "EHLO
        smtp.aristanetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfHOGGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 02:06:30 -0400
Received: from smtp.aristanetworks.com (localhost [127.0.0.1])
        by smtp.aristanetworks.com (Postfix) with ESMTP id B65DD42A2C7;
        Wed, 14 Aug 2019 23:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1565849232;
        bh=OG6evudYvLj50ZFoTIDecZ1Ho1oufmSz1imiu12yfjk=;
        h=From:To:Cc:Subject:Date;
        b=YEebXXY2Y14FST6xyHsv3SPFD9wRuNltXbAlw1y/+RiWHbr31RIpHP4zHvdIQ3LOJ
         TUV567FDvdD8dCUPDqI7UOFUN6AS845eFF181M8SHU9z2uKDlCKCuootWa0/KsKGIB
         PPZdMRK/cD5JjSPsPu6bUXk+H9C5abYwMpt/lTzN2oQ0pHI1J++ZDTw0m2sYmxBPPw
         1T9KUZyjs6sLZDO0KISu9uxakqn4vyFJoL9x/omYdgzzIq36crLYBn5PsI0givIB22
         v7nqhZD9DThU6VcPspilWEkRwT/DVxkngQtGzk0aCYC/YMCZ/uE8ftejUrYGD1FBld
         Chec4Yp4UIKTQ==
Received: from egc101.sjc.aristanetworks.com (unknown [172.20.210.50])
        by smtp.aristanetworks.com (Postfix) with ESMTP id A8B7142A296;
        Wed, 14 Aug 2019 23:07:12 -0700 (PDT)
From:   Edward Chron <echron@arista.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, colona@arista.com,
        Edward Chron <echron@arista.com>
Subject: [PATCH] mm/oom: Add killed process selection information
Date:   Wed, 14 Aug 2019 23:06:04 -0700
Message-Id: <20190815060604.3675-1-echron@arista.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For an OOM event: print oom_score_adj value for the OOM Killed process
to document what the oom score adjust value was at the time the process
at the time of the OOM event. The value can be set by the user and it
effects the resulting oom_score so useful to document this value.

Sample message output:
Aug 14 23:00:02 testserver kernel: Out of memory: Killed process 2692
 (oomprocs) total-vm:1056800kB, anon-rss:1052760kB, file-rss:4kB,i
 shmem-rss:0kB oom_score_adj:1000

Signed-off-by: Edward Chron <echron@arista.com>
---
 mm/oom_kill.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index eda2e2a0bdc6..6b1674cac377 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -858,6 +858,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 	struct task_struct *p;
 	struct mm_struct *mm;
 	bool can_oom_reap = true;
+	long adj;
 
 	p = find_lock_task_mm(victim);
 	if (!p) {
@@ -877,6 +878,8 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 	count_vm_event(OOM_KILL);
 	memcg_memory_event_mm(mm, MEMCG_OOM_KILL);
 
+	adj = (long)victim->signal->oom_score_adj;
+
 	/*
 	 * We should send SIGKILL before granting access to memory reserves
 	 * in order to prevent the OOM victim from depleting the memory
@@ -884,12 +887,12 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 	 */
 	do_send_sig_info(SIGKILL, SEND_SIG_PRIV, victim, PIDTYPE_TGID);
 	mark_oom_victim(victim);
-	pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
+	pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB oom_score_adj:%ld\n",
 		message, task_pid_nr(victim), victim->comm,
 		K(victim->mm->total_vm),
 		K(get_mm_counter(victim->mm, MM_ANONPAGES)),
 		K(get_mm_counter(victim->mm, MM_FILEPAGES)),
-		K(get_mm_counter(victim->mm, MM_SHMEMPAGES)));
+		K(get_mm_counter(victim->mm, MM_SHMEMPAGES)), adj);
 	task_unlock(victim);
 
 	/*
-- 
2.20.1

