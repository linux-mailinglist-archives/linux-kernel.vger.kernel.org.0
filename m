Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39BCF118774
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 12:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfLJL4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 06:56:51 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49605 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbfLJL4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 06:56:50 -0500
Received: from erbse.hi.pengutronix.de ([2001:67c:670:100:9e5c:8eff:fece:cdfe])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <bst@pengutronix.de>)
        id 1iee8H-00015P-CO; Tue, 10 Dec 2019 12:56:49 +0100
Subject: Re: [PATCH 06/12] crypto: caam - change return code in
 caam_jr_enqueue function
To:     Iuliana Prodan <iuliana.prodan@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx <linux-imx@nxp.com>,
        kernel@pengutronix.de
References: <1574029845-22796-1-git-send-email-iuliana.prodan@nxp.com>
 <1574029845-22796-7-git-send-email-iuliana.prodan@nxp.com>
From:   Bastian Krause <bst@pengutronix.de>
Message-ID: <705afee0-155b-2b6f-3b57-615a07fb7e4f@pengutronix.de>
Date:   Tue, 10 Dec 2019 12:56:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1574029845-22796-7-git-send-email-iuliana.prodan@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:9e5c:8eff:fece:cdfe
X-SA-Exim-Mail-From: bst@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/17/19 11:30 PM, Iuliana Prodan wrote:
> Change the return code of caam_jr_enqueue function to -EINPROGRESS, in
> case of success, -ENOSPC in case the CAAM is busy (has no space left
> in job ring queue), -EIO if it cannot map the caller's descriptor.
> 
> Update, also, the cases for resource-freeing for each algorithm type.
> 
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> Reviewed-by: Horia Geantă <horia.geanta@nxp.com>
> ---
>  drivers/crypto/caam/caamalg.c  | 16 ++++------------
>  drivers/crypto/caam/caamhash.c | 34 +++++++++++-----------------------
>  drivers/crypto/caam/caampkc.c  | 16 ++++++++--------
>  drivers/crypto/caam/caamrng.c  |  4 ++--
>  drivers/crypto/caam/jr.c       |  8 ++++----
>  drivers/crypto/caam/key_gen.c  |  2 +-
>  6 files changed, 30 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
> index 6e021692..21b6172 100644
> --- a/drivers/crypto/caam/caamalg.c
> +++ b/drivers/crypto/caam/caamalg.c
> @@ -1417,9 +1417,7 @@ static inline int chachapoly_crypt(struct aead_request *req, bool encrypt)
>  			     1);
>  
>  	ret = caam_jr_enqueue(jrdev, desc, aead_crypt_done, req);
> -	if (!ret) {
> -		ret = -EINPROGRESS;
> -	} else {
> +	if (ret != -EINPROGRESS) {
>  		aead_unmap(jrdev, edesc, req);
>  		kfree(edesc);
>  	}
> @@ -1462,9 +1460,7 @@ static inline int aead_crypt(struct aead_request *req, bool encrypt)
>  
>  	desc = edesc->hw_desc;
>  	ret = caam_jr_enqueue(jrdev, desc, aead_crypt_done, req);
> -	if (!ret) {
> -		ret = -EINPROGRESS;
> -	} else {
> +	if (ret != -EINPROGRESS) {
>  		aead_unmap(jrdev, edesc, req);
>  		kfree(edesc);
>  	}
> @@ -1507,9 +1503,7 @@ static inline int gcm_crypt(struct aead_request *req, bool encrypt)
>  
>  	desc = edesc->hw_desc;
>  	ret = caam_jr_enqueue(jrdev, desc, aead_crypt_done, req);
> -	if (!ret) {
> -		ret = -EINPROGRESS;
> -	} else {
> +	if (ret != -EINPROGRESS) {
>  		aead_unmap(jrdev, edesc, req);
>  		kfree(edesc);
>  	}
> @@ -1725,9 +1719,7 @@ static inline int skcipher_crypt(struct skcipher_request *req, bool encrypt)
>  	desc = edesc->hw_desc;
>  	ret = caam_jr_enqueue(jrdev, desc, skcipher_crypt_done, req);
>  
> -	if (!ret) {
> -		ret = -EINPROGRESS;
> -	} else {
> +	if (ret != -EINPROGRESS) {
>  		skcipher_unmap(jrdev, edesc, req);
>  		kfree(edesc);
>  	}
> diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
> index 5f9f16c..baf4ab1 100644
> --- a/drivers/crypto/caam/caamhash.c
> +++ b/drivers/crypto/caam/caamhash.c
> @@ -422,7 +422,7 @@ static int hash_digest_key(struct caam_hash_ctx *ctx, u32 *keylen, u8 *key,
>  	init_completion(&result.completion);
>  
>  	ret = caam_jr_enqueue(jrdev, desc, split_key_done, &result);
> -	if (!ret) {
> +	if (ret == -EINPROGRESS) {
>  		/* in progress */
>  		wait_for_completion(&result.completion);
>  		ret = result.err;
> @@ -858,10 +858,8 @@ static int ahash_update_ctx(struct ahash_request *req)
>  				     desc_bytes(desc), 1);
>  
>  		ret = caam_jr_enqueue(jrdev, desc, ahash_done_bi, req);
> -		if (ret)
> +		if (ret != -EINPROGRESS)
>  			goto unmap_ctx;
> -
> -		ret = -EINPROGRESS;
>  	} else if (*next_buflen) {
>  		scatterwalk_map_and_copy(buf + *buflen, req->src, 0,
>  					 req->nbytes, 0);
> @@ -936,10 +934,9 @@ static int ahash_final_ctx(struct ahash_request *req)
>  			     1);
>  
>  	ret = caam_jr_enqueue(jrdev, desc, ahash_done_ctx_src, req);
> -	if (ret)
> -		goto unmap_ctx;
> +	if (ret == -EINPROGRESS)
> +		return ret;
>  
> -	return -EINPROGRESS;
>   unmap_ctx:
>  	ahash_unmap_ctx(jrdev, edesc, req, digestsize, DMA_BIDIRECTIONAL);
>  	kfree(edesc);
> @@ -1013,10 +1010,9 @@ static int ahash_finup_ctx(struct ahash_request *req)
>  			     1);
>  
>  	ret = caam_jr_enqueue(jrdev, desc, ahash_done_ctx_src, req);
> -	if (ret)
> -		goto unmap_ctx;
> +	if (ret == -EINPROGRESS)
> +		return ret;
>  
> -	return -EINPROGRESS;
>   unmap_ctx:
>  	ahash_unmap_ctx(jrdev, edesc, req, digestsize, DMA_BIDIRECTIONAL);
>  	kfree(edesc);
> @@ -1086,9 +1082,7 @@ static int ahash_digest(struct ahash_request *req)
>  			     1);
>  
>  	ret = caam_jr_enqueue(jrdev, desc, ahash_done, req);
> -	if (!ret) {
> -		ret = -EINPROGRESS;
> -	} else {
> +	if (ret != -EINPROGRESS) {
>  		ahash_unmap_ctx(jrdev, edesc, req, digestsize, DMA_FROM_DEVICE);
>  		kfree(edesc);
>  	}
> @@ -1138,9 +1132,7 @@ static int ahash_final_no_ctx(struct ahash_request *req)
>  			     1);
>  
>  	ret = caam_jr_enqueue(jrdev, desc, ahash_done, req);
> -	if (!ret) {
> -		ret = -EINPROGRESS;
> -	} else {
> +	if (ret != -EINPROGRESS) {
>  		ahash_unmap_ctx(jrdev, edesc, req, digestsize, DMA_FROM_DEVICE);
>  		kfree(edesc);
>  	}
> @@ -1258,10 +1250,9 @@ static int ahash_update_no_ctx(struct ahash_request *req)
>  				     desc_bytes(desc), 1);
>  
>  		ret = caam_jr_enqueue(jrdev, desc, ahash_done_ctx_dst, req);
> -		if (ret)
> +		if (ret != -EINPROGRESS)
>  			goto unmap_ctx;
>  
> -		ret = -EINPROGRESS;
>  		state->update = ahash_update_ctx;
>  		state->finup = ahash_finup_ctx;
>  		state->final = ahash_final_ctx;
> @@ -1353,9 +1344,7 @@ static int ahash_finup_no_ctx(struct ahash_request *req)
>  			     1);
>  
>  	ret = caam_jr_enqueue(jrdev, desc, ahash_done, req);
> -	if (!ret) {
> -		ret = -EINPROGRESS;
> -	} else {
> +	if (ret != -EINPROGRESS) {
>  		ahash_unmap_ctx(jrdev, edesc, req, digestsize, DMA_FROM_DEVICE);
>  		kfree(edesc);
>  	}
> @@ -1452,10 +1441,9 @@ static int ahash_update_first(struct ahash_request *req)
>  				     desc_bytes(desc), 1);
>  
>  		ret = caam_jr_enqueue(jrdev, desc, ahash_done_ctx_dst, req);
> -		if (ret)
> +		if (ret != -EINPROGRESS)
>  			goto unmap_ctx;
>  
> -		ret = -EINPROGRESS;
>  		state->update = ahash_update_ctx;
>  		state->finup = ahash_finup_ctx;
>  		state->final = ahash_final_ctx;
> diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.c
> index ebf1677..7f7ea32 100644
> --- a/drivers/crypto/caam/caampkc.c
> +++ b/drivers/crypto/caam/caampkc.c
> @@ -634,8 +634,8 @@ static int caam_rsa_enc(struct akcipher_request *req)
>  	init_rsa_pub_desc(edesc->hw_desc, &edesc->pdb.pub);
>  
>  	ret = caam_jr_enqueue(jrdev, edesc->hw_desc, rsa_pub_done, req);
> -	if (!ret)
> -		return -EINPROGRESS;
> +	if (ret == -EINPROGRESS)
> +		return ret;
>  
>  	rsa_pub_unmap(jrdev, edesc, req);
>  
> @@ -667,8 +667,8 @@ static int caam_rsa_dec_priv_f1(struct akcipher_request *req)
>  	init_rsa_priv_f1_desc(edesc->hw_desc, &edesc->pdb.priv_f1);
>  
>  	ret = caam_jr_enqueue(jrdev, edesc->hw_desc, rsa_priv_f_done, req);
> -	if (!ret)
> -		return -EINPROGRESS;
> +	if (ret == -EINPROGRESS)
> +		return ret;
>  
>  	rsa_priv_f1_unmap(jrdev, edesc, req);
>  
> @@ -700,8 +700,8 @@ static int caam_rsa_dec_priv_f2(struct akcipher_request *req)
>  	init_rsa_priv_f2_desc(edesc->hw_desc, &edesc->pdb.priv_f2);
>  
>  	ret = caam_jr_enqueue(jrdev, edesc->hw_desc, rsa_priv_f_done, req);
> -	if (!ret)
> -		return -EINPROGRESS;
> +	if (ret == -EINPROGRESS)
> +		return ret;
>  
>  	rsa_priv_f2_unmap(jrdev, edesc, req);
>  
> @@ -733,8 +733,8 @@ static int caam_rsa_dec_priv_f3(struct akcipher_request *req)
>  	init_rsa_priv_f3_desc(edesc->hw_desc, &edesc->pdb.priv_f3);
>  
>  	ret = caam_jr_enqueue(jrdev, edesc->hw_desc, rsa_priv_f_done, req);
> -	if (!ret)
> -		return -EINPROGRESS;
> +	if (ret == -EINPROGRESS)
> +		return ret;
>  
>  	rsa_priv_f3_unmap(jrdev, edesc, req);
>  
> diff --git a/drivers/crypto/caam/caamrng.c b/drivers/crypto/caam/caamrng.c
> index e8baaca..e3e4bf2 100644
> --- a/drivers/crypto/caam/caamrng.c
> +++ b/drivers/crypto/caam/caamrng.c
> @@ -133,7 +133,7 @@ static inline int submit_job(struct caam_rng_ctx *ctx, int to_current)
>  	dev_dbg(jrdev, "submitting job %d\n", !(to_current ^ ctx->current_buf));
>  	init_completion(&bd->filled);
>  	err = caam_jr_enqueue(jrdev, desc, rng_done, ctx);
> -	if (err)
> +	if (err != EINPROGRESS)

Shouldn't this be -EINPROGRESS ?

>  		complete(&bd->filled); /* don't wait on failed job*/
>  	else
>  		atomic_inc(&bd->empty); /* note if pending */
> @@ -153,7 +153,7 @@ static int caam_read(struct hwrng *rng, void *data, size_t max, bool wait)
>  		if (atomic_read(&bd->empty) == BUF_EMPTY) {
>  			err = submit_job(ctx, 1);
>  			/* if can't submit job, can't even wait */
> -			if (err)
> +			if (err != EINPROGRESS)

And here the same?

Regards,
Bastian

>  				return 0;
>  		}
>  		/* no immediate data, so exit if not waiting */
> diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
> index fc97cde..df2a050 100644
> --- a/drivers/crypto/caam/jr.c
> +++ b/drivers/crypto/caam/jr.c
> @@ -324,8 +324,8 @@ void caam_jr_free(struct device *rdev)
>  EXPORT_SYMBOL(caam_jr_free);
>  
>  /**
> - * caam_jr_enqueue() - Enqueue a job descriptor head. Returns 0 if OK,
> - * -EBUSY if the queue is full, -EIO if it cannot map the caller's
> + * caam_jr_enqueue() - Enqueue a job descriptor head. Returns -EINPROGRESS
> + * if OK, -ENOSPC if the queue is full, -EIO if it cannot map the caller's
>   * descriptor.
>   * @dev:  device of the job ring to be used. This device should have
>   *        been assigned prior by caam_jr_register().
> @@ -377,7 +377,7 @@ int caam_jr_enqueue(struct device *dev, u32 *desc,
>  	    CIRC_SPACE(head, tail, JOBR_DEPTH) <= 0) {
>  		spin_unlock_bh(&jrp->inplock);
>  		dma_unmap_single(dev, desc_dma, desc_size, DMA_TO_DEVICE);
> -		return -EBUSY;
> +		return -ENOSPC;
>  	}
>  
>  	head_entry = &jrp->entinfo[head];
> @@ -414,7 +414,7 @@ int caam_jr_enqueue(struct device *dev, u32 *desc,
>  
>  	spin_unlock_bh(&jrp->inplock);
>  
> -	return 0;
> +	return -EINPROGRESS;
>  }
>  EXPORT_SYMBOL(caam_jr_enqueue);
>  
> diff --git a/drivers/crypto/caam/key_gen.c b/drivers/crypto/caam/key_gen.c
> index 5a851dd..b0e8a49 100644
> --- a/drivers/crypto/caam/key_gen.c
> +++ b/drivers/crypto/caam/key_gen.c
> @@ -108,7 +108,7 @@ int gen_split_key(struct device *jrdev, u8 *key_out,
>  	init_completion(&result.completion);
>  
>  	ret = caam_jr_enqueue(jrdev, desc, split_key_done, &result);
> -	if (!ret) {
> +	if (ret == -EINPROGRESS) {
>  		/* in progress */
>  		wait_for_completion(&result.completion);
>  		ret = result.err;
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
