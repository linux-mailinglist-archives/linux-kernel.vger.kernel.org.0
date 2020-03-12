Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 180FC182769
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 04:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbgCLD0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 23:26:14 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:56914 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730913AbgCLD0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 23:26:14 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jCETp-0001y0-P7; Thu, 12 Mar 2020 14:25:54 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 12 Mar 2020 14:25:53 +1100
Date:   Thu, 12 Mar 2020 14:25:53 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Ripard <mripard@kernel.org>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v4 1/2] crypto: engine - support for parallel requests
Message-ID: <20200312032553.GB19920@gondor.apana.org.au>
References: <1583707893-23699-1-git-send-email-iuliana.prodan@nxp.com>
 <1583707893-23699-2-git-send-email-iuliana.prodan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583707893-23699-2-git-send-email-iuliana.prodan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 12:51:32AM +0200, Iuliana Prodan wrote:
>
>  	ret = enginectx->op.do_one_request(engine, async_req);
> -	if (ret) {
> -		dev_err(engine->dev, "Failed to do one request from queue: %d\n", ret);
> -		goto req_err;
> +	can_enq_more = ret;
> +	if (can_enq_more < 0) {
> +		dev_err(engine->dev, "Failed to do one request from queue: %d\n",
> +			ret);
> +		goto req_err_1;
> +	}

So this now includes the case of the hardware queue being full
and the request needs to be queued until space opens up again.
In this case, we should not do dev_err.  So you need to be able
to distinguish between the hardware queue being full vs. a real
fatal error on the request (e.g., out-of-memory or some hardware
failure).

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
