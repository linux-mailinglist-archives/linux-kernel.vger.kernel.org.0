Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6E1714AE34
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 03:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgA1Cki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 21:40:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbgA1Ckh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 21:40:37 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C84E72467B;
        Tue, 28 Jan 2020 02:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580179237;
        bh=dZ2krymrng/WapYZyVR/pAUhbO1Ue6lbwEVTkzgGK74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qigBGK8Gt1qX2A1b0b9jB6/oQ+jOLYfuh8gH3SjBo4za9mHAcGlmRlthmVQoe7HVl
         /4Qh30D8z6JUA5cQ3V/deZN35oWg7idIqZvSk6hhE35VcFWkBS4Nd8HwmBg/IH+O9z
         zt+1P7/+AZUKwf4GVfO3sYVap40pM4jUdK1czwPM=
Date:   Mon, 27 Jan 2020 18:40:35 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: testmgr - properly mark the end of scatterlist
Message-ID: <20200128024035.GD960@sol.localdomain>
References: <20200127123311.7137-1-gilad@benyossef.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127123311.7137-1-gilad@benyossef.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 02:33:11PM +0200, Gilad Ben-Yossef wrote:
> The inauthentic AEAD test were using a scatterlist which
> could have a mismarked end node.
> 
> Fixes: 49763fc6b1 ("crypto: testmgr - generate inauthentic AEAD test vectors")
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> 
> ---
>  crypto/testmgr.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/crypto/testmgr.c b/crypto/testmgr.c
> index 88f33c0efb23..6c432aecff97 100644
> --- a/crypto/testmgr.c
> +++ b/crypto/testmgr.c
> @@ -2225,6 +2225,8 @@ static void generate_aead_message(struct aead_request *req,
>  			generate_random_bytes((u8 *)vec->ptext, vec->plen);
>  			sg_set_buf(&src[i++], vec->ptext, vec->plen);
>  		}
> +		if (i)
> +			sg_mark_end(&src[(i-1)]);
>  		sg_init_one(&dst, vec->ctext, vec->alen + vec->clen);
>  		memcpy(iv, vec->iv, ivsize);
>  		aead_request_set_callback(req, 0, crypto_req_done, &wait);

As I responded in the other thread
(https://lkml.kernel.org/linux-crypto/20200128023455.GC960@sol.localdomain/),
I'm not sure this is really a bug.  There's a length passed along with the
scatterlist, and my understanding is that algorithms aren't supposed to look
beyond that length.  So the scatterlist end marker isn't really relevant.

- Eric
