Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D65A2FC50
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 15:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfE3N0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 09:26:32 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37858 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbfE3N0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 09:26:32 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hWL4d-0005CI-N1; Thu, 30 May 2019 21:26:27 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hWL4Z-0003Xt-Fa; Thu, 30 May 2019 21:26:23 +0800
Date:   Thu, 30 May 2019 21:26:23 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Horia Geanta <horia.geanta@nxp.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] crypto: gcm - fix cacheline sharing
Message-ID: <20190530132623.4h3y2bymv4uvfnms@gondor.apana.org.au>
References: <1559149856-7938-1-git-send-email-iuliana.prodan@nxp.com>
 <20190529202728.GA35103@gmail.com>
 <20190530053421.keesqb54yu5w7hgk@gondor.apana.org.au>
 <VI1PR0402MB3485ADA3C4410D61191582A498180@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <CAKv+Gu84HndAnkn7DU=ykjCokw_+bAHEcF0Rm12-hnXhVy2u_Q@mail.gmail.com>
 <VI1PR0402MB34859577A96645E890BD8F3198180@VI1PR0402MB3485.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB34859577A96645E890BD8F3198180@VI1PR0402MB3485.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 01:18:34PM +0000, Horia Geanta wrote:
>
> I guess there are only two options:
> -either cache line sharing is avoided OR
> -users need to be *aware* they are sharing the cache line and some rules /
> assumptions are in place on how to safely work on the data

No there is a third option and it's very simple:

You must only access the virtual addresses given to you before DMA
mapping or after DMA unmapping.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
