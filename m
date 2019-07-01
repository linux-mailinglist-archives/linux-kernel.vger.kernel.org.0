Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E835A2FC89
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 15:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfE3NmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 09:42:18 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:38042 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfE3NmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 09:42:18 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hWLJq-0005bs-ME; Thu, 30 May 2019 21:42:10 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hWLJo-0003f3-NQ; Thu, 30 May 2019 21:42:08 +0800
Date:   Thu, 30 May 2019 21:42:08 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     "David S. Miller" <davem@davemloft.net>, horia.geanta@nxp.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 00/15] Fixing selftests failure on Talitos driver
Message-ID: <20190530134208.frpozzmqtafw35hy@gondor.apana.org.au>
References: <cover.1558445259.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1558445259.git.christophe.leroy@c-s.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 01:34:06PM +0000, Christophe Leroy wrote:
> Several test failures have popped up following recent changes to crypto
> selftests.
> 
> This series fixes (most of) them.
> 
> The last three patches are trivial cleanups.
> 
> Christophe Leroy (15):
>   crypto: talitos - fix skcipher failure due to wrong output IV
>   crypto: talitos - rename alternative AEAD algos.
>   crypto: talitos - reduce max key size for SEC1
>   crypto: talitos - check AES key size
>   crypto: talitos - fix CTR alg blocksize
>   crypto: talitos - check data blocksize in ablkcipher.
>   crypto: talitos - fix ECB algs ivsize
>   crypto: talitos - Do not modify req->cryptlen on decryption.
>   crypto: talitos - HMAC SNOOP NO AFEU mode requires SW icv checking.
>   crypto: talitos - properly handle split ICV.
>   crypto: talitos - Align SEC1 accesses to 32 bits boundaries.
>   crypto: talitos - fix AEAD processing.
>   Revert "crypto: talitos - export the talitos_submit function"
>   crypto: talitos - use IS_ENABLED() in has_ftr_sec1()
>   crypto: talitos - use SPDX-License-Identifier
> 
>  drivers/crypto/talitos.c | 281 ++++++++++++++++++++++-------------------------
>  drivers/crypto/talitos.h |  45 ++------
>  2 files changed, 139 insertions(+), 187 deletions(-)

Patch 1 was already applied.

2-15 applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
