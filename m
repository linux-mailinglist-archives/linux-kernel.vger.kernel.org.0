Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49DF015BB80
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 10:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbgBMJTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 04:19:21 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:42266 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729596AbgBMJTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:19:20 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1j2AeT-00047w-L2; Thu, 13 Feb 2020 17:19:17 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1j2AeS-0006lu-VU; Thu, 13 Feb 2020 17:19:17 +0800
Date:   Thu, 13 Feb 2020 17:19:16 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] crypto: ccree - fixes
Message-ID: <20200213091916.c7qggk3ehbdxs2qe@gondor.apana.org.au>
References: <20200129143757.680-1-gilad@benyossef.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129143757.680-1-gilad@benyossef.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 04:37:53PM +0200, Gilad Ben-Yossef wrote:
> Fixes in AEAD DMA mapping code and blocksize reporting
> 
> Gilad Ben-Yossef (4):
>   crypto: ccree - protect against empty or NULL scatterlists
>   crypto: ccree - only try to map auth tag if needed
>   crypto: ccree - fix some reported cipher block sizes
>   crypto: ccree - fix AEAD blocksize registration
> 
>  drivers/crypto/ccree/cc_aead.c       |  1 +
>  drivers/crypto/ccree/cc_buffer_mgr.c | 68 +++++++++++++---------------
>  drivers/crypto/ccree/cc_buffer_mgr.h |  1 +
>  drivers/crypto/ccree/cc_cipher.c     |  8 +++-
>  4 files changed, 39 insertions(+), 39 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
