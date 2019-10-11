Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1ABD45A6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 18:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfJKQnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 12:43:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbfJKQnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:43:23 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 610472089F;
        Fri, 11 Oct 2019 16:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570812203;
        bh=1h3qain3eXPpQepsaq86h8dH0WgBOqiHsC+GQUWU3jc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0rPAFv32q98S+p+CmnLkOALxiZP1+SlhBCy+I+SkWhavMqNH84K4tjmsx4QkfJw+D
         b7p2m9sNPQWBUgAryIILE3xViIl5r435daf8r71mJqrhYtyw1f0WEpr+Uielm5wFD3
         j1RLsVFnG25MXv1aeen53pwgmKOQQMXtbZI0Dmss=
Date:   Fri, 11 Oct 2019 17:43:19 +0100
From:   Will Deacon <will@kernel.org>
To:     wangxu <wangxu72@huawei.com>
Cc:     mark.rutland@arm.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM/hw_breakpoint: modify dead code for
 breakpoint_handler()
Message-ID: <20191011164319.2on7snv65jdbz3sb@willie-the-truck>
References: <1570613220-59533-1-git-send-email-wangxu72@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570613220-59533-1-git-send-email-wangxu72@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 05:27:00PM +0800, wangxu wrote:
> From: Wang Xu <wangxu72@huawei.com>
> 
> In perf_event_alloc(), event->overflow_handler is initialized to a
> non-null value, which makes enable_single_step(bp, addr) in
> breakpoint_handler() never be executed.
> 
> As a matter of fact, the branch condition has been updated to
> is_default_overflow_handler().
> 
> Signed-off-by: Wang Xu <wangxu72@huawei.com>
> ---
>  arch/arm/kernel/hw_breakpoint.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
> index b0c195e..586a587 100644
> --- a/arch/arm/kernel/hw_breakpoint.c
> +++ b/arch/arm/kernel/hw_breakpoint.c
> @@ -822,7 +822,7 @@ static void breakpoint_handler(unsigned long unknown, struct pt_regs *regs)
>  			info->trigger = addr;
>  			pr_debug("breakpoint fired: address = 0x%x\n", addr);
>  			perf_bp_event(bp, regs);
> -			if (!bp->overflow_handler)
> +			if (is_default_overflow_handler(bp))
>  				enable_single_step(bp, addr);
>  			goto unlock;

Seems to match what we do on arm64, so:

Acked-by: Will Deacon <will@kernel.org>

You'll need to put this into rmk's patch system [1].

Will

[1] https://www.arm.linux.org.uk/developer/
