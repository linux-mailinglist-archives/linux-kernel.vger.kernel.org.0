Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFF73849BB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 12:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbfHGKiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 06:38:15 -0400
Received: from foss.arm.com ([217.140.110.172]:46260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbfHGKiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 06:38:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B04A328;
        Wed,  7 Aug 2019 03:38:13 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C72913F575;
        Wed,  7 Aug 2019 03:38:12 -0700 (PDT)
Date:   Wed, 7 Aug 2019 11:38:10 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com
Subject: Re: [PATCH] arm64/ptrace: Fix typoes in sve_set() comment
Message-ID: <20190807103810.GF10425@arm.com>
References: <20190807103445.32257-1-julien.grall@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807103445.32257-1-julien.grall@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 11:34:45AM +0100, Julien Grall wrote:
> The ptrace trace SVE flags are prefixed with SVE_PT_*. Update the
> comment accordingly.
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> ---
>  arch/arm64/kernel/ptrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 17525da8d5c8..0de3eae09d36 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -870,7 +870,7 @@ static int sve_set(struct task_struct *target,
>  		goto out;
>  
>  	/*
> -	 * Apart from PT_SVE_REGS_MASK, all PT_SVE_* flags are consumed by
> +	 * Apart from SVE_PT_REGS_MASK, all SVE_PT_* flags are consumed by
>  	 * sve_set_vector_length(), which will also validate them for us:
>  	 */

Thanks for spotting that.

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Cheers
---Dave
