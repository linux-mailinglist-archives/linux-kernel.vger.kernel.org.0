Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFCD81513AB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 01:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgBDAgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 19:36:06 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39220 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726369AbgBDAgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 19:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580776564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=9E5JwZpRiglVmZRBi3lit3JyiT8tTvxFskBeSob+PSs=;
        b=IqtYxprkBgic3Wqw1B3R1DPR9xJJD+TBF6vKM160WjNMFatUIUITs/cahcvqJkoyP9EQRK
        7kuoJAE/gxv9qFb0U//IJXmzl9HnYMMYdzKVlVz6oC+CXqZpGTQCdSz5bUyrngC+6Wvnh1
        Cx3mBALeKpbdw6wzDgv9NR6fQJfCFnc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-71nBJxXBOeCHni-qEuIWcA-1; Mon, 03 Feb 2020 19:36:01 -0500
X-MC-Unique: 71nBJxXBOeCHni-qEuIWcA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5960800D4C;
        Tue,  4 Feb 2020 00:35:59 +0000 (UTC)
Received: from intel-purley-fpgabmp-02.ml3.eng.bos.redhat.com (intel-purley-fpgabmp-02.ml3.eng.bos.redhat.com [10.19.176.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8DE5E60BF4;
        Tue,  4 Feb 2020 00:35:58 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Scott Wood <swood@redhat.com>
Subject: [PATCH] sched/core: sched_tick_remote: Remove duplicate assignment
Date:   Mon,  3 Feb 2020 19:35:58 -0500
Message-Id: <1580776558-12882-1-git-send-email-swood@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A redundant "curr = rq->curr" was added; remove it.

Fixes: ebc0f83c78a2 ("timers/nohz: Update NOHZ load in remote tick")
Signed-off-by: Scott Wood <swood@redhat.com>
---
 kernel/sched/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 45f79bcc3146..377ec26e9159 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3683,7 +3683,6 @@ static void sched_tick_remote(struct work_struct *work)
 	if (cpu_is_offline(cpu))
 		goto out_unlock;
 
-	curr = rq->curr;
 	update_rq_clock(rq);
 
 	if (!is_idle_task(curr)) {
-- 
1.8.3.1

