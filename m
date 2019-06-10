Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3F13B7B4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 16:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390947AbfFJOrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 10:47:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388373AbfFJOrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 10:47:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1C59AD56EF;
        Mon, 10 Jun 2019 14:46:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id EB5FD5DD63;
        Mon, 10 Jun 2019 14:46:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 10 Jun 2019 16:46:44 +0200 (CEST)
Date:   Mon, 10 Jun 2019 16:46:42 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Gaurav Kohli <gkohli@codeaurora.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Qian Cai <cai@lca.pw>,
        akpm@linux-foundation.org, hch@lst.de, mingo@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: fix a crash in do_task_dead()
Message-ID: <20190610144641.GA8127@redhat.com>
References: <1559161526-618-1-git-send-email-cai@lca.pw>
 <20190530080358.GG2623@hirez.programming.kicks-ass.net>
 <82e88482-1b53-9423-baad-484312957e48@kernel.dk>
 <20190603123705.GB3419@hirez.programming.kicks-ass.net>
 <ddf9ee34-cd97-a62b-6e91-6b4511586339@kernel.dk>
 <20190607133541.GJ3436@hirez.programming.kicks-ass.net>
 <20190607142332.GF3463@hirez.programming.kicks-ass.net>
 <16419960-3703-5988-e7ea-9d3a439f8b05@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16419960-3703-5988-e7ea-9d3a439f8b05@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 10 Jun 2019 14:47:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10, Gaurav Kohli wrote:
>
> >@@ -1991,6 +1991,28 @@ try_to_wake_up(struct task_struct *p, un
> >  	unsigned long flags;
> >  	int cpu, success = 0;
> >+	if (p == current) {
> >+		/*
> >+		 * We're waking current, this means 'p->on_rq' and 'task_cpu(p)
> >+		 * == smp_processor_id()'. Together this means we can special
> >+		 * case the whole 'p->on_rq && ttwu_remote()' case below
> >+		 * without taking any locks.
> >+		 *
> >+		 * In particular:
> >+		 *  - we rely on Program-Order guarantees for all the ordering,
> >+		 *  - we're serialized against set_special_state() by virtue of
> >+		 *    it disabling IRQs (this allows not taking ->pi_lock).
> >+		 */
> >+		if (!(p->state & state))
> >+			return false;
> >+
>
> Hi Peter, Jen,
>
> As we are not taking pi_lock here , is there possibility of same task dead
> call comes as this point of time for current thread, bcoz of which we have
> seen earlier issue after this commit 0619317ff8ba
> [T114538]  do_task_dead+0xf0/0xf8
> [T114538]  do_exit+0xd5c/0x10fc
> [T114538]  do_group_exit+0xf4/0x110
> [T114538]  get_signal+0x280/0xdd8
> [T114538]  do_notify_resume+0x720/0x968
> [T114538]  work_pending+0x8/0x10
>
> Is there a chance of TASK_DEAD set at this point of time?

In this case try_to_wake_up(current, TASK_NORMAL) will do nothing, see the
if (!(p->state & state)) above.

See also the comment about set_special_state() above. It disables irqs and
this is enough to ensure that try_to_wake_up(current) from irq can't race
with set_special_state(TASK_DEAD).

Oleg.

