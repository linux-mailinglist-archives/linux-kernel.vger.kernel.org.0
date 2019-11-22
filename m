Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3A7106E9F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 12:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbfKVLKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 06:10:09 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:53960 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730107AbfKVLKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:10:07 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iY6ou-0005Dm-L0; Fri, 22 Nov 2019 19:09:48 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iY6os-0002jT-ES; Fri, 22 Nov 2019 19:09:46 +0800
Date:   Fri, 22 Nov 2019 19:09:46 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tudor.Ambarus@microchip.com
Cc:     Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] crypto: atmel-tdes - Set the IV after {en,de}crypt
Message-ID: <20191122110946.jwyfy2q7gabugcjc@gondor.apana.org.au>
References: <20191115134854.30190-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115134854.30190-1-tudor.ambarus@microchip.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 01:49:06PM +0000, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> The req->iv of the skcipher_request is expected to contain the
> last ciphertext block when the {en,de}crypt operation is done.
> In case of in-place decryption, copy the ciphertext in an
> intermediate buffer before decryption.
> 
> This fixes the following tcrypt tests:
> alg: skcipher: atmel-cbc-des encryption test failed (wrong output IV) on test vector 0, cfg="in-place"
> 00000000: fe dc ba 98 76 54 32 10
> alg: skcipher: atmel-cbc-tdes encryption test failed (wrong output IV) on test vector 0, cfg="in-place"
> 00000000: 7d 33 88 93 0f 93 b2 42
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/crypto/atmel-tdes.c | 40 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
