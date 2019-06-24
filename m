Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB7DB5195C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 19:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732334AbfFXROF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 13:14:05 -0400
Received: from foss.arm.com ([217.140.110.172]:55174 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbfFXROE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 13:14:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19E05360;
        Mon, 24 Jun 2019 10:14:04 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67FD73F718;
        Mon, 24 Jun 2019 10:14:02 -0700 (PDT)
Date:   Mon, 24 Jun 2019 18:14:00 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/4] arm64: wire up VM_FLUSH_RESET_PERMS
Message-ID: <20190624171358.GI29120@arrakis.emea.arm.com>
References: <20190523102256.29168-1-ard.biesheuvel@arm.com>
 <20190528100413.GA20809@fuggles.cambridge.arm.com>
 <20190624111600.b7e5kkfvuszj6522@willie-the-truck>
 <07e3d9ea-b917-2adb-6f88-0f1a31692d04@arm.com>
 <CAKv+Gu9VcXuz8P7-2=MZjDj-7nVOEA8FUE1fRYTvtt1mvt99Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9VcXuz8P7-2=MZjDj-7nVOEA8FUE1fRYTvtt1mvt99Yw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 04:29:39PM +0200, Ard Biesheuvel wrote:
> On Mon, 24 Jun 2019 at 13:23, Ard Biesheuvel <ard.biesheuvel@arm.com> wrote:
> > On 6/24/19 1:16 PM, Will Deacon wrote:
> > > On Tue, May 28, 2019 at 11:04:20AM +0100, Will Deacon wrote:
> > >> On Thu, May 23, 2019 at 11:22:52AM +0100, Ard Biesheuvel wrote:
> > >>> Ard Biesheuvel (4):
> > >>>    arm64: module: create module allocations without exec permissions
> > >>>    arm64/mm: wire up CONFIG_ARCH_HAS_SET_DIRECT_MAP
> > >>>    arm64/kprobes: set VM_FLUSH_RESET_PERMS on kprobe instruction pages
> > >>>    arm64: bpf: do not allocate executable memory
> > >>>
> > >>>   arch/arm64/Kconfig                  |  1 +
> > >>>   arch/arm64/include/asm/cacheflush.h |  3 ++
> > >>>   arch/arm64/kernel/module.c          |  4 +-
> > >>>   arch/arm64/kernel/probes/kprobes.c  |  4 +-
> > >>>   arch/arm64/mm/pageattr.c            | 48 ++++++++++++++++----
> > >>>   arch/arm64/net/bpf_jit_comp.c       |  2 +-
> > >>>   mm/vmalloc.c                        | 11 -----
> > >>>   7 files changed, 50 insertions(+), 23 deletions(-)
> > >>
> > >> Thanks, this all looks good to me. I can get pick this up for 5.2 if
> > >> Rick's fixes [1] land soon enough.
> > >
> > > Bah, I missed these landing in -rc5 and I think it's a bit too late for
> > > us to take this for 5.2. now particularly with our limited ability to
> > > fix any late regressions that might arise.
> > >
> > > In which case, Catalin, please can you take these for 5.3? You might run
> > > into some testing failures with for-next/core due to the late of Rick's
> > > fixes, but linux-next should be alright and I don't think you'll get any
> > > conflicts.
> > >
> > > Acked-by: Will Deacon <will@kernel.org>
> > >
> > > Ard: are you ok with that?
> >
> > That is fine, although I won't be around to pick up the pieces by the
> > time the merge window opens. Also, I'd like to follow up on the lazy
> > vunmap thing for non-x86, but perhaps we can talk about this at plumbers?
> 
> Actually, you will run into a couple of conflicts. Let me know if you
> want me to respin (although they still won't apply cleanly to both
> for-next/core and -next)

I queued them in for-next/core (and fixed a minor conflict). Thanks.

-- 
Catalin
