Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF8D07DA1C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 13:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbfHALSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 07:18:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44196 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbfHALST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 07:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/BSdPIoCwgRhHfWOHPwPqGUqxLt3gcCsEyPPvDK5A6s=; b=HjeriqX6h1t0O+Mrqo9Zem9sSF
        ULZLO+kJYkXvAlNBcB4M6ujRWYH5Lffth2MdkccIUPXfwjF4MkGSErTFitUqR+sglo+HxZbkWEIbj
        5nfK/HY2sMh5Dth4MXPsrcFN1qUYG2GbD/L7XjK9ivniLKaQGdtHuNrTU0hE0OujrUlNMcZYQ5y5N
        0cvavI11AxrJVt2QdEgfpzoc2ZIW9tqunHmkb5YpKQMsR4uGpp+cVmSSJ+lhkTZlXrSPGiB9AKCG0
        S5EwE0GGQShYlgeMyYzA+tLf7cx4rdPqerZ0z7Eu3nO3Ko9MYP873E7GDVzf2xk0zMb7dq3xtELlP
        +tOWc1TQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1ht966-0006Ue-Iq; Thu, 01 Aug 2019 11:18:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7C4F52029FA0E; Thu,  1 Aug 2019 13:18:12 +0200 (CEST)
Message-Id: <20190801111541.685367413@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 01 Aug 2019 13:13:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        Suren Baghdasaryan <surenb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/5] sched/pci: Reduce psimon FIFO priority
References: <20190801111348.530242235@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PSI defaults to a FIFO-99 thread, reduce this to FIFO-1.

FIFO-99 is the very highest priority available to SCHED_FIFO and
it not a suitable default; it would indicate the psi work is the
most important work on the machine.

Since Real-Time tasks will have pre-allocated memory and locked it in
place, Real-Time tasks do not care about PSI. All it needs is to be
above OTHER.

Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/psi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1051,7 +1051,7 @@ struct psi_trigger *psi_trigger_create(s
 
 	if (!rcu_access_pointer(group->poll_kworker)) {
 		struct sched_param param = {
-			.sched_priority = MAX_RT_PRIO - 1,
+			.sched_priority = 1,
 		};
 		struct kthread_worker *kworker;
 


