Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C93E3D6624
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 17:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387596AbfJNPco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 11:32:44 -0400
Received: from foss.arm.com ([217.140.110.172]:47034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728905AbfJNPco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:32:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F24F628;
        Mon, 14 Oct 2019 08:32:43 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF1D83F68E;
        Mon, 14 Oct 2019 08:32:42 -0700 (PDT)
Date:   Mon, 14 Oct 2019 16:32:40 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, Dave.Martin@arm.com,
        suzuki.poulose@arm.com
Subject: Re: [PATCH] arm64: cpufeature: Don't expose ZFR0 to userspace when
 SVE is not enabled
Message-ID: <20191014153240.GB20438@lakrids.cambridge.arm.com>
References: <20191014102113.16546-1-julien.grall@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014102113.16546-1-julien.grall@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 11:21:13AM +0100, Julien Grall wrote:
> The kernel may not support SVE if CONFIG_ARM64_SVE is not set and
> will hide the feature from the from userspace.

Nit: s/may not/will not/

> 
> Unfortunately, the fields of ID_AA64ZFR0_EL1 are still exposed and could
> lead to undefined behavior in userspace.
> 
> The kernel should not used the register when CONFIG_SVE is disabled.
> Therefore, we only need to hidden them from the userspace.
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> Fixes: 06a916feca2b ('arm64: Expose SVE2 features for userspace')

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/cpufeature.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index cabebf1a7976..80f459ad0190 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -176,11 +176,16 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr1[] = {
>  };
>  
>  static const struct arm64_ftr_bits ftr_id_aa64zfr0[] = {
> -	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_SM4_SHIFT, 4, 0),
> -	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_SHA3_SHIFT, 4, 0),
> -	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_BITPERM_SHIFT, 4, 0),
> -	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_AES_SHIFT, 4, 0),
> -	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_SVEVER_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
> +		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_SM4_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
> +		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_SHA3_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
> +		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_BITPERM_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
> +		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_AES_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
> +		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_SVEVER_SHIFT, 4, 0),
>  	ARM64_FTR_END,
>  };
>  
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
