Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E25DA16270C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 14:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgBRNWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 08:22:38 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49876 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgBRNWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 08:22:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VDHLWu39JTGXnvSuCqTu6wPEeUVN5TaC5Pa4fKQbOi0=; b=u7HWeoQquqyFUskQLOatRnHpU/
        YDftRdbVmII8+TjJuw6hYTZMu7dJx5M86eKMTq/xyE/3ym6vlfDaWj6OqgcnE0SlK/30Vi/CfRn6S
        MP5NksYoy3GlMSYif7UXddTe0lmTS8oIl7zkUDdrNwKcQ8oNJpA1uSx+2jPSKg5Aaj9rnS008G8jW
        ylQ5trxolWp+xX81HXEs9Z9oUc06UTES9cuqck/TNGR5rfKfxhCHOQ5KIEnsNEIgc9qPslMwSWvdx
        60RoCRMsWuy33kAGJP+5H/A5XwFeE64ZIDD2IbO3zMYLCtPUFEAaQ6NcC2xLFCo91JnBpenCOTn2M
        fOiFoylQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j42pB-0004fP-73; Tue, 18 Feb 2020 13:22:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5698D300565;
        Tue, 18 Feb 2020 14:20:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 369082B92FA22; Tue, 18 Feb 2020 14:22:03 +0100 (CET)
Date:   Tue, 18 Feb 2020 14:22:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, pauld@redhat.com,
        parth@linux.ibm.com, valentin.schneider@arm.com, hdanton@sina.com
Subject: Re: [PATCH v2 1/5] sched/fair: Reorder enqueue/dequeue_task_fair path
Message-ID: <20200218132203.GB14914@hirez.programming.kicks-ass.net>
References: <20200214152729.6059-1-vincent.guittot@linaro.org>
 <20200214152729.6059-2-vincent.guittot@linaro.org>
 <ee38d205-b356-9474-785e-e514d81b7d7f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee38d205-b356-9474-785e-e514d81b7d7f@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 01:37:37PM +0100, Dietmar Eggemann wrote:
> On 14/02/2020 16:27, Vincent Guittot wrote:
> > The walk through the cgroup hierarchy during the enqueue/dequeue of a task
> > is split in 2 distinct parts for throttled cfs_rq without any added value
> > but making code less readable.
> > 
> > Change the code ordering such that everything related to a cfs_rq
> > (throttled or not) will be done in the same loop.
> > 
> > In addition, the same steps ordering is used when updating a cfs_rq:
> > - update_load_avg
> > - update_cfs_group
> > - update *h_nr_running
> 
> Is this code change really necessary? You pay with two extra goto's. We
> still have the two for_each_sched_entity(se)'s because of 'if
> (se->on_rq); break;'.

IIRC he relies on the presented ordering in patch #5 -- adding the
running_avg metric.
