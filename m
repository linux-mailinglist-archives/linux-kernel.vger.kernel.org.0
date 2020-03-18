Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76E8C189C78
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 14:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgCRNCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 09:02:04 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:55695 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726783AbgCRNCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 09:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584536523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=umU8Z9JoL7Qhg365QcEJh2Mxe4az67bMGgKE4dWEnUw=;
        b=BT3oKviFAm3rBgfuaPdmNwRweOOEUEMqPm9oRfFALe+msvhVpdKNaOfBHkfrCVJ/TuyVfE
        P8Ecq1CIh77ay9Sox89tFMtl7y9vZZr708Cs2ZrD24M+MMuRds3kU/vVKCcRnSAAuNRY9r
        +kedfmtS65biGsxI8hYMCX/4OmIpZtQ=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-OzuMxVfLP6yHqk_bbETHIA-1; Wed, 18 Mar 2020 09:02:01 -0400
X-MC-Unique: OzuMxVfLP6yHqk_bbETHIA-1
Received: by mail-io1-f69.google.com with SMTP id q22so8587488ioj.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 06:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=umU8Z9JoL7Qhg365QcEJh2Mxe4az67bMGgKE4dWEnUw=;
        b=lzpADKT30vL+tBNVSkMlBq9bXUKT+DKM1PA9GHSFxsKAYU3QvspV8rCCVAN7AXXUA8
         r2biWnKqaD7wFtynfRaedH+45sWFvmE9HlxKG1PP0cZHeOawIZ49SKe2AdHZ39w0KB9G
         o23lZvF9lkJsXwNG1z/DnJ/wKJO7NSzK5PIUIaRkVHDFMHb8yQTWh8fJjgBjWuN8mQ0q
         Q5io7YIZ6qwkx0rakohz2ELIdinboB7iCJLtT0F+7gSLHemxUB3XBZGHdOHrRinZsXe7
         V2Zn3T6vCoVpFhAMTUSQyfkQBXy+q8OE5sk3pUC+5634un1vi6rL25VdXQQui6Z8CeZQ
         xEmg==
X-Gm-Message-State: ANhLgQ3+ZIqaOTNINvU0IGaXk/8Pukxd9iVo27aHig5Vw/17opAnl69v
        Gsy10Dmz0HSmfK3Ok1hbbSNE2CZ4z1ainYY3NxoNzXM798amTBAUjmAC0cr7YGZY2wZ3sHhHMZ9
        ba1JnBA+teEnzkgEsMD6BC0m0cC8N0WE085Qev215
X-Received: by 2002:a02:2302:: with SMTP id u2mr2616697jau.67.1584536520896;
        Wed, 18 Mar 2020 06:02:00 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vue0J337X7n3fMgGPXHgf7ihPUf0i9k0D3EkKwRboLLQkEbfoL5NML/4YXkkbv93kMa/Ws2N+WhXw/EJ/fj3co=
X-Received: by 2002:a02:2302:: with SMTP id u2mr2616605jau.67.1584536520187;
 Wed, 18 Mar 2020 06:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200303233609.713348-1-jarkko.sakkinen@linux.intel.com>
 <20200303233609.713348-22-jarkko.sakkinen@linux.intel.com>
 <CAOASepPi4byhQ21hngsSx8tosCC-xa=y6r4j=pWo2MZGeyhi4Q@mail.gmail.com>
 <20200315012523.GC208715@linux.intel.com> <CAOASepP9GeTEqs1DSfPiSm9ER0whj9qwSc46ZiNj_K4dMekOfQ@mail.gmail.com>
 <94ce05323c4de721c4a6347223885f2ad9f541af.camel@linux.intel.com>
 <CAOASepM1pp1emPwSdFcaRkZfFm6sNmwPCJH+iFMiaJpFjU0VxQ@mail.gmail.com>
 <5dc2ec4bc9433f9beae824759f411c32b45d4b74.camel@linux.intel.com>
 <20200316225322.GJ24267@linux.intel.com> <fa773504-4cc1-5cbd-c018-890f7a5d3152@intel.com>
 <20200316235934.GM24267@linux.intel.com> <ca2c9ac0-b717-ee96-c7df-4e39f03a9193@intel.com>
 <CAOASepN7n1XUGPQHwk2Vcu-dyyBJ7dwhM_mF_RcJa71PcNiLmA@mail.gmail.com> <a447fb5c-b3bd-ef82-ee5f-33be69796a27@intel.com>
In-Reply-To: <a447fb5c-b3bd-ef82-ee5f-33be69796a27@intel.com>
From:   Nathaniel McCallum <npmccallum@redhat.com>
Date:   Wed, 18 Mar 2020 09:01:49 -0400
Message-ID: <CAOASepPZ727dKLNaus2wGY3CLNE1SNi-5QyvS5OMxcCYbN5Rdw@mail.gmail.com>
Subject: Re: [PATCH v28 21/22] x86/vdso: Implement a vDSO for Intel SGX
 enclave call
