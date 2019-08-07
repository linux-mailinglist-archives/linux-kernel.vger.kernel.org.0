Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B127684A32
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 12:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfHGK46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 06:56:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfHGK46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 06:56:58 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7796321E6A;
        Wed,  7 Aug 2019 10:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565175417;
        bh=E+jdnPAL8byjVs25HbPkNIC+Qlh+GYI7JlSAMKjNmOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j0v7RK71k0oqk5weJNib/8LBsqGyJuYACUDft4NB8ckJHk84Ro4o9VTusqDkVFveE
         hInp6nbV+z6+c+eRkSZVJv21dWsErYP1VHjdJ7RmC2SBGYizMOpOtiO+ScxwmbGTe9
         r4JvYQc42MzUUHLNSqnCb0q5hGDm1JjgcMaFR6GU=
Date:   Wed, 7 Aug 2019 11:56:53 +0100
From:   Will Deacon <will@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/cache: fix -Woverride-init compiler warnings
Message-ID: <20190807105652.cyi3fou2rfsxhxrk@willie-the-truck>
References: <20190806193434.965-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806193434.965-1-cai@lca.pw>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 03:34:34PM -0400, Qian Cai wrote:
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index 876055e37352..a0c495a3f4fd 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -34,10 +34,7 @@ DEFINE_PER_CPU(struct cpuinfo_arm64, cpu_data);
>  static struct cpuinfo_arm64 boot_cpu_data;
>  
>  static char *icache_policy_str[] = {
> -	[0 ... ICACHE_POLICY_PIPT]	= "RESERVED/UNKNOWN",
> -	[ICACHE_POLICY_VIPT]		= "VIPT",
> -	[ICACHE_POLICY_PIPT]		= "PIPT",
> -	[ICACHE_POLICY_VPIPT]		= "VPIPT",
> +	[0 ... ICACHE_POLICY_PIPT]	= "RESERVED/UNKNOWN"
>  };
>  
>  unsigned long __icache_flags;
> @@ -310,13 +307,16 @@ static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
>  
>  	switch (l1ip) {
>  	case ICACHE_POLICY_PIPT:
> +		icache_policy_str[ICACHE_POLICY_PIPT] = "PIPT";
>  		break;
>  	case ICACHE_POLICY_VPIPT:
> +		icache_policy_str[ICACHE_POLICY_VPIPT] = "VPIPT";
>  		set_bit(ICACHEF_VPIPT, &__icache_flags);
>  		break;
>  	default:
>  		/* Fallthrough */
>  	case ICACHE_POLICY_VIPT:
> +		icache_policy_str[ICACHE_POLICY_VIPT] = "VIPT";
>  		/* Assume aliasing */
>  		set_bit(ICACHEF_ALIASING, &__icache_flags);

I still think this is worse than the code in mainline. I don't think
-Woverride-init should warn when overriding a field from a GCC range
designated initialiser, since it makes them considerably less useful
imo.

Will
