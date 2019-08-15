Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA79A8E44C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 07:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfHOFBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 01:01:25 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:57034 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfHOFBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 01:01:24 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hy7se-0004zi-KL; Thu, 15 Aug 2019 15:00:56 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hy7sY-0006Te-Id; Thu, 15 Aug 2019 15:00:50 +1000
Date:   Thu, 15 Aug 2019 15:00:50 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     atul.gupta@chelsio.com, zhongjiang@huawei.com,
        ganeshgr@chelsio.com, davem@davemloft.net, tglx@linutronix.de,
        bigeasy@linutronix.de, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] crypto: chtls - use 'skb_put_zero()' instead of
 re-implementing it
Message-ID: <20190815050050.GA24863@gondor.apana.org.au>
References: <20190807154014.22548-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807154014.22548-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 05:40:14PM +0200, Christophe JAILLET wrote:
> 'skb_put()+memset()' is equivalent to 'skb_put_zero()'
> Use the latter because it is less verbose and it hides the internals of the
> sk_buff structure.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/crypto/chelsio/chtls/chtls_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/chelsio/chtls/chtls_main.c b/drivers/crypto/chelsio/chtls/chtls_main.c
> index 635bb4b447fb..830b238da77e 100644
> --- a/drivers/crypto/chelsio/chtls/chtls_main.c
> +++ b/drivers/crypto/chelsio/chtls/chtls_main.c
> @@ -218,9 +218,8 @@ static int chtls_get_skb(struct chtls_dev *cdev)
>  	if (!cdev->askb)
>  		return -ENOMEM;
>  
> -	skb_put(cdev->askb, sizeof(struct tcphdr));
> +	skb_put_zero(cdev->askb, sizeof(struct tcphdr));
>  	skb_reset_transport_header(cdev->askb);
> -	memset(cdev->askb->data, 0, cdev->askb->len);

These two are NOT equivalent.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