To:     "Xing, Cedric" <cedric.xing@intel.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, Neil Horman <nhorman@redhat.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        "Svahn, Kai" <kai.svahn@intel.com>, bp@alien8.de,
        Josh Triplett <josh@joshtriplett.org>, luto@kernel.org,
        kai.huang@intel.com, David Rientjes <rientjes@google.com>,
        Patrick Uiterwijk <puiterwijk@redhat.com>,
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

On Tue, Mar 17, 2020 at 6:23 PM Xing, Cedric <cedric.xing@intel.com> wrote:
>
> On 3/17/2020 9:50 AM, Nathaniel McCallum wrote:
> > On Mon, Mar 16, 2020 at 8:18 PM Xing, Cedric <cedric.xing@intel.com> wrote:
> >>
> >> On 3/16/2020 4:59 PM, Sean Christopherson wrote:
> >>> On Mon, Mar 16, 2020 at 04:50:26PM -0700, Xing, Cedric wrote:
> >>>> On 3/16/2020 3:53 PM, Sean Christopherson wrote:
> >>>>> On Mon, Mar 16, 2020 at 11:38:24PM +0200, Jarkko Sakkinen wrote:
> >>>>>>> My suggestions explicitly maintained robustness, and in fact increased
> >>>>>>> it. If you think we've lost capability, please speak with specificity
> >>>>>>> rather than in vague generalities. Under my suggestions we can:
> >>>>>>> 1. call the vDSO from C
> >>>>>>> 2. pass context to the handler
> >>>>>>> 3. have additional stack manipulation options in the handler
> >>>>>>>
> >>>>>>> The cost for this is a net 2 additional instructions. No existing
> >>>>>>> capability is lost.
> >>>>>>
> >>>>>> My vague generality in this case is just that the whole design
> >>>>>> approach so far has been to minimize the amount of wrapping to
> >>>>>> EENTER.
> >>>>>
> >>>>> Yes and no.   If we wanted to minimize the amount of wrapping around the
> >>>>> vDSO's ENCLU then we wouldn't have the exit handler shenanigans in the
> >>>>> first place.  The whole process has been about balancing the wants of each
> >>>>> use case against the overall quality of the API and code.
> >>>>>
> >>>> The design of this vDSO API was NOT to minimize wrapping, but to allow
> >>>> maximal flexibility. More specifically, we strove not to restrict how info
> >>>> was exchanged between the enclave and its host process. After all, calling
> >>>> convention is compiler specific - i.e. the enclave could be built by a
> >>>> different compiler (e.g. MSVC) that doesn't share the same list of CSRs as
> >>>> the host process. Therefore, the API has been implemented to pass through
> >>>> virtually all registers except those used by EENTER itself. Similarly, all
> >>>> registers are passed back from enclave to the caller (or the exit handler)
> >>>> except those used by EEXIT. %rbp is an exception because the vDSO API has to
> >>>> anchor the stack, using either %rsp or %rbp. We picked %rbp to allow the
> >>>> enclave to allocate space on the stack.
> >>>
> >>> And unless I'm missing something, using %rcx to pass @leaf would still
> >>> satisfy the above, correct?  Ditto for saving/restoring %rbx.
> >>>
> >>> I.e. a runtime that's designed to work with enclave's using a different
> >>> calling convention wouldn't be able to take advantage of being able to call
> >>> the vDSO from C, but neither would it take on any meaningful burden.
> >>>
> >> Not exactly.
> >>
> >> If called directly from C code, the caller would expect CSRs to be
> >> preserved.
> >
> > Correct. This requires collaboration between the caller of the vDSO
> > and the enclave.
> >
> >> Then who should preserve CSRs?
> >
> > The enclave.
> >
> >> It can't be the enclave
> >> because it may not follow the same calling convention.
> >
> > This is incorrect. You are presuming there is not tight integration
> > between the caller of the vDSO and the enclave. In my case, the
> > integration is total and complete. We have working code today that
> > does this.
> >
> >> Moreover, the
> >> enclave may run into an exception, in which case it doesn't have the
> >> ability to restore CSRs.
> >
> > There are two solutions to this:
> > 1. Write the handler in assembly and don't return to C on AEX.
> > 2. The caller can simply preserve the registers. Nothing stops that.
> >
> > We have implemented #1.
> >
> What if the enclave cannot proceed due to an unhandled exception so the
> execution has to get back to the C caller of the vDSO API?

mov $60, %rax
mov $1, %rdi
syscall

We exit in all such cases.

> It seems to me the caller has to preserve CSRs by itself, otherwise it
> cannot continue execution after any enclave exception. Passing @leaf in
> %ecx will allow saving/restoring CSRs in C by setjmp()/longjmp(), with
> the help of an exit handler. But if the C caller has already preserved
> CSRs, why preserve CSRs again inside the enclave? It looks to me things
> can be simplified only if the host process handles no enclave exceptions
> (or exceptions inside the enclave will crash the calling thread). Thus
> the only case of enclave EEXIT'ing back to its caller is considered
> valid, hence the enclave will always be able to restore CSRs, so that
> neither vDSO nor its caller has to preserve CSRs.
>
> Is my understanding correct?
>

