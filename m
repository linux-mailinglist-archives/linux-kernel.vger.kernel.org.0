Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC465182252
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 20:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbgCKTa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 15:30:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45305 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731003AbgCKTa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583955058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4MsnGKBoKbUHjxKFCV9MFRXrnFbkyAN1oNyLornIrgI=;
        b=GLj3WnawHchQVqZbSpOl4JdUxJ1O4QaVbctauUGV8zKCYgmVk3NJTCvYRmNXbOXBszRBzU
        Vy5R1Vszaa2ccyJ/qq+JGv3xNryxNPt82UL5yoElyZ6GQsLI7IU4485lRDtHdaR21grh5h
        m5J8Y1jIYesA8QVkbuWNqKeliK/DrhQ=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-q6Xvp9iSPcSS6EeNIli0OA-1; Wed, 11 Mar 2020 15:30:56 -0400
X-MC-Unique: q6Xvp9iSPcSS6EeNIli0OA-1
Received: by mail-io1-f69.google.com with SMTP id k5so2205724ioa.22
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 12:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4MsnGKBoKbUHjxKFCV9MFRXrnFbkyAN1oNyLornIrgI=;
        b=t2mkDXFpKojD1yKL/X7/WXIN9m2CTEnIXSx/l5tLyJWccNmABv5+oNpZuvAlQSK+RA
         ZVDRNQD/ICuufm67/k4C0JWMuFrJYx8FN5ivSR2dPrDLC1NIO79A6haLaMyxn3ut/iFG
         UiBtSJyv9ADwvbPdxU8cMw1HtyixVTCM7s0o0P5PSLyCwfv4XRxQ9vcoA4oGClrRDnmy
         fChQ58dprcVCarns/7+Ph/ooqzpUGfX6pPmSGC3mP62R94/In9hMNS7ToNDCajie2Wqk
         sn0qEmklo5ZuFBAREEfrA9NeOuYm8+TiTN9o2etu9MmJMobyGBwmji+tDMQx1FAzQ/cl
         nGzw==
X-Gm-Message-State: ANhLgQ2kMw4v0O4PJZ08pnnEBxQ2os8lg7su9xLsd3xsH4J0LOwmEiBo
        3Gj4xx1iQi6jbsmWY04/W+LrzLiCGji/rTap/MzrCd/PyLhbol5SqcEDYZn4pv9eexSNc7t1zlR
        5J6PVvxoXEMRr7FvnqBbePr7x/dQInH8wg1pXAIKz
X-Received: by 2002:a92:3c1c:: with SMTP id j28mr4614083ila.304.1583955055636;
        Wed, 11 Mar 2020 12:30:55 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuSsj2tAxhrE+BKIj+y/8raYDOLnxF1p5GVPt5zhuZEpJrbolE+V94bDBtKzObKoHWUWU1GayL162N3iMX8xK4=
X-Received: by 2002:a92:3c1c:: with SMTP id j28mr4614049ila.304.1583955055221;
 Wed, 11 Mar 2020 12:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200303233609.713348-1-jarkko.sakkinen@linux.intel.com> <20200303233609.713348-22-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20200303233609.713348-22-jarkko.sakkinen@linux.intel.com>
From:   Nathaniel McCallum <npmccallum@redhat.com>
Date:   Wed, 11 Mar 2020 15:30:44 -0400
Message-ID: <CAOASepO2=KCzT+wdXWz2tUNvi6NyzNJ3KwvBMtH_P1TO8Yr_mQ@mail.gmail.com>
Subject: Re: [PATCH v28 21/22] x86/vdso: Implement a vDSO for Intel SGX
 enclave call
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
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
        Jethro Beekman <jethro@fortanix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 3, 2020 at 6:40 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> From: Sean Christopherson <sean.j.christopherson@intel.com>
