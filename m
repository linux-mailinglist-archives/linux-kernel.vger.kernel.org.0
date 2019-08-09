Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27A0A87223
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 08:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405666AbfHIGUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 02:20:00 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37456 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfHIGUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 02:20:00 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hvyFp-0007Or-B3; Fri, 09 Aug 2019 16:19:57 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hvyFo-0002rO-QA; Fri, 09 Aug 2019 16:19:56 +1000
Date:   Fri, 9 Aug 2019 16:19:56 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v5] crypto: gcm - restrict assoclen for rfc4543
Message-ID: <20190809061956.GO10392@gondor.apana.org.au>
References: <1564735653-7262-1-git-send-email-iuliana.prodan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564735653-7262-1-git-send-email-iuliana.prodan@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 11:47:33AM +0300, Iuliana Prodan wrote:
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
> Reviewed-by: Horia Geanta <horia.geanta@nxp.com>
> ---
> Changes since v4:
> - alignment.
> ---
>  crypto/gcm.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
