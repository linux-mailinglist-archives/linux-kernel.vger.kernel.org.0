Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1BD759275
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 06:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfF1ESz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 00:18:55 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:55894 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbfF1ESv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 00:18:51 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hgiLV-0004t8-PT; Fri, 28 Jun 2019 12:18:45 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hgiLT-00025E-UM; Fri, 28 Jun 2019 12:18:43 +0800
Date:   Fri, 28 Jun 2019 12:18:43 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     "David S. Miller" <davem@davemloft.net>, horia.geanta@nxp.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] crypto: talitos - eliminate unneeded 'done' functions at
 build time
Message-ID: <20190628041843.are3ywit6pek7upa@gondor.apana.org.au>
References: <2cb226d8a3e4876ff3d66c32aa4de9c0008b6cb8.1560805489.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cb226d8a3e4876ff3d66c32aa4de9c0008b6cb8.1560805489.git.christophe.leroy@c-s.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 09:14:45PM +0000, Christophe Leroy wrote:
> When building for SEC1 only, talitos2_done functions are unneeded
> and should go away.
> 
> For this, use has_ftr_sec1() which will always return true when only
> SEC1 support is being built, allowing GCC to drop TALITOS2 functions.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Horia Geantă <horia.geanta@nxp.com>
> ---
>  taken out of the "Additional fixes on Talitos driver" series as it can be applied independently
> 
>  drivers/crypto/talitos.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
