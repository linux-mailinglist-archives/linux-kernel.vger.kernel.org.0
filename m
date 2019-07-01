Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A638E52926
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 12:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfFYKMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 06:12:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727763AbfFYKMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:12:50 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9497020644;
        Tue, 25 Jun 2019 10:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561457569;
        bh=BccGv4rAyaS20N7ULXOIXSojeQUiRKMC5yb0GgHpenw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PwHE0qM6WpJ29nsXZ+hxtEv9CAAgJ2a+pQzJs/VJcWF+IonYcZ8AvVqF3Q50F6JrJ
         cvE+szA3JwIu3z7pcCX9Si2uRWKqWfusCMQDCR9Mhy4z0hQQ1CyV4eEGxykSZVj87b
         UzysuLk+r4aaeeKs1sbcsr83JqrihjX1WQHpnSyo=
Date:   Tue, 25 Jun 2019 11:12:45 +0100
From:   Will Deacon <will@kernel.org>
To:     Hoan Tran OS <hoan@os.amperecomputing.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Open Source Review <OpenSourceReview@amperecomputing.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: Kconfig: Enable NODES_SPAN_OTHER_NODES config for
 NUMA
Message-ID: <20190625101245.s4vxfosoop52gl4e@willie-the-truck>
References: <1561387098-23692-1-git-send-email-Hoan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561387098-23692-1-git-send-email-Hoan@os.amperecomputing.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 02:38:28PM +0000, Hoan Tran OS wrote:
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
> index 697ea05..21fc168 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -873,6 +873,13 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
>  config HOLES_IN_ZONE
>  	def_bool y
>  
> +# Some NUMA nodes have memory ranges that span other nodes.
> +# Even though a pfn is valid and between a node's start and end pfns,
> +# it may not reside on that node.
> +config NODES_SPAN_OTHER_NODES
> +	def_bool y
> +	depends on ACPI_NUMA

How come this is specific to ACPI?

It would be nice if this was the default, given that only ia64, mips and
sh appear to be the only NUMA-capable architectures which don't have it.
In other words, replace the #ifdef CONFIG_NODES_SPAN_OTHER_NODES in
mm/page_alloc.c with #ifdef CONFIG_NUMA.

Will
