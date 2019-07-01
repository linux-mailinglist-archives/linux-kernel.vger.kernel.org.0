Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94A9E2FC6A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 15:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfE3Neh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 09:34:37 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37884 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfE3Neg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 09:34:36 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hWLCR-0005M3-PK; Thu, 30 May 2019 21:34:31 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hWLCN-0003Zp-B9; Thu, 30 May 2019 21:34:27 +0800
Date:   Thu, 30 May 2019 21:34:27 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Horia Geanta <horia.geanta@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] crypto: gcm - fix cacheline sharing
Message-ID: <20190530133427.qrwjzctac2x6nsby@gondor.apana.org.au>
References: <1559149856-7938-1-git-send-email-iuliana.prodan@nxp.com>
 <20190529202728.GA35103@gmail.com>
 <CAKv+Gu-4KqcY=WhwY98JigTzeXaL5ggYEcu7+kNzNtpO2FLQXg@mail.gmail.com>
 <VI1PR04MB44459EEF7BCD3458BB3D143D8C180@VI1PR04MB4445.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB44459EEF7BCD3458BB3D143D8C180@VI1PR04MB4445.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 01:29:41PM +0000, Iuliana Prodan wrote:
>
> I've tried coping the IV before the extended descriptor allocation, but 
> is not working and to make it work will need to make more changes in 
> CAAM. We need the original iv, and if we move it before 
> skcipher_edesc_alloc we lose it.
> The fix exclusively in CAAM drv, to copy iv before DMA map, is more complex.

Why doesn't it work (apart from the fact that this only makes sense
for CBC and yet you're doing it for everything including CTR)?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
