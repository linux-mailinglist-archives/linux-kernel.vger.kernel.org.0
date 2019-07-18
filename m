Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F18D6D037
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 16:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391012AbfGROqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 10:46:52 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:51956 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfGROqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:46:52 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ho7gJ-00008U-20; Thu, 18 Jul 2019 22:46:51 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ho7gF-0006Hk-Mi; Thu, 18 Jul 2019 22:46:47 +0800
Date:   Thu, 18 Jul 2019 22:46:47 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] crypto: gcm - restrict assoclen for rfc4543
Message-ID: <20190718144647.bbsd65qabqpafehe@gondor.apana.org.au>
References: <1563460984-24593-1-git-send-email-iuliana.prodan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563460984-24593-1-git-send-email-iuliana.prodan@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 05:43:04PM +0300, Iuliana Prodan wrote:
> Based on seqiv, IPsec ESP and rfc4543/rfc4106 the assoclen can be 16 or
> 20 bytes.
> 
> >From esp4/esp6, assoclen is sizeof IP Header. This includes spi, seq_no
> and extended seq_no, that is 8 or 12 bytes.
> In seqiv, to asscolen is added the IV size (8 bytes).
> Therefore, the assoclen, for rfc4543, should be restricted to 16 or 20
> bytes, as for rfc4106.
> 
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>

Why does this matter? Is it for the fuzz test?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
