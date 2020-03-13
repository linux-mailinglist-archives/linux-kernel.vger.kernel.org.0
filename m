Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9F29184FF9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 21:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCMUOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 16:14:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22274 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726591AbgCMUOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 16:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584130455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ra9NN4yow2WFvpKnbzrLfWOehuuyIIFKeOs27fVV+6g=;
        b=EiKxxhEskncKy7lJCDMygCZa7V7Ckhxs6NfDorHcu9/2wm+KoP/6b438P9jhJNda41ENLu
        GUkA0ezmHe7dbgUQNjkobSbpDYZ6hYQ0DE9D1RwbmGy3sVPfD5+VHXaOQFCum33APbMK9X
        D+IxZY1y8RZKAJCwg2NbPllHiwiQTqU=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-fNcnut7UOU6LE4ZKJeK5Xw-1; Fri, 13 Mar 2020 16:14:13 -0400
X-MC-Unique: fNcnut7UOU6LE4ZKJeK5Xw-1
Received: by mail-il1-f199.google.com with SMTP id f19so7721774ill.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 13:14:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ra9NN4yow2WFvpKnbzrLfWOehuuyIIFKeOs27fVV+6g=;
        b=OidyRWfBRBLgLcV/oxJyAmkbU1dXXzopnJI1FdGjF+0FP11Dd0WZY32t6v44e3B7on
         z2lC0FnHf+6C7hcu1Cx/NXLq2azDGEVb+PDhjLmT3FMEHi+sW5rGY2qGzs/qK3JTWW68
         qnmy/Oi6WuubL1yvzndQWCzoB5yprqRzzVFrNK7zcJdqZd3ZP7NvvevfMFwlX/rXaWLI
         H+y6wxF4kNxYNoprFMI2DYquR31hzCJMwi2HeXpDwo8WVyRxxToSNes2K+BOEmpJXlXy
         6AlpLHAFyAH089TOsFrkK8afq3WUDicaufO0XUPrd5PAmTVldpfjH04VCnMa4awvAbLv
         Mb7A==
X-Gm-Message-State: ANhLgQ31s81RoVIcXpX4p1GKUyoxbwCH6ywy9DwmLsoLoHEomulPViH4
        5VVlEVHR4tqRdg3PYcBq42ZlxQGzL/ZgIYMC9L+lW2LpbNcGd+h5UqGCHWtuMHNIwBq2turFJ/o
        qBjibtPxtkHM+a9SHt4dbTNccY30nDVRrljM2Izp7
X-Received: by 2002:a92:2542:: with SMTP id l63mr16094116ill.301.1584130452499;
        Fri, 13 Mar 2020 13:14:12 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt5EUEXswbzUU6qurbhPqIsAO6O1Xomu4Em3C3rvP6XALZCXUtBOcvubpedKa7cd5XBerXmTYuHK6wY8vpqZ3M=
X-Received: by 2002:a92:2542:: with SMTP id l63mr16094079ill.301.1584130452112;
 Fri, 13 Mar 2020 13:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200303233609.713348-1-jarkko.sakkinen@linux.intel.com>
 <20200303233609.713348-22-jarkko.sakkinen@linux.intel.com>
 <CAOASepPi4byhQ21hngsSx8tosCC-xa=y6r4j=pWo2MZGeyhi4Q@mail.gmail.com>
 <254f1e35-4302-e55f-c00d-0f91d9503498@fortanix.com> <CAOASepOm8-2UCdEnVMopEprMGWjkYUbUTX++dHaqCafi2ju8mA@mail.gmail.com>
 <20200313164622.GC5181@linux.intel.com> <CAOASepN1hxSgxVJAJiAbSmuCTCHd=95Mnvh6BKNSPJs=EpAmbQ@mail.gmail.com>
 <20200313184452.GD5181@linux.intel.com>
In-Reply-To: <20200313184452.GD5181@linux.intel.com>
From:   Nathaniel McCallum <npmccallum@redhat.com>
Date:   Fri, 13 Mar 2020 16:14:01 -0400
Message-ID: <CAOASepP_oGOenjCvAvLg+e+=fz4H0X=cyD+v5ywD0peeXEEmYg@mail.gmail.com>
Subject: Re: [PATCH v28 21/22] x86/vdso: Implement a vDSO for Intel SGX
 enclave call
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Jethro Beekman <jethro@fortanix.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
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
        Connor Kuehl <ckuehl@redhat.com>,
        Harald Hoyer <harald@redhat.com>,
        Lily Sturmann <lsturman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 2:45 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Fri, Mar 13, 2020 at 02:32:29PM -0400, Nathaniel McCallum wrote:
