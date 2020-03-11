Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC11D1821EA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 20:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbgCKTPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 15:15:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32404 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731073AbgCKTP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583954125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U/dBWPUaXKVKZnAALqgxpLqGOHry24QFAEUYGdHVgj4=;
        b=O4hK4bog+J8sAvUBYfO3rFaIouK4XbS58g9iD21+yJTxbIcA1bPtsXgLQLbQqz0jfOCJso
        n9ZGL9H8IJ0y78TQ4vulINpOA4mekwRZb7nEk02qNq4jxdSfrcy1ZCblPHI98Syn/kY8tP
        Dgw+clKAk0nU3BYaKF+nD+aqbNcjzDw=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-1mn5MKdZMB-0DXmxHgXrOw-1; Wed, 11 Mar 2020 15:15:24 -0400
X-MC-Unique: 1mn5MKdZMB-0DXmxHgXrOw-1
Received: by mail-il1-f198.google.com with SMTP id h18so2136320ilc.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 12:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U/dBWPUaXKVKZnAALqgxpLqGOHry24QFAEUYGdHVgj4=;
        b=iR4z/UrxICKiyLcs4kHnrF/gGrnJyLh0Qu+4qNbDtNauhgSYV0nVHKleyP7CBpBkNo
         UFAJhG1EirC+CAp9pf6YAh004F/7mF60fq97S9ccs37zA4ltvQGEwyr6IqJDbFysQ/rh
         +ah+NYRjT5kuJ1dwt+OeEwm+tRyDy27eyYh2qtdvO9Cxw8h+1eQRgpXAbEbVfSSEQa/r
         tCd/YU38M3AobOO200UeWtK6IPfELkWzWjDqzCpIH2n/ibal3hmZ9KzvGY4KYmU3bre3
         wJL6Ks+VwBmy0et1G1ifNGOaSskFFxTdXR2ciehag7N2ZBx0Py4t6auD2+q9DDl7i0li
         SEPg==
X-Gm-Message-State: ANhLgQ17hA0+BH55fWLYUsaF1GKc81wO4k+w45lQYsOF+twQbjXJj5Zd
        OOC6/3SvuOugQ7GKNRW/rBoavXz1eaylUFd8VzXRGu6kGBWs3ZCBZMLg345fycUNFSGmz1SedCx
        0u6fKKELyJiXaUG32vZ+STFasDs6lnvFIKF5ffWD4
X-Received: by 2002:a92:41c7:: with SMTP id o190mr4472781ila.11.1583954123482;
        Wed, 11 Mar 2020 12:15:23 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtrg4vw2nbROqMnV56kkdiwwieVZJCxwcKBXSf6SmnF8s3EPN8Wm9/ioifHWVqAEtKABP91TxQwb4+86NXBvHY=
X-Received: by 2002:a92:41c7:: with SMTP id o190mr4472742ila.11.1583954122966;
 Wed, 11 Mar 2020 12:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200303233609.713348-1-jarkko.sakkinen@linux.intel.com>
 <20200303233609.713348-22-jarkko.sakkinen@linux.intel.com>
 <CAOASepPi4byhQ21hngsSx8tosCC-xa=y6r4j=pWo2MZGeyhi4Q@mail.gmail.com> <254f1e35-4302-e55f-c00d-0f91d9503498@fortanix.com>
In-Reply-To: <254f1e35-4302-e55f-c00d-0f91d9503498@fortanix.com>
From:   Nathaniel McCallum <npmccallum@redhat.com>
Date:   Wed, 11 Mar 2020 15:15:12 -0400
Message-ID: <CAOASepP=ayHUH=msoei+MfFpLosVJQ5C0dmquu7mv+6WQ2bLqQ@mail.gmail.com>
Subject: Re: [PATCH v28 21/22] x86/vdso: Implement a vDSO for Intel SGX
 enclave call
To:     Jethro Beekman <jethro@fortanix.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Neil Horman <nhorman@redhat.com>,
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

