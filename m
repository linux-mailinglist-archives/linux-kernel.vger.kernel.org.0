Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A71FE12EFC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 15:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfECNZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 09:25:57 -0400
Received: from [5.180.42.13] ([5.180.42.13]:38092 "EHLO deadmen.hmeau.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1727920AbfECNZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 09:25:56 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hMRNr-0005mF-Ha; Fri, 03 May 2019 14:09:23 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hMRNn-0003DW-W8; Fri, 03 May 2019 14:09:20 +0800
Date:   Fri, 3 May 2019 14:09:19 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Lionel Debieve <lionel.debieve@st.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/3] crypto: stm32/cryp - add weak key check for DES
Message-ID: <20190503060919.xkh4c4dupbz6tok6@gondor.apana.org.au>
References: <1556112893-13116-1-git-send-email-lionel.debieve@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556112893-13116-1-git-send-email-lionel.debieve@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 03:34:51PM +0200, Lionel Debieve wrote:
> Add weak key test for des functions calling the generic
> des_ekey.
> 
> Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
> ---
>  drivers/crypto/stm32/Kconfig      |  1 +
>  drivers/crypto/stm32/stm32-cryp.c | 13 +++++++++++--
>  2 files changed, 12 insertions(+), 2 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