> > On Fri, Mar 13, 2020 at 12:46 PM Sean Christopherson
> > <sean.j.christopherson@intel.com> wrote:
> > >
> > > On Fri, Mar 13, 2020 at 11:48:54AM -0400, Nathaniel McCallum wrote:
> > > > Therefore, I'd like to propose that __vdso_sgx_enter_enclave():
> > > >   * Preserve %rbx.
> > >
> > > At first glance, that looks sane.  Being able to call __vdso... from C
> > > would certainly be nice.
> >
> > Agreed. I think ergonomically we want __vdso...() to be called from C
> > and the handler to be implemented in asm (optionally); without
> > breaking the ability to call __vdso..() from asm in special cases.
> >
> > I think all ergonomic issues get solved by the following:
> >    * Pass a void * into the handler from C through __vdso...().
> >    * Allow the handler to pop parameters off of the output stack without hacks.
> >
> > This allows the handler to pop extra arguments off the stack and write
> > them into the memory at the void *. Then the handler can be very small
> > and pass logic back to the caller of __vdso...().
> >
> > Here's what this all means for the enclave. For maximum usability, the
> > enclave should preserve all callee-saved registers (except %rbx, which
> > is preserved by __vdso..()). For each ABI rule that the enclave
> > breaks, you need logic in a handler to fix it. So if you push return
> > params on the stack, the handler needs to undo that.
>
> Or the untrusted runtime needs to wrap the __vdso() to save state that is
> clobbered by the enclave.  Just want to make it crystal clear that using a
> handler is only required for stack shenanigans.

Yup.

> > This doesn't compromise the ability to treat __vsdo...() like ENCLU if
> > you need the full power. But it does make it significantly easier to
> > consume when you don't have special needs. So as I see it, __vdso...()
> > should:
> >
> > 1. preserve %rbx
> > 2. take leaf in %rcx
> > 3. gain a void* stack param which is passed to the handler
>
> Unless I'm misunderstanding the request, this already exists.  %rsp at the
> time of EEXIT is passed to the handler.

Sorry, different stack parameter. I mean this:

typedef int (*sgx_enclave_exit_handler_t)(
    long rdi,
    long rsi,
    long rdx,
    long ursp,
    long r8,
    long r9,
    int ret,
    void *tcs,
    struct sgx_enclave_exception *e,
    void *misc
);

int __vdso_sgx_enter_enclave(
    long rdi,
    long rsi,
    long rdx,
    int leaf,
    long r8,
    long r9,
    void *tcs,
    struct sgx_enclave_exception *e,
    void *misc,
    sgx_enclave_exit_handler_t handler
);

This is so that the caller of __vdso...() can pass context into the
handler. Note that I've also reordered the stack parameters so that
the stack order can be reused.

> > 4. sub/add to %rsp rather than save/restore
>
> Can you elaborate on why you want to sub/add to %rsp instead of having the
> enclave unwind the stack?  Preserving %rsp across EEXIT/ERESUME seems more
> in line with function call semantics, which I assume is desirable?  E.g.
>
>   push param3
>   push param2
>   push param1
>
>   enclu[EEXIT]
>
>   add $0x18, %rsp

Before enclave EEXIT, the enclave restores %rsp to the value it had
before EENTER was called. Then it pushes additional output arguments
onto the stack. The enclave calls EENCLU[EEXIT].

We are now in __vdso...() on the way back to the caller. However, %rsp
has a different value than we entered the function with. This breaks
x86_64 ABI, obviously. The handler needs to fix this up: how does it
do so?

In the current code, __vdso..() saves the value of %rsp, calls the
handler and then restores %rsp. The handler can fix up the stack by
setting the correct value to %rbx and returning without restoring it.
But this requires internal knowledge of the __vdso...() function,
which could theoretically change in the future.

If instead the __vdso...() only did add/sub, then the handler could do:
1. pop return address
2. pop handler stack params
3. pop enclave additional output stack params
4. push handler stack params
5. push return address

While this is more work, it is standard calling convention work that
doesn't require internal knowledge of __vdso..(). Alternatively, if we
don't like the extra work, we can document the %rbx hack explicitly
into the handler documentation and make it part of the interface. But
we need some explicit way for the handler to pop enclave output stack
params that doesn't depend on internal knowledge of the __vdso...()
invariants.

> > That would make this a very usable and fast interface without
> > sacrificing any of its current power.
>

