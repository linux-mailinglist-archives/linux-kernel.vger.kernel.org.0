Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23F6F3CC03
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 14:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389004AbfFKMqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 08:46:46 -0400
Received: from foss.arm.com ([217.140.110.172]:60506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387593AbfFKMqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 08:46:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E1EA344;
        Tue, 11 Jun 2019 05:46:45 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D29B3F557;
        Tue, 11 Jun 2019 05:46:44 -0700 (PDT)
Date:   Tue, 11 Jun 2019 13:46:42 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, marc.zyngier@arm.com, yuzenghui@huawei.com,
        wanghaibin.wang@huawei.com, james.morse@arm.com,
        will.deacon@arm.com, catalin.marinas@arm.com, liwei391@huawei.com
Subject: Re: [PATCH v4 2/8] arm64: irqflags: Pass flags as readonly operand
 to restore instruction
Message-ID: <20190611124641.GB29008@lakrids.cambridge.arm.com>
References: <1560245893-46998-1-git-send-email-julien.thierry@arm.com>
 <1560245893-46998-3-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560245893-46998-3-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 10:38:07AM +0100, Julien Thierry wrote:
> Flags are only read by the instructions doing the irqflags restore
> operation. Pass the operand as read only to the asm inline instead of
> read-write.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Mark Rutland <mark.rutland@ar.com>

Mark.

> ---
>  arch/arm64/include/asm/irqflags.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> index 62996318..9c93152 100644
> --- a/arch/arm64/include/asm/irqflags.h
> +++ b/arch/arm64/include/asm/irqflags.h
> @@ -119,8 +119,8 @@ static inline void arch_local_irq_restore(unsigned long flags)
>  			__msr_s(SYS_ICC_PMR_EL1, "%0")
>  			"dsb	sy",
>  			ARM64_HAS_IRQ_PRIO_MASKING)
> -		: "+r" (flags)
>  		:
> +		: "r" (flags)
>  		: "memory");
>  }
> 
> --
> 1.9.1
