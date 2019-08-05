Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71030815E9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 11:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfHEJxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 05:53:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727158AbfHEJxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:53:01 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF188217D9;
        Mon,  5 Aug 2019 09:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564998780;
        bh=Keolo4uD8qVVOXpyPQKrCcwdglcn3RBBHp23/JSb1GQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UB146OiDMhmIAlVUQrsvF7Pr7/CbDwjh9BAslUhM0T2kUCIztdiab7gPobwXubO6t
         NGXxPUhbebq3xbgjP+pcftEZkN8uXkMrZsQpCiounajddlzAEIFKyEO4tRTa2QjaBT
         xf4qgxNb/CMXukNd7xsuCp/HPm0cF7qs2bzQYqoI=
Date:   Mon, 5 Aug 2019 10:52:56 +0100
From:   Will Deacon <will@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/cache: fix -Woverride-init compiler warnings
Message-ID: <20190805095256.ocgdb2yfhnbdz6kw@willie-the-truck>
References: <1564759944-2197-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564759944-2197-1-git-send-email-cai@lca.pw>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 11:32:24AM -0400, Qian Cai wrote:
> The commit 155433cb365e ("arm64: cache: Remove support for ASID-tagged
> VIVT I-caches") introduced some compiation warnings from GCC,
> 
> arch/arm64/kernel/cpuinfo.c:38:26: warning: initialized field
> overwritten [-Woverride-init]
>   [ICACHE_POLICY_VIPT]  = "VIPT",
>                           ^~~~~~
> arch/arm64/kernel/cpuinfo.c:38:26: note: (near initialization for
> 'icache_policy_str[2]')
> arch/arm64/kernel/cpuinfo.c:39:26: warning: initialized field
> overwritten [-Woverride-init]
>   [ICACHE_POLICY_PIPT]  = "PIPT",
>                           ^~~~~~
> arch/arm64/kernel/cpuinfo.c:39:26: note: (near initialization for
> 'icache_policy_str[3]')
> arch/arm64/kernel/cpuinfo.c:40:27: warning: initialized field
> overwritten [-Woverride-init]
>   [ICACHE_POLICY_VPIPT]  = "VPIPT",
>                            ^~~~~~~
> arch/arm64/kernel/cpuinfo.c:40:27: note: (near initialization for
> 'icache_policy_str[0]')
> 
> because it initializes icache_policy_str[0 ... 3] twice.
> 
> Fixes: 155433cb365e ("arm64: cache: Remove support for ASID-tagged VIVT I-caches")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/arm64/kernel/cpuinfo.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index 876055e37352..193b38da8d96 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -34,10 +34,10 @@
>  static struct cpuinfo_arm64 boot_cpu_data;
>  
>  static char *icache_policy_str[] = {
> -	[0 ... ICACHE_POLICY_PIPT]	= "RESERVED/UNKNOWN",
> +	[ICACHE_POLICY_VPIPT]		= "VPIPT",
> +	[ICACHE_POLICY_VPIPT + 1]	= "RESERVED/UNKNOWN",
>  	[ICACHE_POLICY_VIPT]		= "VIPT",
>  	[ICACHE_POLICY_PIPT]		= "PIPT",
> -	[ICACHE_POLICY_VPIPT]		= "VPIPT",

I really don't like this patch. Using "[0 ... MAXIDX] = <default>" is a
useful idiom and I think the code is more error-prone the way you have
restructured it.

Why are you passing -Woverride-init to the compiler anyway? There's only
one Makefile that references that option, and it's specific to a pinctrl
driver.

Will
