Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9EA179E03
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 03:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbfG3Bin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 21:38:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:14714 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729221AbfG3Bin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:38:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2019 18:38:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,324,1559545200"; 
   d="scan'208";a="165675363"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.29])
  by orsmga008.jf.intel.com with ESMTP; 29 Jul 2019 18:38:40 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Rik van Riel <riel@redhat.com>,
        <jhladky@redhat.com>, <lvenanci@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RESEND] autonuma: Fix scan period updating
References: <20190725080124.494-1-ying.huang@intel.com>
        <20190725173516.GA16399@linux.vnet.ibm.com>
        <87y30l5jdo.fsf@yhuang-dev.intel.com>
        <20190726092021.GA5273@linux.vnet.ibm.com>
        <87ef295yn9.fsf@yhuang-dev.intel.com>
        <20190729072845.GC7168@linux.vnet.ibm.com>
        <87wog145nn.fsf@yhuang-dev.intel.com> <20190729085646.GG2708@suse.de>
Date:   Tue, 30 Jul 2019 09:38:39 +0800
In-Reply-To: <20190729085646.GG2708@suse.de> (Mel Gorman's message of "Mon, 29
        Jul 2019 09:56:46 +0100")
Message-ID: <87ftmo47z4.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mgorman@suse.de> writes:

> On Mon, Jul 29, 2019 at 04:16:28PM +0800, Huang, Ying wrote:
>> Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
>> 
>> >> >> 
>> >> >> if (lr_ratio >= NUMA_PERIOD_THRESHOLD)
>> >> >>     slow down scanning
>> >> >> else if (sp_ratio >= NUMA_PERIOD_THRESHOLD) {
>> >> >>     if (NUMA_PERIOD_SLOTS - lr_ratio >= NUMA_PERIOD_THRESHOLD)
>> >> >>         speed up scanning
>> >> 
>> >> Thought about this again.  For example, a multi-threads workload runs on
>> >> a 4-sockets machine, and most memory accesses are shared.  The optimal
>> >> situation will be pseudo-interleaving, that is, spreading memory
>> >> accesses evenly among 4 NUMA nodes.  Where "share" >> "private", and
>> >> "remote" > "local".  And we should slow down scanning to reduce the
>> >> overhead.
>> >> 
>> >> What do you think about this?
>> >
>> > If all 4 nodes have equal access, then all 4 nodes will be active nodes.
>> >
>> > From task_numa_fault()
>> >
>> > 	if (!priv && !local && ng && ng->active_nodes > 1 &&
>> > 				numa_is_active_node(cpu_node, ng) &&
>> > 				numa_is_active_node(mem_node, ng))
>> > 		local = 1;
>> >
>> > Hence all accesses will be accounted as local. Hence scanning would slow
>> > down.
>> 
>> Yes.  You are right!  Thanks a lot!
>> 
>> There may be another case.  For example, a workload with 9 threads runs
>> on a 2-sockets machine, and most memory accesses are shared.  7 threads
>> runs on the node 0 and 2 threads runs on the node 1 based on CPU load
>> balancing.  Then the 2 threads on the node 1 will have "share" >>
>> "private" and "remote" >> "local".  But it doesn't help to speed up
>> scanning.
>> 
>
> Ok, so the results from the patch are mostly neutral. There are some
> small differences in scan rates depending on the workload but it's not
> universal and the headline performance is sometimes worse. I couldn't
> find something that would justify the change on its own.

Thanks a lot for your help!

> I think in the short term -- just fix the comments.

Then we will change the comments to something like,

"Slow down scanning if most memory accesses are private."

It's hard to be understood.  Maybe we just keep the code and comments as
it was until we have better understanding.

> For the shared access consideration, the scan rate is important but so too
> is the decision on when pseudo interleaving should be used. Both should
> probably be taken into account when making changes in this area. The
> current code may not be optimal but it also has not generated bug reports,
> high CPU usage or obviously bad locality decision in the field.  Hence,
> for this patch or a similar series, it is critical that some workloads are
> selected that really care about the locality of shared access and evaluate
> based on that. Initially it was done with a large battery of tests run
> by different people but some of those people have changed role since and
> would not be in a position to rerun the tests. There also was the issue
> that when those were done, NUMA balancing was new so it's comparative
> baseline was "do nothing at all".

Yes.  I totally agree that we should change the behavior based on
testing.

Best Regards,
Huang, Ying
