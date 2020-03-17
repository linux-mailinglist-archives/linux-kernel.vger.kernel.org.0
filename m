Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCD118915F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 23:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgCQW2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 18:28:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgCQW2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 18:28:42 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B417206EC;
        Tue, 17 Mar 2020 22:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584484122;
        bh=nSKGWbY4Xs0O2GbOiu9elNNIPUWgp5PLlLYc0r4SxlU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZSdwp9LJOAm3ym1cTxWYVEucpwrEX3H/BIVsIAoIM2ZOtQzMenEAThYBt2+rBHGPb
         8inuycHItk/k2YHZd9WJdDBd4sT+mNR1u6DhmlITwlo156HlmMFoYJi35G2TzHWtx2
         +sHWD8ImmIC9OgXjY2ZZueruqlU87GQ6SVwhSibA=
Date:   Tue, 17 Mar 2020 22:28:37 +0000
From:   Will Deacon <will@kernel.org>
To:     Li Tao <tao.li@vivo.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        James Morse <james.morse@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wenhu.pku@gmail.com
Subject: Re: [PATCH] arm64: kexec_file: Fixed code style.
Message-ID: <20200317222836.GH20788@willie-the-truck>
References: <20200311073156.125251-1-tao.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311073156.125251-1-tao.li@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 03:31:55PM +0800, Li Tao wrote:
> Remove unnecessary blank.
> 
> Signed-off-by: Li Tao <tao.li@vivo.com>
> ---
>  arch/arm64/kernel/machine_kexec_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index dd3ae80..b40c3b0 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -121,7 +121,7 @@ static int setup_dtb(struct kimage *image,
>  
>  	/* add kaslr-seed */
>  	ret = fdt_delprop(dtb, off, FDT_PROP_KASLR_SEED);
> -	if  (ret == -FDT_ERR_NOTFOUND)
> +	if (ret == -FDT_ERR_NOTFOUND)
>  		ret = 0;
>  	else if (ret)
>  		goto out;

Acked-by: Will Deacon <will@kernel.org>

Will
