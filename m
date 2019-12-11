Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5555711A75E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 10:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfLKJhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 04:37:07 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:54224 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727493AbfLKJhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:37:05 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ieyQR-0008Qx-Cx; Wed, 11 Dec 2019 17:36:55 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ieyQP-0003bR-2n; Wed, 11 Dec 2019 17:36:53 +0800
Date:   Wed, 11 Dec 2019 17:36:53 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     davem@davemloft.net, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        vkoul@kernel.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] crypto: atmel - Retire
 dma_request_slave_channel_compat()
Message-ID: <20191211093652.a53uljmw6kns6l4a@gondor.apana.org.au>
References: <20191121101602.21941-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121101602.21941-1-peter.ujfalusi@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 12:15:59PM +0200, Peter Ujfalusi wrote:
> Hi,
> 
> Changes since v1:
> - Rebased on next-20191121 to avoid conflict for atmel-aes
> 
> I'm going through the kernel to crack down on dma_request_slave_channel_compat()
> users.
> 
> These drivers no longer needs it as they are only probed via DT and even if they
> would probe in legacy mode, the dma_request_chan() + dma_slave_map must be used
> for supporting non DT boots.
> 
> I have only compile tested the drivers!
> 
> Regards,
> Peter
> ---
> Peter Ujfalusi (3):
>   crypto: atmel-aes - Retire dma_request_slave_channel_compat()
>   crypto: atmel-sha - Retire dma_request_slave_channel_compat()
>   crypto: atmel-tdes - Retire dma_request_slave_channel_compat()
> 
>  drivers/crypto/atmel-aes.c  | 50 ++++++++-----------------------------
>  drivers/crypto/atmel-sha.c  | 39 ++++++-----------------------
>  drivers/crypto/atmel-tdes.c | 47 ++++++++++------------------------
>  3 files changed, 30 insertions(+), 106 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
