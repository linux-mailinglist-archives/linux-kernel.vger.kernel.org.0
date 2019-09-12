Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2956B0E82
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 14:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731599AbfILMET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 08:04:19 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:39751 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730454AbfILMET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 08:04:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0Tc9SThJ_1568289840;
Received: from aaronlu(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0Tc9SThJ_1568289840)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 Sep 2019 20:04:06 +0800
Date:   Thu, 12 Sep 2019 20:04:00 +0800
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
Message-ID: <20190912120400.GA16200@aaronlu>
References: <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
 <20190725143003.GA992@aaronlu>
 <20190726152101.GA27884@sinkpad>
 <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
 <20190802153715.GA18075@sinkpad>
 <eec72c2d533b7600c63de3c8001cc6ab9e915afe.camel@suse.com>
 <69cd9bca-da28-1d35-3913-1efefe0c1c22@linux.intel.com>
 <fab8eabb-1cfa-9bf6-02af-3afdff3f955d@linux.intel.com>
 <20190911140204.GA52872@aaronlu>
 <7b001860-05b4-4308-df0e-8b60037b8000@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b001860-05b4-4308-df0e-8b60037b8000@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 09:19:02AM -0700, Tim Chen wrote:
> On 9/11/19 7:02 AM, Aaron Lu wrote:
> > Hi Tim & Julien,
> > 
> > On Fri, Sep 06, 2019 at 11:30:20AM -0700, Tim Chen wrote:
> >> On 8/7/19 10:10 AM, Tim Chen wrote:
> >>
> >>> 3) Load balancing between CPU cores
> >>> -----------------------------------
> >>> Say if one CPU core's sibling threads get forced idled
> >>> a lot as it has mostly incompatible tasks between the siblings,
> >>> moving the incompatible load to other cores and pulling
> >>> compatible load to the core could help CPU utilization.
> >>>
> >>> So just considering the load of a task is not enough during
> >>> load balancing, task compatibility also needs to be considered.
> >>> Peter has put in mechanisms to balance compatible tasks between
> >>> CPU thread siblings, but not across cores.
> >>>
> >>> Status:
> >>> I have not seen patches on this issue.  This issue could lead to
> >>> large variance in workload performance based on your luck
> >>> in placing the workload among the cores.
> >>>
> >>
> >> I've made an attempt in the following two patches to address
> >> the load balancing of mismatched load between the siblings.
> >>
> >> It is applied on top of Aaron's patches:
> >> - sched: Fix incorrect rq tagged as forced idle
> >> - wrapper for cfs_rq->min_vruntime
> >>   https://lore.kernel.org/lkml/20190725143127.GB992@aaronlu/
> >> - core vruntime comparison
> >>   https://lore.kernel.org/lkml/20190725143248.GC992@aaronlu/
> > 
> > So both of you are working on top of my 2 patches that deal with the
> > fairness issue, but I had the feeling Tim's alternative patches[1] are
> > simpler than mine and achieves the same result(after the force idle tag
> 
> I think Julien's result show that my patches did not do as well as
> your patches for fairness. Aubrey did some other testing with the same
> conclusion.  So I think keeping the forced idle time balanced is not
> enough for maintaining fairness.

Well, I have done following tests:
1 Julien's test script: https://paste.debian.net/plainh/834cf45c
2 start two tagged will-it-scale/page_fault1, see how each performs;
3 Aubrey's mysql test: https://github.com/aubreyli/coresched_bench.git

They all show your patchset performs equally well...And consider what
the patch does, I think they are really doing the same thing in
different ways.
