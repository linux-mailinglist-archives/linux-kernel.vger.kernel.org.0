Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC7D2106EA7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 12:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731314AbfKVLKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 06:10:31 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:53988 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729083AbfKVLKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:10:25 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iY6pP-0005Jx-Kx; Fri, 22 Nov 2019 19:10:19 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iY6pO-0002kH-Fr; Fri, 22 Nov 2019 19:10:18 +0800
Date:   Fri, 22 Nov 2019 19:10:18 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     davem@davemloft.net, mripard@kernel.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] crypto: allwinner: sun8i-ce: enable working on big endian
Message-ID: <20191122111018.uss7n573hdtmx6ed@gondor.apana.org.au>
References: <20191117160745.32197-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191117160745.32197-1-clabbe.montjoie@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2019 at 05:07:45PM +0100, Corentin Labbe wrote:
> On big endian kernel, the sun8i-ce crypto driver does not works.
> This patch do the necessary modification to permit it to work on BE
> kernel (setting descriptor entries as __le32 and adding some cpu_to_le32)
> 
> Fixes: 06f751b61329 ("crypto: allwinner - Add sun8i-ce Crypto Engine")
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  .../allwinner/sun8i-ce/sun8i-ce-cipher.c      | 50 +++++++++++--------
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h  | 24 ++++-----
>  2 files changed, 40 insertions(+), 34 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
