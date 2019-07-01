Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44B48359C3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 11:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfFEJkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 05:40:37 -0400
Received: from foss.arm.com ([217.140.101.70]:56390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbfFEJkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 05:40:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B614C374;
        Wed,  5 Jun 2019 02:40:36 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B9A93F690;
        Wed,  5 Jun 2019 02:40:34 -0700 (PDT)
Date:   Wed, 5 Jun 2019 10:40:31 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ali Saidi <alisaidi@amazon.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matt Mackall <mpm@selenic.com>,
        Will Deacon <will.deacon@arm.com>,
        Ron Rindjunsky <ronrindj@amazon.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/3] arm64: export acpi_psci_use_hvc
Message-ID: <20190605094031.GB28613@e107155-lin>
References: <20190604203100.15050-1-alisaidi@amazon.com>
 <20190604203100.15050-3-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604203100.15050-3-alisaidi@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 08:30:59PM +0000, Ali Saidi wrote:
> Allow a module that wants to make SMC calls to detect if it should be
> using smc or hvc.
>
> Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> ---
>  arch/arm64/kernel/acpi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index 803f0494dd3e..ea41c6541d3c 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -119,6 +119,7 @@ bool acpi_psci_use_hvc(void)
>  {
>  	return acpi_gbl_FADT.arm_boot_flags & ACPI_FADT_PSCI_USE_HVC;
>  }
> +EXPORT_SYMBOL_GPL(acpi_psci_use_hvc);
>

I would rather have this in drivers/firmware/psci/psci.c checking the
value of psci_ops.conduit so that it's not just ACPI specific and can
be used on DT platforms too if required.

--
Regards,
Sudeep