On Wed, Mar 11, 2020 at 1:38 PM Jethro Beekman <jethro@fortanix.com> wrote:
>
> On 2020-03-11 18:30, Nathaniel McCallum wrote:
> > On Tue, Mar 3, 2020 at 6:40 PM Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com> wrote:
> >>
> >> From: Sean Christopherson <sean.j.christopherson@intel.com>
> >>
> >> An SGX runtime must be aware of the exceptions, which happen inside an
> >> enclave. Introduce a vDSO call that wraps EENTER/ERESUME cycle and returns
> >> the CPU exception back to the caller exactly when it happens.
> >>
> >> Kernel fixups the exception information to RDI, RSI and RDX. The SGX call
> >> vDSO handler fills this information to the user provided buffer or
> >> alternatively trigger user provided callback at the time of the exception.
> >>
> >> The calling convention is custom and does not follow System V x86-64 ABI.
> >>
> >> Suggested-by: Andy Lutomirski <luto@amacapital.net>
> >> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> >> Co-developed-by: Cedric Xing <cedric.xing@intel.com>
> >> Signed-off-by: Cedric Xing <cedric.xing@intel.com>
> >> Tested-by: Jethro Beekman <jethro@fortanix.com>
> >> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> >> ---
> >>  arch/x86/entry/vdso/Makefile             |   2 +
> >>  arch/x86/entry/vdso/vdso.lds.S           |   1 +
> >>  arch/x86/entry/vdso/vsgx_enter_enclave.S | 187 +++++++++++++++++++++++
> >>  arch/x86/include/uapi/asm/sgx.h          |  37 +++++
> >>  4 files changed, 227 insertions(+)
> >>  create mode 100644 arch/x86/entry/vdso/vsgx_enter_enclave.S
> >>
> >> diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
> >> index 657e01d34d02..fa50c76a17a8 100644
> >> --- a/arch/x86/entry/vdso/Makefile
> >> +++ b/arch/x86/entry/vdso/Makefile
> >> @@ -24,6 +24,7 @@ VDSO32-$(CONFIG_IA32_EMULATION)       := y
> >>
> >>  # files to link into the vdso
> >>  vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o
> >> +vobjs-$(VDSO64-y)              += vsgx_enter_enclave.o
> >>
> >>  # files to link into kernel
> >>  obj-y                          += vma.o extable.o
> >> @@ -90,6 +91,7 @@ $(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS
> >>  CFLAGS_REMOVE_vclock_gettime.o = -pg
> >>  CFLAGS_REMOVE_vdso32/vclock_gettime.o = -pg
> >>  CFLAGS_REMOVE_vgetcpu.o = -pg
> >> +CFLAGS_REMOVE_vsgx_enter_enclave.o = -pg
> >>
> >>  #
> >>  # X32 processes use x32 vDSO to access 64bit kernel data.
> >> diff --git a/arch/x86/entry/vdso/vdso.lds.S b/arch/x86/entry/vdso/vdso.lds.S
> >> index 36b644e16272..4bf48462fca7 100644
> >> --- a/arch/x86/entry/vdso/vdso.lds.S
> >> +++ b/arch/x86/entry/vdso/vdso.lds.S
> >> @@ -27,6 +27,7 @@ VERSION {
> >>                 __vdso_time;
> >>                 clock_getres;
> >>                 __vdso_clock_getres;
> >> +               __vdso_sgx_enter_enclave;
> >>         local: *;
> >>         };
> >>  }
> >> diff --git a/arch/x86/entry/vdso/vsgx_enter_enclave.S b/arch/x86/entry/vdso/vsgx_enter_enclave.S
> >> new file mode 100644
> >> index 000000000000..94a8e5f99961
> >> --- /dev/null
> >> +++ b/arch/x86/entry/vdso/vsgx_enter_enclave.S
> >> @@ -0,0 +1,187 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +
> >> +#include <linux/linkage.h>
> >> +#include <asm/export.h>
> >> +#include <asm/errno.h>
> >> +
> >> +#include "extable.h"
> >> +
> >> +#define EX_LEAF                0*8
> >> +#define EX_TRAPNR      0*8+4
> >> +#define EX_ERROR_CODE  0*8+6
> >> +#define EX_ADDRESS     1*8
> >> +
> >> +.code64
> >> +.section .text, "ax"
> >> +
> >> +/**
> >> + * __vdso_sgx_enter_enclave() - Enter an SGX enclave
> >> + * @leaf:      ENCLU leaf, must be EENTER or ERESUME
> >> + * @tcs:       TCS, must be non-NULL
> >> + * @e:         Optional struct sgx_enclave_exception instance
> >> + * @handler:   Optional enclave exit handler
> >> + *
> >> + * **Important!**  __vdso_sgx_enter_enclave() is **NOT** compliant with the
> >> + * x86-64 ABI, i.e. cannot be called from standard C code.
> >> + *
> >> + * Input ABI:
> >> + *  @leaf      %eax
> >> + *  @tcs       8(%rsp)
> >> + *  @e                 0x10(%rsp)
> >> + *  @handler   0x18(%rsp)
> >> + *
> >> + * Output ABI:
> >> + *  @ret       %eax
> >> + *
> >> + * All general purpose registers except RAX, RBX and RCX are passed as-is to
> >> + * the enclave. RAX, RBX and RCX are consumed by EENTER and ERESUME and are
> >> + * loaded with @leaf, asynchronous exit pointer, and @tcs respectively.
> >> + *
> >> + * RBP and the stack are used to anchor __vdso_sgx_enter_enclave() to the
> >> + * pre-enclave state, e.g. to retrieve @e and @handler after an enclave exit.
> >> + * All other registers are available for use by the enclave and its runtime,
> >> + * e.g. an enclave can push additional data onto the stack (and modify RSP) to
> >> + * pass information to the optional exit handler (see below).
> >> + *
> >> + * Most exceptions reported on ENCLU, including those that occur within the
> >> + * enclave, are fixed up and reported synchronously instead of being delivered
> >> + * via a standard signal. Debug Exceptions (#DB) and Breakpoints (#BP) are
> >> + * never fixed up and are always delivered via standard signals. On synchrously
> >> + * reported exceptions, -EFAULT is returned and details about the exception are
> >> + * recorded in @e, the optional sgx_enclave_exception struct.
> >> +
> >> + * If an exit handler is provided, the handler will be invoked on synchronous
> >> + * exits from the enclave and for all synchronously reported exceptions. In
> >> + * latter case, @e is filled prior to invoking the handler.
> >> + *
> >> + * The exit handler's return value is interpreted as follows:
> >> + *  >0:                continue, restart __vdso_sgx_enter_enclave() with @ret as @leaf
> >> + *   0:                success, return @ret to the caller
> >> + *  <0:                error, return @ret to the caller
> >> + *
> >> + * The userspace exit handler is responsible for unwinding the stack, e.g. to
> >> + * pop @e, u_rsp and @tcs, prior to returning to __vdso_sgx_enter_enclave().
> >> + * The exit handler may also transfer control, e.g. via longjmp() or a C++
> >> + * exception, without returning to __vdso_sgx_enter_enclave().
> >> + *
> >> + * Return:
> >> + *  0 on success,
> >> + *  -EINVAL if ENCLU leaf is not allowed,
> >> + *  -EFAULT if an exception occurs on ENCLU or within the enclave
> >> + *  -errno for all other negative values returned by the userspace exit handler
> >> + */
> >> +#ifdef SGX_KERNEL_DOC
> >> +/* C-style function prototype to coerce kernel-doc into parsing the comment. */
> >> +int __vdso_sgx_enter_enclave(int leaf, void *tcs,
> >> +                            struct sgx_enclave_exception *e,
> >> +                            sgx_enclave_exit_handler_t handler);
> >> +#endif
> >> +SYM_FUNC_START(__vdso_sgx_enter_enclave)
> >
> > Currently, the selftest has a wrapper around
> > __vdso_sgx_enter_enclave() which preserves all x86-64 ABI callee-saved
> > registers (CSRs), though it uses none of them. Then it calls this
> > function which uses %rbx but preserves none of the CSRs. Then it jumps
> > into an enclave which zeroes all these registers before returning.
> > Thus:
> >
> >   1. wrapper saves all CSRs
> >   2. wrapper repositions stack arguments
> >   3. __vdso_sgx_enter_enclave() modifies, but does not save %rbx
> >   4. selftest zeros all CSRs
> >   5. wrapper loads all CSRs
> >
> > I'd like to propose instead that the enclave be responsible for saving
> > and restoring CSRs. So instead of the above we have:
> >   1. __vdso_sgx_enter_enclave() saves %rbx
> >   2. enclave saves CSRs
> >   3. enclave loads CSRs
> >   4. __vdso_sgx_enter_enclave() loads %rbx
> >
> > I know that lots of other stuff happens during enclave transitions,
> > but at the very least we could reduce the number of instructions
> > through this critical path.
>
> The current calling convention for __vdso_sgx_enter_enclave has been carefully designed to mimic just calling ENCLU[EENTER] as closely as possible.

That seems like a reasonable contract. Thanks!

