Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59ED521FEB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 23:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbfEQVxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 17:53:09 -0400
Received: from foss.arm.com ([217.140.101.70]:48718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727239AbfEQVxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 17:53:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99A151715;
        Fri, 17 May 2019 14:53:08 -0700 (PDT)
Received: from mbp (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73CCD3F71E;
        Fri, 17 May 2019 14:53:07 -0700 (PDT)
Date:   Fri, 17 May 2019 22:53:04 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arch64: export __flush_dcache_area
Message-ID: <20190517215303.3daebi7o66we2cjh@mbp>
References: <20190517200012.136519-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517200012.136519-1-salyzyn@android.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 12:59:56PM -0700, Mark Salyzyn wrote:
> Some (out of tree modular) drivers feel a need to ensure
> data is flushed to the DDR before continuing flow.
> 
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: kernel-team@android.com
> ---
>  arch/arm64/mm/cache.S | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
> index a194fd0e837f..70d7cb5c0bd2 100644
> --- a/arch/arm64/mm/cache.S
> +++ b/arch/arm64/mm/cache.S
> @@ -120,6 +120,7 @@ ENTRY(__flush_dcache_area)
>  	dcache_by_line_op civac, sy, x0, x1, x2, x3
>  	ret
>  ENDPIPROC(__flush_dcache_area)
> +EXPORT_SYMBOL_GPL(__flush_dcache_area)
>  
>  /*
>   *	__clean_dcache_area_pou(kaddr, size)

NAK. Such drivers are doing something wrong, there is a dedicated
in-kernel API for that handles kernel maintenance (hint: DMA).

-- 
Catalin
