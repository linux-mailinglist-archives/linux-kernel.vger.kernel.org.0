Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBBDAF50E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 13:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfD3LG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 07:06:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44526 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbfD3LG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:06:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0A0180D;
        Tue, 30 Apr 2019 04:06:28 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40C353F5C1;
        Tue, 30 Apr 2019 04:06:27 -0700 (PDT)
Date:   Tue, 30 Apr 2019 12:06:24 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Arun KS <arunks@codeaurora.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>,
        Steve Capper <steve.capper@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: arm64: Fix size of __early_cpu_boot_status
Message-ID: <20190430110624.GB16204@fuggles.cambridge.arm.com>
References: <1556620535-10060-1-git-send-email-arunks@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556620535-10060-1-git-send-email-arunks@codeaurora.org>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 04:05:04PM +0530, Arun KS wrote:
> __early_cpu_boot_status is of type long. Use quad
> assembler directive to allocate proper size.
> 
> Signed-off-by: Arun KS <arunks@codeaurora.org>
> ---
>  arch/arm64/kernel/head.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index eecf792..115f332 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -684,7 +684,7 @@ ENTRY(__boot_cpu_mode)
>   * with MMU turned off.
>   */
>  ENTRY(__early_cpu_boot_status)
> -	.long 	0
> +	.quad 	0

Yikes. How did you spot this? Did we end up corrupting an adjacent variable,
or does the alignment in the linker script save us in practice?

Will
