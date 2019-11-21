Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D32061058A0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 18:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfKUReq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 12:34:46 -0500
Received: from mga17.intel.com ([192.55.52.151]:46714 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKURep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:34:45 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 09:34:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,226,1571727600"; 
   d="scan'208";a="209981488"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga003.jf.intel.com with ESMTP; 21 Nov 2019 09:34:44 -0800
Date:   Thu, 21 Nov 2019 09:34:44 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Message-ID: <20191121173444.GA5581@agluck-desk2.amr.corp.intel.com>
References: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
 <1574297603-198156-7-git-send-email-fenghua.yu@intel.com>
 <20191121060444.GA55272@gmail.com>
 <20191121130153.GS4097@hirez.programming.kicks-ass.net>
 <20191121171214.GD12042@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121171214.GD12042@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 06:12:14PM +0100, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Thu, Nov 21, 2019 at 07:04:44AM +0100, Ingo Molnar wrote:
> > > * Fenghua Yu <fenghua.yu@intel.com> wrote:
> > 
> > > > +	split_lock_detect
> > > > +			[X86] Enable split lock detection
> > > > +			This is a real time or debugging feature. When enabled
> > > > +			(and if hardware support is present), atomic
> > > > +			instructions that access data across cache line
> > > > +			boundaries will result in an alignment check exception.
> > > > +			When triggered in applications the kernel will send
> > > > +			SIGBUS. The kernel will panic for a split lock in
> > > > +			OS code.
> > > 
> > > It would be really nice to be able to enable/disable this runtime as 
> > > well, has this been raised before, and what was the conclusion?
> > 
> > It has, previous versions had that. Somehow a lot of things went missing
> > and we're back to a broken neutered useless mess.
> > 
> > The problem appears to be that due to hardware design the feature cannot
> > be virtualized, and instead of then disabling it when a VM runs/exists
> > they just threw in the towel and went back to useless mode.. :-(
> > 
> > This feature MUST be default enabled, otherwise everything will
> > be/remain broken and we'll end up in the situation where you can't use
> > it even if you wanted to.
> 
> Agreed.
> 
> > And I can't be arsed to look it up, but we've been making this very 
> > same argument since very early (possible the very first) version.
> 
> Yeah, I now have a distinct deja vu...

You'll notice that we are at version 10 ... lots of things have been tried
in previous versions. This new version is to get the core functionality
in, so we can build fancier features later.  Painful experience has shown
that trying to do this all at once just leads to churn with no progress.

Enabling by default at this point would result in a flurry of complaints
about applications being killed and kernels panicing. That would be
followed by:

#include <linus/all-caps-rant-about-backwards-compatability.h>

and the patches being reverted.

This version can serve a very useful purpose. CI systems with h/w that
supports split lock can enable it and begin the process of finding
and fixing the remaining kernel issues. Especially helpful if they run
randconfig and fuzzers.

We'd also find out which libraries and applications currently use
split locks.

Real-time folks that have identified split lock as a fatal (don't meet
their deadlines issue) could also enable it as is (because it is better
to crash the kernel and have the laser be powered down than to keep
firing long past the point it should have stopped).

Any developer with concerns about their BIOS using split locks can also
enable using this patch and begin testing today.

I'm totally on board with follow up patches providing extra features like:

	A way to enable/disable at run time.

	Providing a way to allow but rate limit applications that cause
	split locks.

	Figuring out something useful to do with virtualization.

Those are all good things to have - but we won't get *any* of them if we
wait until *all* have them have been perfected.

<soapbox>
So let's just take the first step now and solve world hunger tomorrow.
</soapbox>

-Tony
