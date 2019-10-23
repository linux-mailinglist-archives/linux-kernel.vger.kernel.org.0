Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78458E266E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 00:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407929AbfJWWhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 18:37:05 -0400
Received: from mga05.intel.com ([192.55.52.43]:51990 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405969AbfJWWhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 18:37:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 15:37:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; 
   d="scan'208";a="373024319"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga005.jf.intel.com with ESMTP; 23 Oct 2019 15:37:04 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 6A14730038C; Wed, 23 Oct 2019 15:37:04 -0700 (PDT)
Date:   Wed, 23 Oct 2019 15:37:04 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Andi Kleen <andi@firstfloor.org>, Jiri Olsa <jolsa@redhat.com>,
        acme@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        eranian@google.com, kan.liang@linux.intel.com, peterz@infradead.org
Subject: Re: [PATCH v2 4/9] perf affinity: Add infrastructure to save/restore
 affinity
Message-ID: <20191023223704.GI4660@tassilo.jf.intel.com>
References: <20191020175202.32456-1-andi@firstfloor.org>
 <20191020175202.32456-5-andi@firstfloor.org>
 <20191023095911.GJ22919@krava>
 <20191023130235.GF4660@tassilo.jf.intel.com>
 <20191023143049.GS22919@krava>
 <20191023145206.GH4660@tassilo.jf.intel.com>
 <6ac1024c-bc73-87cd-31d2-819abee60137@linux.intel.com>
 <20191023171904.ft735ormkro6tahp@two.firstfloor.org>
 <346239e4-f156-01bb-4e42-85db289c476b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <346239e4-f156-01bb-4e42-85db289c476b@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 09:08:47PM +0300, Alexey Budankov wrote:
> On 23.10.2019 20:19, Andi Kleen wrote:
> > On Wed, Oct 23, 2019 at 07:16:13PM +0300, Alexey Budankov wrote:
> >>
> >> On 23.10.2019 17:52, Andi Kleen wrote:
> >>> On Wed, Oct 23, 2019 at 04:30:49PM +0200, Jiri Olsa wrote:
> >>>> On Wed, Oct 23, 2019 at 06:02:35AM -0700, Andi Kleen wrote:
> >>>>> On Wed, Oct 23, 2019 at 11:59:11AM +0200, Jiri Olsa wrote:
> >>>>>> On Sun, Oct 20, 2019 at 10:51:57AM -0700, Andi Kleen wrote:
> >>>>>>
> >>>>>> SNIP
> >>>>>>
> >>>>>>> +}
> >>>>>>> diff --git a/tools/perf/util/affinity.h b/tools/perf/util/affinity.h
> >>>>>>> new file mode 100644
> >>>>>>> index 000000000000..e56148607e33
> >>>>>>> --- /dev/null
> >>>>>>> +++ b/tools/perf/util/affinity.h
> >>>>>>> @@ -0,0 +1,15 @@
> >>>>>>> +// SPDX-License-Identifier: GPL-2.0
> >>>>>>> +#ifndef AFFINITY_H
> >>>>>>> +#define AFFINITY_H 1
> >>>>>>> +
> >>>>>>> +struct affinity {
> >>>>>>> +	unsigned char *orig_cpus;
> >>>>>>> +	unsigned char *sched_cpus;
> >>>>>>
> >>>>>> why not use cpu_set_t directly?
> >>>>>
> >>>>> Because it's too small in glibc (only 1024 CPUs) and perf already 
> >>>>> supports more.
> >>>>
> >>>> nice, we're using it all over the place.. how about using bitmap_alloc?
> >>>
> >>> Okay.
> >>>
> >>> The other places is mainly perf record from Alexey's recent affinity changes.
> >>> These probably need to be fixed.
> >>>
> >>> +Alexey
> >>
> >> Despite the issue indeed looks generic for stat and record modes,
> >> have you already observed record startup overhead somewhere in your setups?
> >> I would, first, prefer to reproduce the overhead, to have stable use case 
> >> for evaluation and then, possibly, improvement.
> > 
> > What I meant the cpu_set usages you added in 
> > 
> > commit 9d2ed64587c045304efe8872b0258c30803d370c
> > Author: Alexey Budankov <alexey.budankov@linux.intel.com>
> > Date:   Tue Jan 22 20:47:43 2019 +0300
> > 
> >     perf record: Allocate affinity masks
> > 
> > need to be fixed to allocate dynamically, or at least use MAX_NR_CPUs to
> > support systems with >1024CPUs. That's an independent functionality
> > problem.
> 
> Oh, it is clear now. Thanks for pointing this out. For that to move from 
> cpu_mask_t to new custom struct affinity type its API requires extension 
> to provide mask operations similar to the ones that cpu_mask_t provides: 
> CPU_ZERO(), CPU_SET(), CPU_EQUAL(), CPU_OR().
> 
> For example it could be like: affinity__mask_zero(), affinity__mask_set(), 
> affinity__mask_equal(), affinity__mask_or() and then the collecting part 
> of record could also be moved to struct affinity type and overcome >1024CPUs 
> limitation.

Not sure you need to use my library, except perhaps the get_cpu_set_size()
function. It is somewhat specialized.

Everything else you can use normal Linux bitmap functions,
or call the sys call directly.

-Andi
