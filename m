Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80C7818925A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 00:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgCQX5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 19:57:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:55895 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbgCQX5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 19:57:12 -0400
IronPort-SDR: ilKyHzLNizQHyUsRHx3AFzsaPZI4iBACOuO8ZH3J/GiCvZ1aHfHirTosROixOTRCTK7UTkajsC
 mpZ6z3T8xitA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 16:57:12 -0700
IronPort-SDR: B/zyD7SdD9qY+h0RPpxyTFvoomK+whseoGlVtsmDJCpXzWa+ayA2Y69qlgLicY6sgBUbvlm9zl
 v8IoZpLNvVGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,565,1574150400"; 
   d="scan'208";a="238041256"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga008.fm.intel.com with ESMTP; 17 Mar 2020 16:57:11 -0700
Date:   Tue, 17 Mar 2020 16:57:11 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     "Xing, Cedric" <cedric.xing@intel.com>
Cc:     Nathaniel McCallum <npmccallum@redhat.com>,
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
Subject: Re: [PATCH v28 21/22] x86/vdso: Implement a vDSO for Intel SGX
 enclave call
Message-ID: <20200317235711.GC14566@linux.intel.com>
References: <CAOASepM1pp1emPwSdFcaRkZfFm6sNmwPCJH+iFMiaJpFjU0VxQ@mail.gmail.com>
 <5dc2ec4bc9433f9beae824759f411c32b45d4b74.camel@linux.intel.com>
 <20200316225322.GJ24267@linux.intel.com>
 <fa773504-4cc1-5cbd-c018-890f7a5d3152@intel.com>
 <20200316235934.GM24267@linux.intel.com>
 <ca2c9ac0-b717-ee96-c7df-4e39f03a9193@intel.com>
 <CAOASepN7n1XUGPQHwk2Vcu-dyyBJ7dwhM_mF_RcJa71PcNiLmA@mail.gmail.com>
 <afec507a-48cd-a730-586a-b9135cc66315@intel.com>
 <20200317220948.GB14566@linux.intel.com>
 <acf660c0-7b8e-911c-8640-75fe43e5c384@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acf660c0-7b8e-911c-8640-75fe43e5c384@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 03:36:57PM -0700, Xing, Cedric wrote:
> On 3/17/2020 3:09 PM, Sean Christopherson wrote:
> >On Tue, Mar 17, 2020 at 02:40:34PM -0700, Xing, Cedric wrote:
> >>Hi Nathaniel,
> >>
> >>I reread your email today and thought I might have misunderstood your email
> >>earlier. What changes are you asking for exactly? Is that just passing @leaf
> >>in %ecx rather than in %eax? If so, I wouldn't have any problem. I agree
> >>with you that the resulted API would then be callable from C, even though it
> >>wouldn't be able to return back to C due to tampered %rbx. But I think the
> >>vDSO API can preserve %rbx too, given it is used by both EENTER and EEXIT
> >>(so is unavailable for parameter passing anyway). Alternatively, the C
> >>caller can setjmp() to be longjmp()'d back from within the exit handler.
> >
> >Yep, exactly.  The other proposed change that is fairly straightforward is
> >to make the save/restore of %rsp across the exit handler call relative
> >instead of absolute, i.e. allow the exit handler to modify %rsp.  I don't
> >think this would conflict with the Intel SDK usage model?
> >
> >diff --git a/arch/x86/entry/vdso/vsgx_enter_enclave.S b/arch/x86/entry/vdso/vsgx_enter_enclave.S
> >index 94a8e5f99961..05d54f79b557 100644
> >--- a/arch/x86/entry/vdso/vsgx_enter_enclave.S
> >+++ b/arch/x86/entry/vdso/vsgx_enter_enclave.S
> >@@ -139,8 +139,9 @@ SYM_FUNC_START(__vdso_sgx_enter_enclave)
> >         /* Pass the untrusted RSP (at exit) to the callback via %rcx. */
> >         mov     %rsp, %rcx
> >
> >-       /* Save the untrusted RSP in %rbx (non-volatile register). */
> >+       /* Save the untrusted RSP offset in %rbx (non-volatile register). */
> >         mov     %rsp, %rbx
> >+       and     $0xf, %rbx
> >
> >         /*
> >          * Align stack per x86_64 ABI. Note, %rsp needs to be 16-byte aligned
> >@@ -161,8 +162,8 @@ SYM_FUNC_START(__vdso_sgx_enter_enclave)
> >         mov     0x20(%rbp), %rax
> >         call    .Lretpoline
> >
> >-       /* Restore %rsp to its post-exit value. */
> >-       mov     %rbx, %rsp
> >+       /* Undo the post-exit %rsp adjustment. */
> >+       lea     0x20(%rsp,%rbx), %rsp
> >
> Yep. Though it looks a bit uncommon, I do think it will work.

Heh, I had about the same level of confidence.

I'll put together a set of patches tomorrow and post them to linux-sgx (and
cc relevant parties).  It'll be easier to continue the discussion with code
to look at and we can stop spamming LKML for a bit :-)
