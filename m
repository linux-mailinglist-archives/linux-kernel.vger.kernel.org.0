Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B768A0B11
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 22:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfH1UFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 16:05:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48397 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfH1UFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 16:05:47 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i34CJ-0003m5-3r; Wed, 28 Aug 2019 22:05:39 +0200
Date:   Wed, 28 Aug 2019 22:05:38 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Song Liu <songliubraving@fb.com>
cc:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [patch 1/2] x86/mm/pti: Handle unaligned address gracefully in
 pti_clone_pagetable()
In-Reply-To: <309E5006-E869-4761-ADE2-ADB7A1A63FF1@fb.com>
Message-ID: <alpine.DEB.2.21.1908282029550.1938@nanos.tec.linutronix.de>
References: <20190828142445.454151604@linutronix.de> <20190828143123.971884723@linutronix.de> <55bb026c-5d54-6ebf-608f-3f376fbec4e5@intel.com> <alpine.DEB.2.21.1908281750410.1938@nanos.tec.linutronix.de> <309E5006-E869-4761-ADE2-ADB7A1A63FF1@fb.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019, Song Liu wrote:
> > On Aug 28, 2019, at 8:51 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > 
> > On Wed, 28 Aug 2019, Dave Hansen wrote:
> >> On 8/28/19 7:24 AM, Thomas Gleixner wrote:
> >>> From: Song Liu <songliubraving@fb.com>
> >>> 
> >>> pti_clone_pmds() assumes that the supplied address is either:
> >>> 
> >>> - properly PUD/PMD aligned
> >>> or
> >>> - the address is actually mapped which means that independent
> >>>   of the mapping level (PUD/PMD/PTE) the next higher mapping
> >>>   exist.
> >>> 
> >>> If that's not the case the unaligned address can be incremented by PUD or
> >>> PMD size wrongly. All callers supply mapped and/or aligned addresses, but
> >>> for robustness sake, it's better to handle that case proper and to emit a
> >>> warning.
> >> 
> >> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> >> 
> >> Song, did you ever root-cause the performance regression?  I thought
> >> there were still some mysteries there.
> > 
> > See Peter's series to rework the ftrace code patching ...
> 
> Thanks Thomas. 
> 
> Yes, in summary, enabling ftrace or kprobe-on-ftrace causes the kernel
> to split PMDs in kernel text mapping. 
> 
> Related question: while Peter's patches fix it for 5.3 kernel, they don't 
> apply cleanly over 5.2 kernel (which we are using). So I wonder what is
> the best solution for 5.2 kernel. May patch also fixes the issue:
> 
> https://lore.kernel.org/lkml/20190823052335.572133-1-songliubraving@fb.com/
> 
> How about we apply this patch to upstream 5.2 kernel?

That's not how it works. We fix stuff upstream and it gets backported to
all affected kernels not just to the one you care about.

Aside of that I really disagree with that hack. You completely fail to
explain why that commit in question broke it and instead of fixing the
underlying issue you create a horrible workaround.

It took me ~10 minutes to analyze the root cause and I'm just booting the
test box with a proper fix which can be actually tagged for stable and can
be removed from upstream again once ftrace got moved over to text poke.

I'll post it once it's confirmed to work and I wrote a comprehensible
changelog.

Thanks,

	tglx




