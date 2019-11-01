Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2341DEBD9D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 07:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbfKAGI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 02:08:57 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37602 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfKAGI5 (ORCPT <rfc822;linux-kernel@vger.kernel.orG>);
        Fri, 1 Nov 2019 02:08:57 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iQQ77-0001vr-6n; Fri, 01 Nov 2019 14:08:49 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iQQ74-0004rF-QU; Fri, 01 Nov 2019 14:08:46 +0800
Date:   Fri, 1 Nov 2019 14:08:46 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Colin King <colin.king@canonical.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vic Wu <vic.wu@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: mediatek: remove redundant bitwise-or
Message-ID: <20191101060846.3yzkupv7dbkecey4@gondor.apana.org.au>
References: <20191023114824.30509-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023114824.30509-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 12:48:24PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Bitwise-or'ing 0xffffffff with the u32 variable ctr is the same result
> as assigning the value to ctr.  Remove the redundant bitwise-or and
> just use an assignment.
> 
> Addresses-Coverity: ("Suspicious &= or |= constant expression")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/crypto/mediatek/mtk-aes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
