Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E727314DF66
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 17:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgA3Qpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 11:45:45 -0500
Received: from foss.arm.com ([217.140.110.172]:55374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727224AbgA3Qpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 11:45:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3159131B;
        Thu, 30 Jan 2020 08:45:44 -0800 (PST)
Received: from localhost (unknown [10.1.198.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C72EC3F67D;
        Thu, 30 Jan 2020 08:45:43 -0800 (PST)
Date:   Thu, 30 Jan 2020 16:45:42 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, sudeep.holla@arm.com, dietmar.eggemann@arm.com,
        peterz@infradead.org, mingo@redhat.com, ggherdovich@suse.cz,
        vincent.guittot@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 4/6] Documentation: arm64: document support for the
 AMU extension
Message-ID: <20200130164542.GC5208@arm.com>
References: <20191218182607.21607-1-ionela.voinescu@arm.com>
 <20191218182607.21607-5-ionela.voinescu@arm.com>
 <c9f80a08-7f0d-59e9-eb90-466b1314e1f1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9f80a08-7f0d-59e9-eb90-466b1314e1f1@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Thursday 30 Jan 2020 at 15:04:27 (+0000), Suzuki Kuruppassery Poulose wrote:
> Hi Ionela,
> 
> On 18/12/2019 18:26, Ionela Voinescu wrote:
> > The activity monitors extension is an optional extension introduced
> > by the ARMv8.4 CPU architecture.
> > 
> > Add initial documentation for the AMUv1 extension:
> >   - arm64/amu.txt: AMUv1 documentation
> >   - arm64/booting.txt: system registers initialisation
> >   - arm64/cpu-feature-registers.txt: visibility to userspace
> 
> We have stopped adding "invisible" fields to the list. So, you
> can drop the changes to cpu-feature-registers.txt.
> 
> > 
> > Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > ---
> >   Documentation/arm64/amu.rst                   | 107 ++++++++++++++++++
> >   Documentation/arm64/booting.rst               |  14 +++
> >   Documentation/arm64/cpu-feature-registers.rst |   2 +
> >   Documentation/arm64/index.rst                 |   1 +
> >   4 files changed, 124 insertions(+)
> >   create mode 100644 Documentation/arm64/amu.rst
> > 
> > diff --git a/Documentation/arm64/amu.rst b/Documentation/arm64/amu.rst
> > new file mode 100644
> > index 000000000000..62a6635522e1
> > --- /dev/null
> > +++ b/Documentation/arm64/amu.rst
> > @@ -0,0 +1,107 @@
> > +=======================================================
> > +Activity Monitors Unit (AMU) extension in AArch64 Linux
> > +=======================================================
> > +
> > +Author: Ionela Voinescu <ionela.voinescu@arm.com>
> > +
> > +Date: 2019-09-10
> > +
> > +This document briefly describes the provision of Activity Monitors Unit
> > +support in AArch64 Linux.
> > +
> > +
> > +Architecture overview
> > +---------------------
> > +
> > +The activity monitors extension is an optional extension introduced by the
> > +ARMv8.4 CPU architecture.
> > +
> > +The activity monitors unit, implemented in each CPU, provides performance
> > +counters intended for system management use. The AMU extension provides a
> > +system register interface to the counter registers and also supports an
> > +optional external memory-mapped interface.
> > +
> > +Version 1 of the Activity Monitors architecture implements a counter group
> > +of four fixed and architecturally defined 64-bit event counters.
> > +  - CPU cycle counter: increments at the frequency of the CPU.
> > +  - Constant counter: increments at the fixed frequency of the system
> > +    clock.
> > +  - Instructions retired: increments with every architecturally executed
> > +    instruction.
> > +  - Memory stall cycles: counts instruction dispatch stall cycles caused by
> > +    misses in the last level cache within the clock domain.
> > +
> > +When in WFI or WFE these counters do not increment.
> > +
> > +The Activity Monitors architecture provides space for up to 16 architected
> > +event counters. Future versions of the architecture may use this space to
> > +implement additional architected event counters.
> > +
> > +Additionally, version 1 implements a counter group of up to 16 auxiliary
> > +64-bit event counters.
> > +
> > +On cold reset all counters reset to 0.
> > +
> > +
> > +Basic support
> > +-------------
> > +
> > +The kernel can safely run a mix of CPUs with and without support for the
> > +activity monitors extension.
> 
> 
>  Therefore, when CONFIG_ARM64_AMU_EXTN is
> > +selected we unconditionally enable the capability to allow any late CPU
> > +(secondary or hotplugged) to detect and use the feature.
> > +
> > +When the feature is detected on a CPU, a per-CPU variable (amu_feat) is
> > +set, but this does not guarantee the correct functionality of the
> > +counters, only the presence of the extension.
> 
> nit: I would rather omit the implementation details (esp variable names)
> in the documentation. It may become a pain to keep this in sync with the
> code changes. You could simply mention, "we keep track of the availability
> of the feature" per CPU. If someone wants to figure out
> how, they can always read the code.
> 
> > +
> > +Firmware (code running at higher exception levels, e.g. arm-tf) support is
> > +needed to:
> > + - Enable access for lower exception levels (EL2 and EL1) to the AMU
> > +   registers.
> > + - Enable the counters. If not enabled these will read as 0.
> > + - Save/restore the counters before/after the CPU is being put/brought up
> > +   from the 'off' power state.
> > +
> > +When using kernels that have this configuration enabled but boot with
> > +broken firmware the user may experience panics or lockups when accessing
> > +the counter registers. Even if these symptoms are not observed, the
> > +values returned by the register reads might not correctly reflect reality.
> > +Most commonly, the counters will read as 0, indicating that they are not
> > +enabled. If proper support is not provided in firmware it's best to disable
> > +CONFIG_ARM64_AMU_EXTN.
> 
> For the sake of one kernel runs everywhere, do we need some other
> mechanism to disable the AMU. e.g kernel parameter to disable amu
> at runtime ?
>

The reason I've not added this is twofold:
 - Even if we add this, it should be in order to disable the use of the
   counters for a certain purpose, in this case  frequency invariance.
   On its own AMU provides the counters but it does not mandate their
   use.
 - I could add something to disable the use of the core and cycle
   counters for frequency invariance at runtime, but I doubt that
   anyone would use it. Logically it makes sense to use the counters
   order to have a more accurate view of the performance that the CPUs
   are actually providing. Therefore, until anyone asks for this, I
   thought it's better to keep it simple and not add extra switches,
   until there is a use for them.

Does it make sense?

P.S. I'll make all the other changes you've suggested in v3. 

Thank you,
Ionela.



> > diff --git a/Documentation/arm64/booting.rst b/Documentation/arm64/booting.rst
> > index 5d78a6f5b0ae..a3f1a47b6f1c 100644
> > --- a/Documentation/arm64/booting.rst
> > +++ b/Documentation/arm64/booting.rst
> > @@ -248,6 +248,20 @@ Before jumping into the kernel, the following conditions must be met:
> >       - HCR_EL2.APK (bit 40) must be initialised to 0b1
> >       - HCR_EL2.API (bit 41) must be initialised to 0b1
> > +  For CPUs with Activity Monitors Unit v1 (AMUv1) extension present:
> > +  - If EL3 is present:
> > +    CPTR_EL3.TAM (bit 30) must be initialised to 0b0
> > +    CPTR_EL2.TAM (bit 30) must be initialised to 0b0
> > +    AMCNTENSET0_EL0 must be initialised to 0b1111
> > +    AMCNTENSET1_EL0 must be initialised to a platform specific value
> > +    having 0b1 set for the corresponding bit for each of the auxiliary
> > +    counters present.
> > +  - If the kernel is entered at EL1:
> > +    AMCNTENSET0_EL0 must be initialised to 0b1111
> > +    AMCNTENSET1_EL0 must be initialised to a platform specific value
> > +    having 0b1 set for the corresponding bit for each of the auxiliary
> > +    counters present.
> > +
> >   The requirements described above for CPU mode, caches, MMUs, architected
> >   timers, coherency and system registers apply to all CPUs.  All CPUs must
> >   enter the kernel in the same exception level.
> > diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arm64/cpu-feature-registers.rst
> > index b6e44884e3ad..4770ae54032b 100644
> > --- a/Documentation/arm64/cpu-feature-registers.rst
> > +++ b/Documentation/arm64/cpu-feature-registers.rst
> > @@ -150,6 +150,8 @@ infrastructure:
> >        +------------------------------+---------+---------+
> >        | DIT                          | [51-48] |    y    |
> >        +------------------------------+---------+---------+
> > +     | AMU                          | [47-44] |    n    |
> > +     +------------------------------+---------+---------+
> 
> As mentioned above, please drop it.
> 
> 
> Suzuki
