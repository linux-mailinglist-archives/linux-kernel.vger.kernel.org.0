Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF9D7AD87
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 18:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfG3Q34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 12:29:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59886 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfG3Q3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zGVc/pyY2Km9LX6V8SnBhWdxyvSk4iYd46CX7MaxL3Q=; b=1aV4lQCWTmXBt4QcQjDXfTMiZ
        Wr0I/mX++WkGkzyNfbVhdjUHzy9CPYAyQJbEnFJx6sBwusmKgo2EJA2w51dH4KC3O3uHiiWGuWrQZ
        nQanZdrwUV8UzKDMHW5n7CvjWVRNgIhQc1odz/mGtd0bqwDC6rzo9fWH2GdDcb3E+zfhVd1cGMbYH
        oGabreNrHpY4CwHEJD2Cw8K3AD/Nz6OH7QVV5PYg5jY6OLKmyeomV2tmfbrBmBEh/hcuQI0I6+LnD
        RxvmkmvysPFD0KRJOswc3oDPff+LOdVTBDDCPJN1dd64tqmD21vV/PeRj36DZ5jIdgit47+QkiKvO
        wmWrBidrg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsV0I-00019U-F3; Tue, 30 Jul 2019 16:29:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2A9852029FD58; Tue, 30 Jul 2019 18:29:33 +0200 (CEST)
Date:   Tue, 30 Jul 2019 18:29:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        dietmar.eggemann@arm.com, mingo@redhat.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org
Subject: Re: [PATCH RFC v3 0/14] sched,fair: flatten CPU controller runqueues
Message-ID: <20190730162933.GW31398@hirez.programming.kicks-ass.net>
References: <20190722173348.9241-1-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722173348.9241-1-riel@surriel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 01:33:34PM -0400, Rik van Riel wrote:
> Plan for the CONFIG_CFS_BANDWIDTH reimplementation:
> - When a cgroup gets throttled, mark the cgroup and its children
>   as throttled.
> - When pick_next_entity finds a task that is on a throttled cgroup,
>   stash it on the cgroup runqueue (which is not used for runnable
>   tasks any more). Leave the vruntime unchanged, and adjust that
>   runqueue's vruntime to be that of the left-most task.

and ignore such tasks for the load-balancer; I suppose

> - When a cgroup gets unthrottled, and has tasks on it, place it on
>   a vruntime ordered heap separate from the main runqueue.

and expose said heap to the load-balancer..

Now, I suppose you do this because merging heaps is easier than merging
RB trees? (not in complexity iirc, but probably in code)

> - Have pick_next_task_fair grab one task off that heap every time it
>   is called, and the min vruntime of that heap is lower than the
>   vruntime of the CPU's cfs_rq (or the CPU has no other runnable tasks).

That's like a smeared out merge :-) But since the other tasks kept on
running, this CPUs vruntime will be (much) advanced vs those throttled
tasks and we'll most likely end up picking them all before we pick a
'normal' task.

> - Place that selected task on the CPU's cfs_rq, renormalizing its
>   vruntime with the GENTLE_FAIR_SLEEPERS logic. That should help
>   interleave the already runnable tasks with the recently unthrottled
>   group, and prevent thundering herd issues.
> - If the group gets throttled again before all of its task had a chance
>   to run, vruntime sorting ensures all the tasks in the throttled cgroup
>   get a chance to run over time.


