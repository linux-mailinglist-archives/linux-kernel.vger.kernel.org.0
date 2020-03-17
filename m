Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE68418781E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 04:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgCQDXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 23:23:07 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:38864 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbgCQDXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 23:23:07 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jE2oW-0007Oi-Rq; Tue, 17 Mar 2020 14:22:45 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 17 Mar 2020 14:22:44 +1100
Date:   Tue, 17 Mar 2020 14:22:44 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Iuliana Prodan <iuliana.prodan@nxp.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Ripard <mripard@kernel.org>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v4 1/2] crypto: engine - support for parallel requests
Message-ID: <20200317032244.GA18743@gondor.apana.org.au>
References: <1583707893-23699-1-git-send-email-iuliana.prodan@nxp.com>
 <1583707893-23699-2-git-send-email-iuliana.prodan@nxp.com>
 <20200312032553.GB19920@gondor.apana.org.au>
 <61c28d90-af55-25a1-3729-90a622f2a7b2@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61c28d90-af55-25a1-3729-90a622f2a7b2@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 01:05:32PM +0200, Horia Geantă wrote:
> On 3/12/2020 5:26 AM, Herbert Xu wrote:
> > On Mon, Mar 09, 2020 at 12:51:32AM +0200, Iuliana Prodan wrote:
> >>
> >>  	ret = enginectx->op.do_one_request(engine, async_req);
> >> -	if (ret) {
> >> -		dev_err(engine->dev, "Failed to do one request from queue: %d\n", ret);
> >> -		goto req_err;
> >> +	can_enq_more = ret;
> >> +	if (can_enq_more < 0) {
> >> +		dev_err(engine->dev, "Failed to do one request from queue: %d\n",
> >> +			ret);
> >> +		goto req_err_1;
> >> +	}
> > 
> > So this now includes the case of the hardware queue being full
> > and the request needs to be queued until space opens up again.
> I see no difference when compared with existing implementation:
> in both cases failing the transfer from SW queue to HW queue means
> losing the request irrespective of the error code returned by .do_one_request.
> 
> This doesn't mean it shouldn't be fixed.

I don't think they are the same though.  With the existing code,
you only ever have one outstanding request so a new one is only
given over to the hardware after the previous one has completed.
That means that the only errors you expect to get from the driver
are fatal ones that you cannot recover from.

With parallel requests, you will be giving as many requests to
the driver as it can take.  In fact the error condition is now
used to tell the engine to stop giving more requests.  This is
in no way the same as a fatal error from before.

We should not print out an error in this case and we should ensure
that the request is put back on the queue and reprocessed when the
driver comes back for more.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
