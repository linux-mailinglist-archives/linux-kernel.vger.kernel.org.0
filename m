Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF29B145807
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 15:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgAVOlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 09:41:47 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:51026 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbgAVOlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 09:41:47 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iuHCO-0006X0-Uj; Wed, 22 Jan 2020 22:41:41 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iuHCI-0004MZ-O4; Wed, 22 Jan 2020 22:41:34 +0800
Date:   Wed, 22 Jan 2020 22:41:34 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Horia Geanta <horia.geanta@nxp.com>,
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
Subject: Re: [RFC PATCH] Crypto-engine support for parallel requests
Message-ID: <20200122144134.axqpwx65j7xysyy3@gondor.apana.org.au>
References: <1579563149-3678-1-git-send-email-iuliana.prodan@nxp.com>
 <20200121100053.GA14095@Red>
 <VI1PR04MB44454A0468073981FDA603B38C0D0@VI1PR04MB4445.eurprd04.prod.outlook.com>
 <20200122104134.GA13173@Red>
 <VI1PR04MB44455343230CBA7400D21C998C0C0@VI1PR04MB4445.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB44455343230CBA7400D21C998C0C0@VI1PR04MB4445.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 12:29:22PM +0000, Iuliana Prodan wrote:
>
> > do_one_request is a blocking operation on amlogic/sun8i-ce/sun8i-ss and the "documentation" is clear "@do_one_request: do encryption for current request".
> > But I agree that is a bit small for a documentation.
> > 
> 
> Herbert, Baolin,
> 
> What do you think about do_one_requet operation: is blocking or not?
> 
> There are several drivers (stm32, omap, virtio, caam) that include 
> crypto-engine, and uses do_one_request as non-blocking, only the ones 
> mentioned and implemented by Corentin use do_one_request as blocking.

It certainly shouldn't be blocking in the general case.  The only
time when it might make sense to block is if the hardware is
incapable of using IRQs to signal completion.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
