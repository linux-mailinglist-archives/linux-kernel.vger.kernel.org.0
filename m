Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF4715BD8C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 12:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgBMLSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 06:18:07 -0500
Received: from outbound-smtp20.blacknight.com ([46.22.139.247]:35152 "EHLO
        outbound-smtp20.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729526AbgBMLSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 06:18:07 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp20.blacknight.com (Postfix) with ESMTPS id E33D61C27FB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 11:18:04 +0000 (GMT)
Received: (qmail 6488 invoked from network); 13 Feb 2020 11:18:04 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 13 Feb 2020 11:18:04 -0000
Date:   Thu, 13 Feb 2020 11:18:02 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/11] sched/numa: Bias swapping tasks based on their
 preferred node
Message-ID: <20200213111802.GW3466@techsingularity.net>
References: <20200212093654.4816-1-mgorman@techsingularity.net>
 <20200212093654.4816-9-mgorman@techsingularity.net>
 <20200213103108.GG14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200213103108.GG14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 11:31:08AM +0100, Peter Zijlstra wrote:
> On Wed, Feb 12, 2020 at 09:36:51AM +0000, Mel Gorman wrote:
> > When swapping tasks for NUMA balancing, it is preferred that tasks move
> > to or remain on their preferred node. When considering an imbalance,
> > encourage tasks to move to their preferred node and discourage tasks from
> > moving away from their preferred node.
> 
> Wasn't there an issue for workloads that span multiple nodes?
> 

Sortof, yes -- specifically workloads that could not fit inside a node
for whatever reason.

> Say a 4 node system with 2 warehouses? Then each JVM will want 2 nodes,
> instead of a single node, and strong preferred node stuff makes it
> difficult to achieve this.
> 
> I forgot how we dealt with these cases, just something I worry about
> when reading this.

We deal with it in task_numa_migrate() by considering nodes other
than the preferred node for placement -- see "Look at other nodes in
these cases" followed by a sched_setnuma if the preferred node doesn't
match.

We do not do any special casing as such in task_numa_compare other than
finding the best improvement so we can pick a task belonging to a group
spanning multiple nodes with or without this patch. A workload spanning
multiple nodes in itself does not justify a full search if it can be
avoided.

-- 
Mel Gorman
SUSE Labs
