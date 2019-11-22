Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EED310712E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 12:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfKVKdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 05:33:21 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:51288 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfKVKdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:33:14 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iY6FT-0001nK-UT; Fri, 22 Nov 2019 18:33:11 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iY6FR-000578-8W; Fri, 22 Nov 2019 18:33:09 +0800
Date:   Fri, 22 Nov 2019 18:33:09 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 08/12] crypto: caam - support crypto_engine framework for
 SKCIPHER algorithms
Message-ID: <20191122103309.wf2hg7km45ugzzhr@gondor.apana.org.au>
References: <1574029845-22796-1-git-send-email-iuliana.prodan@nxp.com>
 <1574029845-22796-9-git-send-email-iuliana.prodan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574029845-22796-9-git-send-email-iuliana.prodan@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 12:30:41AM +0200, Iuliana Prodan wrote:
>
> +static int transfer_request_to_engine(struct crypto_engine *engine,
> +				      struct crypto_async_request *req)
> +{
> +	switch (crypto_tfm_alg_type(req->tfm)) {
> +	case CRYPTO_ALG_TYPE_SKCIPHER:
> +		return crypto_transfer_skcipher_request_to_engine(engine,
> +								  skcipher_request_cast(req));
> +	default:
> +		return -EINVAL;
> +	}
> +}

Please don't do this.  As you can see the crypto engine interface
wants to you to use the correct type for the request object.  That's
what you should do to.

In fact I don't understand why you're only using the crypto engine
for the backlog case.  Wouldn't it be much simpler if you used the
engine unconditionally?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
