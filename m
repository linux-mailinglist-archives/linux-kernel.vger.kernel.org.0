Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE6FE4FFF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 17:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440663AbfJYPVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 11:21:16 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:35830 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440561AbfJYPVQ (ORCPT <rfc822;linux-kernel@vger.kernel.orG>);
        Fri, 25 Oct 2019 11:21:16 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iO1Oh-0001iE-Jm; Fri, 25 Oct 2019 23:21:03 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iO1Og-0007rP-9o; Fri, 25 Oct 2019 23:21:02 +0800
Date:   Fri, 25 Oct 2019 23:21:02 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: atmel - fix data types for __be{32,64}
Message-ID: <20191025152102.pfyokny5pbwxt4oz@gondor.apana.org.au>
References: <20191016122633.2220-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016122633.2220-1-ben.dooks@codethink.co.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 01:26:33PM +0100, Ben Dooks (Codethink) wrote:
> The driver uses a couple of buffers that seem to
> be __be32 or __be64 fields, but declares them as
> u32. This means there are a number of warnings
> from sparse due to casting to/from __beXXX.
> 
> Fix these by changing the types of the buffer
> and the associated variables.
> 
> drivers/crypto/atmel-aes.c:1023:15: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1023:15: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1023:15: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1023:15: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1023:15: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1023:15: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1059:28: warning: incorrect type in assignment (different base types)
> drivers/crypto/atmel-aes.c:1059:28:    expected unsigned int
> drivers/crypto/atmel-aes.c:1059:28:    got restricted __be32 [usertype]
> drivers/crypto/atmel-aes.c:1550:28: warning: incorrect type in assignment (different base types)
> drivers/crypto/atmel-aes.c:1550:28:    expected unsigned int
> drivers/crypto/atmel-aes.c:1550:28:    got restricted __be32 [usertype]
> drivers/crypto/atmel-aes.c:1561:39: warning: incorrect type in assignment (different base types)
> drivers/crypto/atmel-aes.c:1561:39:    expected unsigned long long [usertype]
> drivers/crypto/atmel-aes.c:1561:39:    got restricted __be64 [usertype]
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:17: warning: cast to restricted __be32
> drivers/crypto/atmel-aes.c:1599:15: warning: incorrect type in assignment (different base types)
> drivers/crypto/atmel-aes.c:1599:15:    expected unsigned int [usertype]
> drivers/crypto/atmel-aes.c:1599:15:    got restricted __be32 [usertype]
> drivers/crypto/atmel-aes.c:1692:17: warning: incorrect type in assignment (different base types)
> drivers/crypto/atmel-aes.c:1692:17:    expected unsigned long long [usertype]
> drivers/crypto/atmel-aes.c:1692:17:    got restricted __be64 [usertype]
> drivers/crypto/atmel-aes.c:1693:17: warning: incorrect type in assignment (different base types)
> drivers/crypto/atmel-aes.c:1693:17:    expected unsigned long long [usertype]
> drivers/crypto/atmel-aes.c:1693:17:    got restricted __be64 [usertype]
> drivers/crypto/atmel-aes.c:1888:63: warning: incorrect type in initializer (different base types)
> drivers/crypto/atmel-aes.c:1888:63:    expected unsigned int
> drivers/crypto/atmel-aes.c:1888:63:    got restricted __le32 [usertype]
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> .. (open list)
> ---
>  drivers/crypto/atmel-aes.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