>
> An SGX runtime must be aware of the exceptions, which happen inside an
> enclave. Introduce a vDSO call that wraps EENTER/ERESUME cycle and returns
> the CPU exception back to the caller exactly when it happens.
>
> Kernel fixups the exception information to RDI, RSI and RDX. The SGX call
> vDSO handler fills this information to the user provided buffer or
> alternatively trigger user provided callback at the time of the exception.
>
> The calling convention is custom and does not follow System V x86-64 ABI.
>
> Suggested-by: Andy Lutomirski <luto@amacapital.net>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Co-developed-by: Cedric Xing <cedric.xing@intel.com>
> Signed-off-by: Cedric Xing <cedric.xing@intel.com>
> Tested-by: Jethro Beekman <jethro@fortanix.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  arch/x86/entry/vdso/Makefile             |   2 +
>  arch/x86/entry/vdso/vdso.lds.S           |   1 +
>  arch/x86/entry/vdso/vsgx_enter_enclave.S | 187 +++++++++++++++++++++++
>  arch/x86/include/uapi/asm/sgx.h          |  37 +++++
>  4 files changed, 227 insertions(+)
>  create mode 100644 arch/x86/entry/vdso/vsgx_enter_enclave.S
>
> diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
> index 657e01d34d02..fa50c76a17a8 100644
> --- a/arch/x86/entry/vdso/Makefile
> +++ b/arch/x86/entry/vdso/Makefile
> @@ -24,6 +24,7 @@ VDSO32-$(CONFIG_IA32_EMULATION)       := y
>
>  # files to link into the vdso
>  vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o
> +vobjs-$(VDSO64-y)              += vsgx_enter_enclave.o
>
>  # files to link into kernel
>  obj-y                          += vma.o extable.o
> @@ -90,6 +91,7 @@ $(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS
>  CFLAGS_REMOVE_vclock_gettime.o = -pg
>  CFLAGS_REMOVE_vdso32/vclock_gettime.o = -pg
>  CFLAGS_REMOVE_vgetcpu.o = -pg
> +CFLAGS_REMOVE_vsgx_enter_enclave.o = -pg
>
>  #
>  # X32 processes use x32 vDSO to access 64bit kernel data.
> diff --git a/arch/x86/entry/vdso/vdso.lds.S b/arch/x86/entry/vdso/vdso.lds.S
> index 36b644e16272..4bf48462fca7 100644
> --- a/arch/x86/entry/vdso/vdso.lds.S
> +++ b/arch/x86/entry/vdso/vdso.lds.S
> @@ -27,6 +27,7 @@ VERSION {
>                 __vdso_time;
>                 clock_getres;
>                 __vdso_clock_getres;
> +               __vdso_sgx_enter_enclave;
>         local: *;
>         };
>  }
> diff --git a/arch/x86/entry/vdso/vsgx_enter_enclave.S b/arch/x86/entry/vdso/vsgx_enter_enclave.S
> new file mode 100644
> index 000000000000..94a8e5f99961
> --- /dev/null
> +++ b/arch/x86/entry/vdso/vsgx_enter_enclave.S
> @@ -0,0 +1,187 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <linux/linkage.h>
> +#include <asm/export.h>
> +#include <asm/errno.h>
> +
> +#include "extable.h"
> +
> +#define EX_LEAF                0*8
> +#define EX_TRAPNR      0*8+4
> +#define EX_ERROR_CODE  0*8+6
> +#define EX_ADDRESS     1*8
> +
> +.code64
> +.section .text, "ax"
> +
> +/**
> + * __vdso_sgx_enter_enclave() - Enter an SGX enclave
> + * @leaf:      ENCLU leaf, must be EENTER or ERESUME
> + * @tcs:       TCS, must be non-NULL
> + * @e:         Optional struct sgx_enclave_exception instance
> + * @handler:   Optional enclave exit handler
> + *
> + * **Important!**  __vdso_sgx_enter_enclave() is **NOT** compliant with the
> + * x86-64 ABI, i.e. cannot be called from standard C code.
> + *
> + * Input ABI:
> + *  @leaf      %eax
> + *  @tcs       8(%rsp)
> + *  @e                 0x10(%rsp)
> + *  @handler   0x18(%rsp)
> + *
> + * Output ABI:
> + *  @ret       %eax
> + *
> + * All general purpose registers except RAX, RBX and RCX are passed as-is to
> + * the enclave. RAX, RBX and RCX are consumed by EENTER and ERESUME and are
> + * loaded with @leaf, asynchronous exit pointer, and @tcs respectively.
> + *
> + * RBP and the stack are used to anchor __vdso_sgx_enter_enclave() to the
> + * pre-enclave state, e.g. to retrieve @e and @handler after an enclave exit.
> + * All other registers are available for use by the enclave and its runtime,
> + * e.g. an enclave can push additional data onto the stack (and modify RSP) to
> + * pass information to the optional exit handler (see below).
> + *
> + * Most exceptions reported on ENCLU, including those that occur within the
> + * enclave, are fixed up and reported synchronously instead of being delivered
> + * via a standard signal. Debug Exceptions (#DB) and Breakpoints (#BP) are
> + * never fixed up and are always delivered via standard signals. On synchrously
> + * reported exceptions, -EFAULT is returned and details about the exception are
> + * recorded in @e, the optional sgx_enclave_exception struct.
> +
> + * If an exit handler is provided, the handler will be invoked on synchronous
> + * exits from the enclave and for all synchronously reported exceptions. In
> + * latter case, @e is filled prior to invoking the handler.
> + *
> + * The exit handler's return value is interpreted as follows:
> + *  >0:                continue, restart __vdso_sgx_enter_enclave() with @ret as @leaf
> + *   0:                success, return @ret to the caller
> + *  <0:                error, return @ret to the caller
> + *
> + * The userspace exit handler is responsible for unwinding the stack, e.g. to
> + * pop @e, u_rsp and @tcs, prior to returning to __vdso_sgx_enter_enclave().

Unless I misunderstand, this documentation...

> + * The exit handler may also transfer control, e.g. via longjmp() or a C++
> + * exception, without returning to __vdso_sgx_enter_enclave().
> + *
> + * Return:
> + *  0 on success,
> + *  -EINVAL if ENCLU leaf is not allowed,
> + *  -EFAULT if an exception occurs on ENCLU or within the enclave
> + *  -errno for all other negative values returned by the userspace exit handler
> + */
> +#ifdef SGX_KERNEL_DOC
> +/* C-style function prototype to coerce kernel-doc into parsing the comment. */
> +int __vdso_sgx_enter_enclave(int leaf, void *tcs,
> +                            struct sgx_enclave_exception *e,
> +                            sgx_enclave_exit_handler_t handler);
> +#endif
> +SYM_FUNC_START(__vdso_sgx_enter_enclave)
> +       /* Prolog */
> +       .cfi_startproc
> +       push    %rbp
> +       .cfi_adjust_cfa_offset  8
> +       .cfi_rel_offset         %rbp, 0
> +       mov     %rsp, %rbp
> +       .cfi_def_cfa_register   %rbp
> +
> +.Lenter_enclave:
> +       /* EENTER <= leaf <= ERESUME */
> +       cmp     $0x2, %eax
> +       jb      .Linvalid_leaf
> +       cmp     $0x3, %eax
> +       ja      .Linvalid_leaf
> +
> +       /* Load TCS and AEP */
> +       mov     0x10(%rbp), %rbx
> +       lea     .Lasync_exit_pointer(%rip), %rcx
> +
> +       /* Single ENCLU serving as both EENTER and AEP (ERESUME) */
> +.Lasync_exit_pointer:
> +.Lenclu_eenter_eresume:
> +       enclu
> +
> +       /* EEXIT jumps here unless the enclave is doing something fancy. */
> +       xor     %eax, %eax
> +
> +       /* Invoke userspace's exit handler if one was provided. */
> +.Lhandle_exit:
> +       cmp     $0, 0x20(%rbp)
> +       jne     .Linvoke_userspace_handler
> +
> +.Lout:
> +       leave
> +       .cfi_def_cfa            %rsp, 8
> +       ret
> +
> +       /* The out-of-line code runs with the pre-leave stack frame. */
> +       .cfi_def_cfa            %rbp, 16
> +
> +.Linvalid_leaf:
> +       mov     $(-EINVAL), %eax
> +       jmp     .Lout
> +
> +.Lhandle_exception:
> +       mov     0x18(%rbp), %rcx
> +       test    %rcx, %rcx
> +       je      .Lskip_exception_info
> +
> +       /* Fill optional exception info. */
> +       mov     %eax, EX_LEAF(%rcx)
> +       mov     %di,  EX_TRAPNR(%rcx)
> +       mov     %si,  EX_ERROR_CODE(%rcx)
> +       mov     %rdx, EX_ADDRESS(%rcx)
> +.Lskip_exception_info:
> +       mov     $(-EFAULT), %eax
> +       jmp     .Lhandle_exit
> +
> +.Linvoke_userspace_handler:
> +       /* Pass the untrusted RSP (at exit) to the callback via %rcx. */
> +       mov     %rsp, %rcx
> +
> +       /* Save the untrusted RSP in %rbx (non-volatile register). */
> +       mov     %rsp, %rbx
> +
> +       /*
> +        * Align stack per x86_64 ABI. Note, %rsp needs to be 16-byte aligned
> +        * _after_ pushing the parameters on the stack, hence the bonus push.
> +        */
> +       and     $-0x10, %rsp
> +       push    %rax
> +
> +       /* Push @e, the "return" value and @tcs as params to the callback. */
> +       push    0x18(%rbp)
> +       push    %rax
> +       push    0x10(%rbp)
> +
> +       /* Clear RFLAGS.DF per x86_64 ABI */
> +       cld
> +
> +       /* Load the callback pointer to %rax and invoke it via retpoline. */
> +       mov     0x20(%rbp), %rax
> +       call    .Lretpoline
> +
> +       /* Restore %rsp to its post-exit value. */
> +       mov     %rbx, %rsp

