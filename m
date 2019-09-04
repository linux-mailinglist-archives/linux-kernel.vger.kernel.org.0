Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D01BA804F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 12:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbfIDKZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 06:25:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfIDKZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 06:25:31 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C4A722CF7;
        Wed,  4 Sep 2019 10:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567592730;
        bh=rfWsnOUPgkutTE38JY/BCpgI9QMJXaEcBpUh9mBGwsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VMqQAXni5qiX64ISFemaPfm08bGAYIisiGAm1Op/Lgqtv52f794fdiTk35mxlsBIX
         YBG+ycqI8KGSLES0FLsHoHeUPZV1IzTIs5CXG/QiJY/59vjNXX8ojNlspWdii4g4ES
         ++Y2pyIbS+F9W6VxkCVuVFFMR1IihiT66addx53I=
Date:   Wed, 4 Sep 2019 11:25:26 +0100
From:   Will Deacon <will@kernel.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        catalin.marinas@arm.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] crypto: arm64: Use PTR_ERR_OR_ZERO rather than its
 implementation.
Message-ID: <20190904102526.5vtdv5ofuezn7fre@willie-the-truck>
References: <1567493656-19916-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567493656-19916-1-git-send-email-zhongjiang@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 02:54:16PM +0800, zhong jiang wrote:
> PTR_ERR_OR_ZERO contains if(IS_ERR(...)) + PTR_ERR. It is better to
> use it directly. hence just replace it.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  arch/arm64/crypto/aes-glue.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/crypto/aes-glue.c b/arch/arm64/crypto/aes-glue.c
> index ca0c84d..2a2e0a3 100644
> --- a/arch/arm64/crypto/aes-glue.c
> +++ b/arch/arm64/crypto/aes-glue.c
> @@ -409,10 +409,8 @@ static int essiv_cbc_init_tfm(struct crypto_skcipher *tfm)
>  	struct crypto_aes_essiv_cbc_ctx *ctx = crypto_skcipher_ctx(tfm);
>  
>  	ctx->hash = crypto_alloc_shash("sha256", 0, 0);
> -	if (IS_ERR(ctx->hash))
> -		return PTR_ERR(ctx->hash);
>  
> -	return 0;
> +	return PTR_ERR_OR_ZERO(ctx->hash);
>  }
>  
>  static void essiv_cbc_exit_tfm(struct crypto_skcipher *tfm)

Acked-by: Will Deacon <will@kernel.org>

Assuming this will go via Herbert.

Will
