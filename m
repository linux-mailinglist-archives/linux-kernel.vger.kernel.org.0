Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7E9519AB75
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 14:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732493AbgDAMPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 08:15:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40252 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732288AbgDAMPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 08:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585743333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=p7VGwf4cuRJgF3sKdibEsjbhU2tO6rj8LiLsxk+nJEk=;
        b=g8Eg8jv3GjWq9+IoMFISolg1CgvyE7TxElpg7ARTLEORSn6wvXirqQqTLog7kCUOEBbU4K
        qJil1BndQqhGmhvcANx9UKGg9dQ8BCRGydz18eRPdEy4z1JQF28O5k+XzSh6G9VpzcD925
        R9ZFhNqxNCAwyASUBN4IakRSz5XGBNM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-FoKro0ZhOA-jK-Wgq_veyg-1; Wed, 01 Apr 2020 08:15:31 -0400
X-MC-Unique: FoKro0ZhOA-jK-Wgq_veyg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B52A21005516;
        Wed,  1 Apr 2020 12:15:29 +0000 (UTC)
Received: from fuller.cnet (ovpn-116-11.gru2.redhat.com [10.97.116.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C5EA99DEA;
        Wed,  1 Apr 2020 12:15:29 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id B4DBC42FDD12; Wed,  1 Apr 2020 09:15:03 -0300 (-03)
Message-ID: <20200401121342.883941670@redhat.com>
User-Agent: quilt/0.66
Date:   Wed, 01 Apr 2020 09:10:19 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Chris Friesen <chris.friesen@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Christoph Lameter <cl@linux.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 1/4] kthread: switch to cpu_possible_mask
References: <20200401121018.104226700@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Next patch will switch unbound kernel threads mask to 
housekeeping_cpumask(), a subset of cpu_possible_mask.

Switch from cpu_all_mask to cpu_possible_mask separately,
to ease bisection.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 kernel/kthread.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/kernel/kthread.c
===================================================================
--- linux-2.6.orig/kernel/kthread.c
+++ linux-2.6/kernel/kthread.c
@@ -347,7 +347,7 @@ struct task_struct *__kthread_create_on_
 		 * The kernel thread should not inherit these properties.
 		 */
 		sched_setscheduler_nocheck(task, SCHED_NORMAL, &param);
-		set_cpus_allowed_ptr(task, cpu_all_mask);
+		set_cpus_allowed_ptr(task, cpu_possible_mask);
 	}
 	kfree(create);
 	return task;
@@ -572,7 +572,7 @@ int kthreadd(void *unused)
 	/* Setup a clean context for our children to inherit. */
 	set_task_comm(tsk, "kthreadd");
 	ignore_signals(tsk);
-	set_cpus_allowed_ptr(tsk, cpu_all_mask);
+	set_cpus_allowed_ptr(tsk, cpu_possible_mask);
 	set_mems_allowed(node_states[N_MEMORY]);
 
 	current->flags |= PF_NOFREEZE;


