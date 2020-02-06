Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A65A31541CC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 11:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgBFKXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 05:23:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:42254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728261AbgBFKXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:23:45 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44DD7206CC;
        Thu,  6 Feb 2020 10:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580984625;
        bh=fznLLoDfGfg3j/4UEm5cT+Z+SIUayCwPJ8HX78CG7PQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oHPX0Q/JFvQhIpKA+qOX3GhPwqPaAsgjwbCw2CGiV2FceU70zXoL6jfOQ6TilEhpn
         d3KqxNF80Sejdl4AKeBO7/cK0Kgfp4Hxttccet8xx9fmce0+DEnhfeDYtshBn45WKc
         xys0xmee8ckM9gJs/ensRBMhoF0viFouoAP+r2f8=
Date:   Thu, 6 Feb 2020 10:23:40 +0000
From:   Will Deacon <will@kernel.org>
To:     Hoan Tran <Hoan@os.amperecomputing.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@os.amperecomputing.com
Subject: Re: [PATCH] arm64: Kconfig: Enable NODES_SPAN_OTHER_NODES config for
 NUMA
Message-ID: <20200206102340.GA17074@willie-the-truck>
References: <1580759714-4614-1-git-send-email-Hoan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580759714-4614-1-git-send-email-Hoan@os.amperecomputing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 11:55:14AM -0800, Hoan Tran wrote:
> Some NUMA nodes have memory ranges that span other nodes.
> Even though a pfn is valid and between a node's start and end pfns,
> it may not reside on that node.
> 
> This patch enables NODES_SPAN_OTHER_NODES config for NUMA to support
> this type of NUMA layout.
> 
> Signed-off-by: Hoan Tran <Hoan@os.amperecomputing.com>
> ---
>  arch/arm64/Kconfig | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index e688dfa..939d28f 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -959,6 +959,13 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
>  config HOLES_IN_ZONE
>  	def_bool y
>  
> +# Some NUMA nodes have memory ranges that span other nodes.
> +# Even though a pfn is valid and between a node's start and end pfns,
> +# it may not reside on that node.
> +config NODES_SPAN_OTHER_NODES
> +	def_bool y
> +	depends on ACPI_NUMA
> +

I thought we agreed to do this in the core code?

https://lore.kernel.org/lkml/1562887528-5896-1-git-send-email-Hoan@os.amperecomputing.com

Will
