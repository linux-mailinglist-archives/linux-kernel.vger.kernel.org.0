Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6AB818915E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 23:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgCQW23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 18:28:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgCQW23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 18:28:29 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E7B6206EC;
        Tue, 17 Mar 2020 22:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584484109;
        bh=fkwDszDySoCeKnopQtq7FmCT+AUuyAXm1e4W0arilAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AmaJdMHPXbhUkZXOLUarwbDBVLWG++cjrtPnJZZlBfIR3gXYn6imyhUvJNa8uYVQ6
         Z5HFUKLXhEBB/CPfXruZq30wp7WxPtr96VHKG7f1jADYLkzrwqOWfNWljc9vancoOG
         LnhvHZvKMD/rt1opKZUwjhz3clsoR8NmPpu/pZY4=
Date:   Tue, 17 Mar 2020 22:28:24 +0000
From:   Will Deacon <will@kernel.org>
To:     Zheng Wei <wei.zheng@vivo.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Enrico Weigelt <info@metux.net>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@vivo.com, wenhu.wang@vivo.com
Subject: Re: [PATCH] arm64: add blank after 'if'
Message-ID: <20200317222823.GG20788@willie-the-truck>
References: <20200313145403.6395-1-wei.zheng@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313145403.6395-1-wei.zheng@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 10:54:02PM +0800, Zheng Wei wrote:
> add blank after 'if' for armv8_deprecated_init()
> to make it comply with kernel coding style.
> 
> Signed-off-by: Zheng Wei <wei.zheng@vivo.com>
> ---
>  arch/arm64/kernel/armv8_deprecated.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
> index 7832b3216370..4cc581af2d96 100644
> --- a/arch/arm64/kernel/armv8_deprecated.c
> +++ b/arch/arm64/kernel/armv8_deprecated.c
> @@ -630,7 +630,7 @@ static int __init armv8_deprecated_init(void)
>  		register_insn_emulation(&cp15_barrier_ops);
>  
>  	if (IS_ENABLED(CONFIG_SETEND_EMULATION)) {
> -		if(system_supports_mixed_endian_el0())
> +		if (system_supports_mixed_endian_el0())
>  			register_insn_emulation(&setend_ops);
>  		else
>  			pr_info("setend instruction emulation is not supported on this system\n");

(Catalin: I'm just acking these trivial typo/style fixes to get them out
of my inbox; do whatever you like with them ;)

Acked-by: Will Deacon <will@kernel.org>

Will