... doesn't seem to match this code.

If the handler pops from the stack and then we restore the stack here,
the handler had no effect.

Also, one difference between this interface and a raw ENCLU[EENTER] is
that we can't pass arguments on the untrusted stack during EEXIT. If
we want to support that workflow, then we need to allow the ability
for the handler to pop "additional" values without restoring the stack
pointer to the exact value here.

> +       /*
> +        * If the return from callback is zero or negative, return immediately,
> +        * else re-execute ENCLU with the postive return value interpreted as
> +        * the requested ENCLU leaf.
> +        */
> +       cmp     $0, %eax
> +       jle     .Lout
> +       jmp     .Lenter_enclave
> +
> +.Lretpoline:
> +       call    2f
> +1:     pause
> +       lfence
> +       jmp     1b
> +2:     mov     %rax, (%rsp)
> +       ret
> +       .cfi_endproc
> +
> +_ASM_VDSO_EXTABLE_HANDLE(.Lenclu_eenter_eresume, .Lhandle_exception)
> +
> +SYM_FUNC_END(__vdso_sgx_enter_enclave)
> diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
> index 57d0d30c79b3..e196cfd44b70 100644
> --- a/arch/x86/include/uapi/asm/sgx.h
> +++ b/arch/x86/include/uapi/asm/sgx.h
> @@ -74,4 +74,41 @@ struct sgx_enclave_set_attribute {
>         __u64 attribute_fd;
>  };
>
> +/**
> + * struct sgx_enclave_exception - structure to report exceptions encountered in
> + *                               __vdso_sgx_enter_enclave()
> + *
> + * @leaf:      ENCLU leaf from \%eax at time of exception
> + * @trapnr:    exception trap number, a.k.a. fault vector
> + * @error_code:        exception error code
> + * @address:   exception address, e.g. CR2 on a #PF
> + * @reserved:  reserved for future use
> + */
> +struct sgx_enclave_exception {
> +       __u32 leaf;
> +       __u16 trapnr;
> +       __u16 error_code;
> +       __u64 address;
> +       __u64 reserved[2];
> +};
> +
> +/**
> + * typedef sgx_enclave_exit_handler_t - Exit handler function accepted by
> + *                                     __vdso_sgx_enter_enclave()
> + *
> + * @rdi:       RDI at the time of enclave exit
> + * @rsi:       RSI at the time of enclave exit
> + * @rdx:       RDX at the time of enclave exit
> + * @ursp:      RSP at the time of enclave exit (untrusted stack)
> + * @r8:                R8 at the time of enclave exit
> + * @r9:                R9 at the time of enclave exit
> + * @tcs:       Thread Control Structure used to enter enclave
> + * @ret:       0 on success (EEXIT), -EFAULT on an exception
> + * @e:         Pointer to struct sgx_enclave_exception (as provided by caller)
> + */
> +typedef int (*sgx_enclave_exit_handler_t)(long rdi, long rsi, long rdx,
> +                                         long ursp, long r8, long r9,
> +                                         void *tcs, int ret,
> +                                         struct sgx_enclave_exception *e);
> +
>  #endif /* _UAPI_ASM_X86_SGX_H */
> --
> 2.25.0
>

