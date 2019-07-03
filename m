Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7185E6B0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 16:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfGCO3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 10:29:34 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:52278 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbfGCO3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:29:32 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1higGH-0000jP-W1; Wed, 03 Jul 2019 22:29:30 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1higGH-0000Xy-Rv; Wed, 03 Jul 2019 22:29:29 +0800
Date:   Wed, 3 Jul 2019 22:29:29 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Lionel Debieve <lionel.debieve@st.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 0/2] crypto: stm32/hash: Fix bug in hmac mode
Message-ID: <20190703142929.one55xcdpoce2wdw@gondor.apana.org.au>
References: <20190628112655.9341-1-lionel.debieve@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628112655.9341-1-lionel.debieve@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 01:26:53PM +0200, Lionel Debieve wrote:
> This series fixes issues discovered while using libkcapi library. Some
> more tests show wrong key management in hmac mode. It is fixes by these 
> patches and prevent a potential issue in case of interrupt while processing
> in dma mode.
> 
> Lionel Debieve (2):
>   crypto: stm32/hash: Fix hmac issue more than 256 bytes
>   crypto: stm32/hash: remove interruptible condition for dma
> 
>  drivers/crypto/stm32/stm32-hash.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
