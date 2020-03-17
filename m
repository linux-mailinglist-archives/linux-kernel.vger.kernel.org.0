Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26D4E188A3E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 17:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgCQQ3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 12:29:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:26678 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726016AbgCQQ3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584462554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cesc6+PAoo0uOh9jUHSiNLjLdnEyU/La4E7O0BZjTS4=;
        b=V6DmMXKnR+jhvacimh1OawBti7Jxgtkp/heyxV86pi/vo/XwAzK9xCuHG5LooD1n73ETnD
        VArcc7hDTVqnSODS3jHp7Ksz61xuKFNnN9XlaCFktTn3rik05sOSkKB+2neIHKEFo2Trnl
        GPCBMaRJEmCHAO8J20H7BDLAD23h0vM=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-ph2AUW_JN4-CzoYQG2Ai0g-1; Tue, 17 Mar 2020 12:29:13 -0400
X-MC-Unique: ph2AUW_JN4-CzoYQG2Ai0g-1
Received: by mail-io1-f72.google.com with SMTP id q22so6211065ioj.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 09:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cesc6+PAoo0uOh9jUHSiNLjLdnEyU/La4E7O0BZjTS4=;
        b=YpQbi1fYC8ERLy3M6iGbgLVqsJPXSOInaMCf+mXmxV7P8OqBwUipsZDs6bQmDGTr9D
         FJLykuWqP9vNo2bt3DbOKl2ULs70JOzdJQ3xGFZQ6TZ9AcntpS1QdcM10vrAJ+wAdAsg
         3UU/KB/kTV+ASyiqeg6FCjb/hdqUcD8lYnQoe/rzUGDkVgar0o/QxhxLfOEI8KIbIjtm
         NxFCeXLtiDfK2w04CPt+nY6+86mQ+tIMK1A3sGKWCmYFEquKCqZgEQ1QyfcKrTtBFCMY
         Aq1jCJXnrgfeZ/2gF2bOYtzg9u7am/+6uQTxn+JVSrqd/zZgd/ZuEw/CeYQvJUM2GQpb
         XBzQ==
X-Gm-Message-State: ANhLgQ0DGmNpu13Rpi4RI/S1l6vKC2NyQtIotw6NV3e30AAHnCum6huQ
        mpM4F4O1M0o5hqj31zdw2XpuelhPJl+YhV48OmS+6a8PnbR48SOySDeeMyBRvzyCWVCse7XplJw
        rSb3R6vXy0Fbbyb+3ut86ofUENwaN/Pb705gQfCZQ
X-Received: by 2002:a05:6602:2434:: with SMTP id g20mr4550522iob.97.1584462550257;
        Tue, 17 Mar 2020 09:29:10 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtjCSQ2lftFJ7EV4bG+5w/GyTA3TbeduLtFqWgxZnR0k8L1ugrfDp90ieq7fWwElhXk2LCyoJxo0AKmX+JtRa0=
X-Received: by 2002:a05:6602:2434:: with SMTP id g20mr4550458iob.97.1584462549594;
 Tue, 17 Mar 2020 09:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200303233609.713348-1-jarkko.sakkinen@linux.intel.com>
 <20200303233609.713348-22-jarkko.sakkinen@linux.intel.com>
 <CAOASepPi4byhQ21hngsSx8tosCC-xa=y6r4j=pWo2MZGeyhi4Q@mail.gmail.com>
 <20200315012523.GC208715@linux.intel.com> <CAOASepP9GeTEqs1DSfPiSm9ER0whj9qwSc46ZiNj_K4dMekOfQ@mail.gmail.com>
 <94ce05323c4de721c4a6347223885f2ad9f541af.camel@linux.intel.com>
 <CAOASepM1pp1emPwSdFcaRkZfFm6sNmwPCJH+iFMiaJpFjU0VxQ@mail.gmail.com>
 <5dc2ec4bc9433f9beae824759f411c32b45d4b74.camel@linux.intel.com> <20200316225322.GJ24267@linux.intel.com>
In-Reply-To: <20200316225322.GJ24267@linux.intel.com>
From:   Nathaniel McCallum <npmccallum@redhat.com>
Date:   Tue, 17 Mar 2020 12:28:58 -0400
Message-ID: <CAOASepNbvproKLFLUvH=+m1xXFeDCWup6O7Pi1py6ENFdarMKg@mail.gmail.com>
Subject: Re: [PATCH v28 21/22] x86/vdso: Implement a vDSO for Intel SGX
 enclave call
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, Neil Horman <nhorman@redhat.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        "Svahn, Kai" <kai.svahn@intel.com>, bp@alien8.de,
        Josh Triplett <josh@joshtriplett.org>, luto@kernel.org,
        kai.huang@intel.com, David Rientjes <rientjes@google.com>,
        cedric.xing@intel.com, Patrick Uiterwijk <puiterwijk@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jethro Beekman <jethro@fortanix.com>,
        Connor Kuehl <ckuehl@redhat.com>,
        Harald Hoyer <harald@redhat.com>,
        Lily Sturmann <lsturman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 6:53 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Mon, Mar 16, 2020 at 11:38:24PM +0200, Jarkko Sakkinen wrote:
