Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8E7CE76CB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 17:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403827AbfJ1Ql5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 12:41:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733000AbfJ1Ql4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:41:56 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DE9120717;
        Mon, 28 Oct 2019 16:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572280916;
        bh=xtvPd1K/YDW7pOBLtD45xOTJPSaoVEBKM/lFmfsk+04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yqVSXkmCm0ZzMkqp9I3WP1EDc2BAzYsjc90PkXO9y3vZOZvnOYvA8I5H0zhGnodkU
         gHhZSDI+/bAmJmO/06vSWWfhBiIbZkqQ3NF0+klZAAnUN8N78KP7Eptjm+1l4Jx7c9
         3f0bwKZeh7ISaQoMrM82OPdz0s+KFVa7jfxbp1pA=
Date:   Mon, 28 Oct 2019 16:41:51 +0000
From:   Will Deacon <will@kernel.org>
To:     Xiang Zheng <zhengxiang9@huawei.com>
Cc:     catalin.marinas@arm.com, james.morse@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wanghaibin.wang@huawei.com
Subject: Re: [PATCH] arm64: print additional fault message when executing
 non-exec memory
Message-ID: <20191028164150.GG5576@willie-the-truck>
References: <20191028090837.39652-1-zhengxiang9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028090837.39652-1-zhengxiang9@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 05:08:37PM +0800, Xiang Zheng wrote:
> When attempting to executing non-executable memory, the fault message
> shows:
> 
>   Unable to handle kernel read from unreadable memory at virtual address
>   ffff802dac469000
> 
> This may confuse someone, so add a new fault message for instruction
> abort.
> 
> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
> ---
>  arch/arm64/mm/fault.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 9fc6db0bcbad..68bf4ec376d0 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -318,6 +318,8 @@ static void __do_kernel_fault(unsigned long addr, unsigned int esr,
>  	if (is_el1_permission_fault(addr, esr, regs)) {
>  		if (esr & ESR_ELx_WNR)
>  			msg = "write to read-only memory";
> +		else if (is_el1_instruction_abort(esr))
> +			msg = "execute non-executable memory";

nit, please make this "execute from non-executable memory".

With that:

Acked-by: Will Deacon <will@kernel.org>

Will
