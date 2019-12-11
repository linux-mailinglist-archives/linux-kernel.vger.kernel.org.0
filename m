Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2C811A7F4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 10:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfLKJpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 04:45:51 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:55434 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728409AbfLKJpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:45:50 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ieyYx-0000W7-Uo; Wed, 11 Dec 2019 17:45:44 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ieyYx-00035r-2s; Wed, 11 Dec 2019 17:45:43 +0800
Date:   Wed, 11 Dec 2019 17:45:43 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tudor.Ambarus@microchip.com
Cc:     Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/16] crypto: atmel - Fixes and cleanup patches
Message-ID: <20191211094542.keqzvpnq7eybvipe@gondor.apana.org.au>
References: <20191205095326.5094-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205095326.5094-1-tudor.ambarus@microchip.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 09:53:43AM +0000, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Fix AES CTR and other cleanup patches.
> 
> Tudor Ambarus (16):
>   crypto: atmel-tdes: Constify value to write to hw
>   crypto: atmel-{sha,tdes} - Change algorithm priorities
>   crypto: atmel-tdes - Remove unused header includes
>   crypto: atmel-{sha,tdes} - Propagate error from _hw_version_init()
>   crypto: atmel-{aes,sha,tdes} - Drop superfluous error message in
>     probe()
>   crypto: atmel-{aes,sha,tdes} - Rename labels in probe()
>   crypto: atmel-tdes - Remove useless write in Control Register
>   crypto: atmel-tdes - Map driver data flags to Mode Register
>   crypto: atmel-tdes - Drop unnecessary passing of tfm
>   crypto: atmel-{aes,tdes} - Do not save IV for ECB mode
>   crypto: atmel-aes - Fix counter overflow in CTR mode
>   crypto: atmel-aes - Fix saving of IV for CTR mode
>   crypto: atmel-{sha,tdes} - Remove unused 'err' member of driver data
>   crypto: atmel-sha - Void return type for atmel_sha_update_dma_stop()
>   crypto: atmel-aes - Use gcm helper to check authsize
>   crypto: atmel-{aes,sha,tdes} - Group common alg type init in dedicated
>     methods
> 
>  drivers/crypto/atmel-aes.c  | 227 ++++++++++++++-----------------------
>  drivers/crypto/atmel-sha.c  | 102 +++++++----------
>  drivers/crypto/atmel-tdes.c | 270 ++++++++++++++++++++------------------------
>  3 files changed, 247 insertions(+), 352 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
