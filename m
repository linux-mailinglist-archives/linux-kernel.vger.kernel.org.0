Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B978EC0352
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 12:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfI0KUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 06:20:16 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60750 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbfI0KUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 06:20:15 -0400
Received: from zn.tnic (p200300EC2F0ABB00FD8B4CEC558476E8.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:bb00:fd8b:4cec:5584:76e8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A912B1EC0716;
        Fri, 27 Sep 2019 12:20:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1569579613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bvEi6n7NBCi367l5LS3E1JRtEJOQ/n+3qud74Zlw/UE=;
        b=lHF9+y0rrasRNBd/VkCcTfZRIDvyTjicJg4FTtoJK8P7TrcZkiWpj19o2SXJr16Hxal5QW
        SVV/hOoPRXF10iYdd3dWsW5Rov75YCocjgpOoaXHgK66pHHYQ884I+PrJIZErdk0ecHtIp
        jr6F/Gq+AmwkBWtYMOo/g7WaqSvW/2s=
Date:   Fri, 27 Sep 2019 12:20:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, josh@joshtriplett.org, luto@kernel.org,
        kai.huang@intel.com, rientjes@google.com, cedric.xing@intel.com
Subject: Re: [PATCH v22 05/24] x86/sgx: Add ENCLS architectural error codes
Message-ID: <20190927102013.GA23002@zn.tnic>
References: <20190903142655.21943-1-jarkko.sakkinen@linux.intel.com>
 <20190903142655.21943-6-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190903142655.21943-6-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 05:26:36PM +0300, Jarkko Sakkinen wrote:
> Document ENCLS architectural error codes. These error codes are returned by
> the SGX opcodes. Make the header as part of the uapi so that they can be
> used in some situations directly returned to the user space (ENCLS[EINIT]
> leaf function error codes could be one potential use case).
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/include/uapi/asm/sgx_errno.h | 91 +++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 arch/x86/include/uapi/asm/sgx_errno.h
> 
> diff --git a/arch/x86/include/uapi/asm/sgx_errno.h b/arch/x86/include/uapi/asm/sgx_errno.h
> new file mode 100644
> index 000000000000..48b87aed58d7
> --- /dev/null
> +++ b/arch/x86/include/uapi/asm/sgx_errno.h
> @@ -0,0 +1,91 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> +/*
> + * Copyright(c) 2018 Intel Corporation.
> + *
> + * Contains the architecturally defined error codes that are returned by SGX
> + * instructions, e.g. ENCLS, and may be propagated to userspace via errno.
> + */
> +
> +#ifndef _UAPI_ASM_X86_SGX_ERRNO_H
> +#define _UAPI_ASM_X86_SGX_ERRNO_H
> +
> +/**
> + * enum sgx_encls_leaves - return codes for ENCLS, ENCLU and ENCLV
> + * %SGX_SUCCESS:		No error.
> + * %SGX_INVALID_SIG_STRUCT:	SIGSTRUCT contains an invalid value.
> + * %SGX_INVALID_ATTRIBUTE:	Enclave is not attempting to access a resource

That first "not" looks wrong.

> + *				for which it is not authorized.
> + * %SGX_BLKSTATE:		EPC page is already blocked.
> + * %SGX_INVALID_MEASUREMENT:	SIGSTRUCT or EINITTOKEN contains an incorrect
> + *				measurement.
> + * %SGX_NOTBLOCKABLE:		EPC page type is not one which can be blocked.
> + * %SGX_PG_INVLD:		EPC page is invalid (and cannot be blocked).
> + * %SGX_EPC_PAGE_CONFLICT:	EPC page in use by another SGX instruction.
> + * %SGX_INVALID_SIGNATURE:	Enclave's signature does not validate with
> + *				public key enclosed in SIGSTRUCT.
> + * %SGX_MAC_COMPARE_FAIL:	MAC check failed when reloading EPC page.
> + * %SGX_PAGE_NOT_BLOCKED:	EPC page is not marked as blocked.
> + * %SGX_NOT_TRACKED:		ETRACK has not been completed on the EPC page.
> + * %SGX_VA_SLOT_OCCUPIED:	Version array slot contains a valid entry.
> + * %SGX_CHILD_PRESENT:		Enclave has child pages present in the EPC.
> + * %SGX_ENCLAVE_ACT:		Logical processors are currently executing
> + *				inside the enclave.
> + * %SGX_ENTRYEPOCH_LOCKED:	SECS locked for EPOCH update, i.e. an ETRACK is
> + *				currently executing on the SECS.
> + * %SGX_INVALID_EINITTOKEN:	EINITTOKEN is invalid and enclave signer's
> + *				public key does not match IA32_SGXLEPUBKEYHASH.
> + * %SGX_PREV_TRK_INCMPL:	All processors did not complete the previous
> + *				tracking sequence.
> + * %SGX_PG_IS_SECS:		Target EPC page is an SECS and cannot be
> + *				blocked.
> + * %SGX_PAGE_ATTRIBUTES_MISMATCH:	Attributes of the EPC page do not match
> + *					the expected values.

You sometimes call it "PG" and sometimes "PAGE". Unify?

> + * %SGX_PAGE_NOT_MODIFIABLE:	EPC page cannot be modified because it is in
> + *				the PENDING or MODIFIED state.
> + * %SGX_PAGE_NOT_DEBUGGABLE:	EPC page cannot be modified because it is in
> + *				the PENDING or MODIFIED state.

Same description text?

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
