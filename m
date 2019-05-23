Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E76B275EB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 08:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfEWGOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 02:14:32 -0400
Received: from ozlabs.org ([203.11.71.1]:45989 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfEWGOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 02:14:32 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
        id 458fNP5zgyz9s6w; Thu, 23 May 2019 16:14:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1558592069; bh=Tr73qojhfVjEZCm5/e8GumQVv2PX+3DhCXwgTZaf9eA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iHrJwjk21wsErNroYSoT3Ay7LcZvRgset0OR28n19aUJtizFBULwKHdwdYeELZVs7
         yQPr7hIxjT5QEbkSpu3LKQ6llJyW68FWRehC62TVIJeG3HFl5Qsg3AMUz0UEajvyyM
         bVresl/mOT5RkLO74c/3INadBxhN1LVXXyTioH9J6MfswNVeFHbFzupj3NGWBxqnsY
         O8niIP6YeNyWk6V4PZ/f+uFR/AXmo6H/MZegB6COwqBtZbgUaCZEb3VVJb5tBp/nu7
         y+e3lIhYIFqwRwNQ4IPe1vTPwM6Ry4yf95i8zN7ALEM7LiEfdYVJwP/kHEnOd+Wgr7
         4yRKQ9xdStmHQ==
Date:   Thu, 23 May 2019 16:14:27 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 14/16] powerpc/32: implement fast entry for syscalls
 on BOOKE
Message-ID: <20190523061427.GA19655@blackberry>
References: <cover.1556627571.git.christophe.leroy@c-s.fr>
 <3e254178a157e7eaeef48f983880f71f97d1f296.1556627571.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e254178a157e7eaeef48f983880f71f97d1f296.1556627571.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 12:39:03PM +0000, Christophe Leroy wrote:
> This patch implements a fast entry for syscalls.
> 
> Syscalls don't have to preserve non volatile registers except LR.
> 
> This patch then implement a fast entry for syscalls, where
> volatile registers get clobbered.
> 
> As this entry is dedicated to syscall it always sets MSR_EE
> and warns in case MSR_EE was previously off
> 
> It also assumes that the call is always from user, system calls are
> unexpected from kernel.

This is now upstream as commit 1a4b739bbb4f.  On the e500mc test
config that I use, I'm getting this build failure:

arch/powerpc/kernel/head_fsl_booke.o: In function `SystemCall':
arch/powerpc/kernel/head_fsl_booke.S:416: undefined reference to `kvmppc_handler_BOOKE_INTERRUPT_SYSCALL_SPRN_SRR1'
Makefile:1052: recipe for target 'vmlinux' failed

> +.macro SYSCALL_ENTRY trapno intno
> +	mfspr	r10, SPRN_SPRG_THREAD
> +#ifdef CONFIG_KVM_BOOKE_HV
> +BEGIN_FTR_SECTION
> +	mtspr	SPRN_SPRG_WSCRATCH0, r10
> +	stw	r11, THREAD_NORMSAVE(0)(r10)
> +	stw	r13, THREAD_NORMSAVE(2)(r10)
> +	mfcr	r13			/* save CR in r13 for now	   */
> +	mfspr	r11, SPRN_SRR1
> +	mtocrf	0x80, r11	/* check MSR[GS] without clobbering reg */
> +	bf	3, 1975f
> +	b	kvmppc_handler_BOOKE_INTERRUPT_\intno\()_SPRN_SRR1

It seems to me that the "_SPRN_SRR1" on the end of this line
isn't meant to be there...  However, it still fails to link with that
removed.

Paul.
