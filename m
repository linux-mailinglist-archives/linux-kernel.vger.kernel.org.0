Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5641D105ADE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 21:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfKUUNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 15:13:25 -0500
Received: from mga01.intel.com ([192.55.52.88]:24544 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfKUUNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 15:13:25 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 12:13:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,227,1571727600"; 
   d="scan'208";a="216209902"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga001.fm.intel.com with ESMTP; 21 Nov 2019 12:13:24 -0800
Date:   Thu, 21 Nov 2019 12:25:35 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Message-ID: <20191121202535.GC199273@romley-ivt3.sc.intel.com>
References: <20191121185303.GB199273@romley-ivt3.sc.intel.com>
 <4BB1CB74-887B-4F40-B3B2-F0147B264C34@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4BB1CB74-887B-4F40-B3B2-F0147B264C34@amacapital.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 11:01:39AM -0800, Andy Lutomirski wrote:
> 
> > On Nov 21, 2019, at 10:40 AM, Fenghua Yu <fenghua.yu@intel.com> wrote:
> > 
> > ﻿On Thu, Nov 21, 2019 at 09:51:03AM -0800, Andy Lutomirski wrote:
> >>> On Thu, Nov 21, 2019 at 9:43 AM David Laight <David.Laight@aculab.com> wrote:
> >>> 
> >>> From: Ingo Molnar
> >>>> Sent: 21 November 2019 17:12
> >>>> * Peter Zijlstra <peterz@infradead.org> wrote:
> >>> ...
> >>>>> This feature MUST be default enabled, otherwise everything will
> >>>>> be/remain broken and we'll end up in the situation where you can't use
> >>>>> it even if you wanted to.
> >>>> 
> >>>> Agreed.
> >>> 
> >>> Before it can be enabled by default someone needs to go through the
> >>> kernel and fix all the code that abuses the 'bit' functions by using them
> >>> on int[] instead of long[].
> >>> 
> >>> I've only seen one fix go through for one use case of one piece of code
> >>> that repeatedly uses potentially misaligned int[] arrays for bitmasks.
> >>> 
> >> 
> >> Can we really not just change the lock asm to use 32-bit accesses for
> >> set_bit(), etc?  Sure, it will fail if the bit index is greater than
> >> 2^32, but that seems nuts.
> >> 
> >> (Why the *hell* do the bitops use long anyway?  They're *bit masks*
> >> for crying out loud.  As in, users generally want to operate on fixed
> >> numbers of bits.)
> > 
> > We are working on a separate patch set to fix all split lock issues
> > in atomic bitops. Per Peter Anvin and Tony Luck suggestions:
> > 1. Still keep the byte optimization if nr is constant. No split lock.
> > 2. If type of *addr is unsigned long, do quadword atomic instruction
> >   on addr. No split lock.
> > 3. If type of *addr is unsigned int, do word atomic instruction
> >   on addr. No split lock.
> > 4. Otherwise, re-calculate addr to point the 32-bit address which contains
> >   the bit and operate on the bit. No split lock.
> > 
> > Only small percentage of atomic bitops calls are in case 4 (e.g. 3%
> > for set_bit()) which need a few extra instructions to re-calculate
> > address but can avoid big split lock overhead.
> > 
> > To get real type of *addr instead of type cast type "unsigned long",
> > the atomic bitops APIs are changed to macros from functions. This change
> > need to touch all architectures.
> > 
> 
> Isn’t the kernel full of casts to long* to match the signature?  Doing this based on type seems silly to me. I think it’s better to just to a 32-bit operation unconditionally and to try to optimize it
>using b*l when safe.

Actually we only find 8 places calling atomic bitops using type casting
"unsigned long *". After above changes, other 8 patches remove the type
castings and then split lock free in atomic bitops in the current kernel.

To check type casting in new patches, we add checkpatch.pl to warn on
any type casting on atomic bitops in new patches because the APIs are
marocs and gcc doesn't warn/issue error on type casting.

Using b*l will change the 8 places as well plus a lot of other places
where *addr is defined as "unsigned long *", right?

Thanks.

-Fenghua

