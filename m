Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 639C618916D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 23:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgCQWaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 18:30:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgCQWaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 18:30:09 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 342BF20409;
        Tue, 17 Mar 2020 22:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584484209;
        bh=o8ZNCMkXZjVnIlo9/wMZey1YXi3Jg07cUnvtiDRqlOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N0uISv0MXfN6mCvtsByqJuSFHOxfBHEz2Ww6PSCrBJNmgm0VsEilxLpEjyFfgtj+K
         ptyPhLFLzZsBdWn6S2UTAn72S/WbdqB3YLIjGp5jij2oVW12Z/PNOM8cZjCbC6Rgkr
         ABD173ZaoHIBhzzUF4NDmMo4s5PF4fDIBnwku7Ys=
Date:   Tue, 17 Mar 2020 22:30:05 +0000
From:   Will Deacon <will@kernel.org>
To:     =?iso-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: clean up trampoline vector loads
Message-ID: <20200317223004.GJ20788@willie-the-truck>
References: <20200316124046.103844-1-remi@remlab.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200316124046.103844-1-remi@remlab.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 02:40:44PM +0200, Rémi Denis-Courmont wrote:
> From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> 
> This switches from custom instruction patterns to the regular large
> memory model sequence with ADRP and LDR. In doing so, the ADD
> instruction can be eliminated in the SDEI handler, and the code no
> longer assumes that the trampoline vectors and the vectors address both
> start on a page boundary.
> 
> Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> ---
>  arch/arm64/kernel/entry.S | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index e5d4e30ee242..24f828739696 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -805,9 +805,9 @@ alternative_else_nop_endif
>  2:
>  	tramp_map_kernel	x30
>  #ifdef CONFIG_RANDOMIZE_BASE
> -	adr	x30, tramp_vectors + PAGE_SIZE
> +	adrp	x30, tramp_vectors + PAGE_SIZE
>  alternative_insn isb, nop, ARM64_WORKAROUND_QCOM_FALKOR_E1003
> -	ldr	x30, [x30]
> +	ldr	x30, [x30, #:lo12:__entry_tramp_data_start]
>  #else
>  	ldr	x30, =vectors
>  #endif
> @@ -953,9 +953,8 @@ SYM_CODE_START(__sdei_asm_entry_trampoline)
>  1:	str	x4, [x1, #(SDEI_EVENT_INTREGS + S_ORIG_ADDR_LIMIT)]
>  
>  #ifdef CONFIG_RANDOMIZE_BASE
> -	adr	x4, tramp_vectors + PAGE_SIZE
> -	add	x4, x4, #:lo12:__sdei_asm_trampoline_next_handler
> -	ldr	x4, [x4]
> +	adrp	x4, tramp_vectors + PAGE_SIZE
> +	ldr	x4, [x4, #:lo12:__sdei_asm_trampoline_next_handler]
>  #else
>  	ldr	x4, =__sdei_asm_handler
>  #endif

Acked-by: Will Deacon <will@kernel.org>

Will
