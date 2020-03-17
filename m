Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E96B6189158
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 23:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgCQW1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 18:27:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgCQW1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 18:27:01 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F310206EC;
        Tue, 17 Mar 2020 22:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584484021;
        bh=feXoVNdYfrV4TFKhykYHVASYD8nshaCB8LWcN1l/eP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OuSZmRfjKjT3bppoNPLTNL8hxyiP67j2pV1bJszZfFXsz6kepBPj0ffTfi3CAMdhX
         PT18tvPVppBBRLf9c8jRrZiCyLQShrtjUtDVfD3YSbrLvSbOX73h0e1ecdX6fk7g8Q
         jLcEb8O5V34blCKFSXRQG03gPImfHhSwjEX+lfPM=
Date:   Tue, 17 Mar 2020 22:26:56 +0000
From:   Will Deacon <will@kernel.org>
To:     =?iso-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com, kvmarm@lists.cs.columbia.edu,
        catalin.marinas@arm.com
Subject: Re: [PATCH] arm64: move kimage_vaddr to .rodata
Message-ID: <20200317222656.GE20788@willie-the-truck>
References: <20200312094002.153302-1-remi@remlab.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200312094002.153302-1-remi@remlab.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 11:40:02AM +0200, R�mi Denis-Courmont wrote:
> From: Remi Denis-Courmont <remi.denis.courmont@huawei.com>
> 
> This datum is not referenced from .idmap.text: it does not need to be
> mapped in idmap. Lets move it to .rodata as it is never written to after
> early boot of the primary CPU.
> (Maybe .data.ro_after_init would be cleaner though?)
> 
> Signed-off-by: R�mi Denis-Courmont <remi@remlab.net>
> ---
>  arch/arm64/kernel/head.S | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 6e08ee2b4d55..8e5c0e0040e4 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -457,17 +457,19 @@ SYM_FUNC_START_LOCAL(__primary_switched)
>  	b	start_kernel
>  SYM_FUNC_END(__primary_switched)
>  
> +	.pushsection ".rodata", "a"
> +SYM_DATA_START(kimage_vaddr)
> +	.quad		_text - TEXT_OFFSET
> +SYM_DATA_END(kimage_vaddr)
> +EXPORT_SYMBOL(kimage_vaddr)
> +	.popsection
> +
>  /*
>   * end early head section, begin head code that is also used for
>   * hotplug and needs to have the same protections as the text region
>   */
>  	.section ".idmap.text","awx"
>  
> -SYM_DATA_START(kimage_vaddr)
> -	.quad		_text - TEXT_OFFSET
> -SYM_DATA_END(kimage_vaddr)
> -EXPORT_SYMBOL(kimage_vaddr)

Acked-by: Will Deacon <will@kernel.org>

Will
