Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 476365BE7C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 16:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbfGAOkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 10:40:45 -0400
Received: from foss.arm.com ([217.140.110.172]:36234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbfGAOkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 10:40:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E041344;
        Mon,  1 Jul 2019 07:40:44 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AA693F246;
        Mon,  1 Jul 2019 07:40:43 -0700 (PDT)
Date:   Mon, 1 Jul 2019 15:40:41 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, peterz@infradead.org, will.deacon@arm.com,
        julien.thierry@arm.com
Subject: Re: [RFC V3 12/18] arm64: assembler: Add macro to annotate asm
 function having non standard stack-frame.
Message-ID: <20190701144039.GD21774@arrakis.emea.arm.com>
References: <20190624095548.8578-1-raphael.gault@arm.com>
 <20190624095548.8578-13-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624095548.8578-13-raphael.gault@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 10:55:42AM +0100, Raphael Gault wrote:
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -752,4 +752,17 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
>  .Lyield_out_\@ :
>  	.endm
>  
> +	/*
> +	 * This macro is the arm64 assembler equivalent of the
> +	 * macro STACK_FRAME_NON_STANDARD define at
> +	 * ~/include/linux/frame.h
> +	 */
> +	.macro	asm_stack_frame_non_standard	func
> +#ifdef	CONFIG_STACK_VALIDATION
> +	.pushsection ".discard.func_stack_frame_non_standard"
> +	.8byte	\func

Nitpicks:

Does .quad vs .8byte make any difference?

Could we place this in include/linux/frame.h directly with a generic
name (and some __ASSEMBLY__ guards)? It doesn't look to be arm specific.

-- 
Catalin
