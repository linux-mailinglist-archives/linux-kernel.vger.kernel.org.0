Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62BE312FA18
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 17:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgACQIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 11:08:25 -0500
Received: from foss.arm.com ([217.140.110.172]:56500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgACQIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 11:08:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3695328;
        Fri,  3 Jan 2020 08:08:23 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C3F23F703;
        Fri,  3 Jan 2020 08:08:23 -0800 (PST)
Date:   Fri, 3 Jan 2020 16:08:21 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Joe Perches <joe@perches.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: Kconfig: Remove CONFIG_ prefix from
 ARM64_PSEUDO_NMI section
Message-ID: <20200103160820.GF10107@arrakis.emea.arm.com>
References: <78317df96ccb67b462878e07b3f87348c9d898cc.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78317df96ccb67b462878e07b3f87348c9d898cc.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 01:54:57AM -0800, Joe Perches wrote:
> Remove the CONFIG_ prefix from the select statement for ARM_GIC_V3.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/arm64/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b1b447..e9b1fc 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1544,7 +1544,7 @@ config ARM64_MODULE_PLTS
>  
>  config ARM64_PSEUDO_NMI
>  	bool "Support for NMI-like interrupts"
> -	select CONFIG_ARM_GIC_V3
> +	select ARM_GIC_V3
>  	help
>  	  Adds support for mimicking Non-Maskable Interrupts through the use of
>  	  GIC interrupt priority. This support requires version 3 or later of

Ah, kbuild doesn't warn about this. Anyway, it's not urgent since we
already select ARM_GIC_V3 in the main ARM64 config, so Will can pick it
up for 5.6. Thanks.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