> > On Mon, 2020-03-16 at 10:01 -0400, Nathaniel McCallum wrote:
> > > On Mon, Mar 16, 2020 at 9:56 AM Jarkko Sakkinen
> > > <jarkko.sakkinen@linux.intel.com> wrote:
> > > > On Sun, 2020-03-15 at 13:53 -0400, Nathaniel McCallum wrote:
> > > > > On Sat, Mar 14, 2020 at 9:25 PM Jarkko Sakkinen
> > > > > <jarkko.sakkinen@linux.intel.com> wrote:
> > > > > > On Wed, Mar 11, 2020 at 01:30:07PM -0400, Nathaniel McCallum wrote:
> > > > > > > Currently, the selftest has a wrapper around
> > > > > > > __vdso_sgx_enter_enclave() which preserves all x86-64 ABI callee-saved
> > > > > > > registers (CSRs), though it uses none of them. Then it calls this
> > > > > > > function which uses %rbx but preserves none of the CSRs. Then it jumps
> > > > > > > into an enclave which zeroes all these registers before returning.
> > > > > > > Thus:
> > > > > > >
> > > > > > >   1. wrapper saves all CSRs
> > > > > > >   2. wrapper repositions stack arguments
> > > > > > >   3. __vdso_sgx_enter_enclave() modifies, but does not save %rbx
> > > > > > >   4. selftest zeros all CSRs
> > > > > > >   5. wrapper loads all CSRs
> > > > > > >
> > > > > > > I'd like to propose instead that the enclave be responsible for saving
> > > > > > > and restoring CSRs. So instead of the above we have:
> > > > > > >   1. __vdso_sgx_enter_enclave() saves %rbx
> > > > > > >   2. enclave saves CSRs
> > > > > > >   3. enclave loads CSRs
> > > > > > >   4. __vdso_sgx_enter_enclave() loads %rbx
> > > > > > >
> > > > > > > I know that lots of other stuff happens during enclave transitions,
> > > > > > > but at the very least we could reduce the number of instructions
> > > > > > > through this critical path.
> > > > > >
> > > > > > What Jethro said and also that it is a good general principle to cut
> > > > > > down the semantics of any vdso as minimal as possible.
> > > > > >
> > > > > > I.e. even if saving RBX would make somehow sense it *can* be left
> > > > > > out without loss in terms of what can be done with the vDSO.
> > > > >
> > > > > Please read the rest of the thread. Sean and I have hammered out some
> > > > > sensible and effective changes.
> > > >
> > > > Have skimmed through that discussion but it comes down how much you get
> > > > by obviously degrading some of the robustness. Complexity of the calling
> > > > pattern is not something that should be emphasized as that is something
> > > > that is anyway hidden inside the runtime.
> > >
> > > My suggestions explicitly maintained robustness, and in fact increased
> > > it. If you think we've lost capability, please speak with specificity
> > > rather than in vague generalities. Under my suggestions we can:
> > > 1. call the vDSO from C
> > > 2. pass context to the handler
> > > 3. have additional stack manipulation options in the handler
> > >
> > > The cost for this is a net 2 additional instructions. No existing
> > > capability is lost.
> >
> > My vague generality in this case is just that the whole design
> > approach so far has been to minimize the amount of wrapping to
> > EENTER.
>
> Yes and no.   If we wanted to minimize the amount of wrapping around the
> vDSO's ENCLU then we wouldn't have the exit handler shenanigans in the
> first place.  The whole process has been about balancing the wants of each
> use case against the overall quality of the API and code.
>
> > And since this has been kind of agreed by most of the
> > stakeholders doing something against the chosen strategy is
> > something I do hold some resistance.
>
> Up until Nathaniel joined the party, the only stakeholder in terms of the
> exit handler was the Intel SDK.

I would hope that having additional stakeholders would ease the path
to adoption.

> There was a general consensus to pass
> registers as-is when there isn't a strong reason to do otherwise.  Note
> that Nathaniel has also expressed approval of that approach.

I still approve that approach.

> So I think the question that needs to be answered is whether the benefits
> of using %rcx instead of %rax to pass @leaf justify the "pass registers
> as-is" guideline.  We've effectively already given this waiver for %rbx,
> as the whole reason why the TCS is passed in on the stack instead of via
> %rbx is so that it can be passed to the exit handler.  E.g. the vDSO
> could take the TCS in %rbx and save it on the stack, but we're throwing
> the baby out with the bathwater at that point.
>
> The major benefits being that the vDSO would be callable from C and that
> the kernel could define a legitimate prototype instead of a frankenstein
> prototype that's half assembly and half C.  For me, those are significant
> benefits and well worth the extra MOV, PUSH and POP.  For some use cases
> it would eliminate the need for an assembly wrapper.  For runtimes that
> need an assembly wrapper for whatever reason, it's probably still a win as
> a well designed runtime can avoid register shuffling in the wrapper.  And
> if there is a runtime that isn't covered by the above, it's at worst an
> extra MOV.
>

