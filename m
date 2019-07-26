Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15C15765F9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 14:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfGZMgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 08:36:02 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:46542 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbfGZMgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 08:36:01 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hqzRy-00042T-46; Fri, 26 Jul 2019 22:35:54 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hqzRx-0002EN-Fm; Fri, 26 Jul 2019 22:35:53 +1000
Date:   Fri, 26 Jul 2019 22:35:53 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     davem@davemloft.net, gilad@benyossef.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH 1/2] crypto: ccree - check assoclen for rfc4543
Message-ID: <20190726123553.GA8568@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563520164-1153-1-git-send-email-iuliana.prodan@nxp.com>
Organization: Core
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Iuliana Prodan <iuliana.prodan@nxp.com> wrote:
> Check assoclen to solve the extra tests that expect -EINVAL to be
> returned when the associated data size is not valid.
> 
> Validated assoclen for RFC4543 which expects an assoclen
> of 16 or 20, the same as RFC4106.
> Based on seqiv, IPsec ESP and RFC4543/RFC4106 the assoclen is sizeof
> IP Header (spi, seq_no, extended seq_no) and IV len. This can be 16 or
> 20 bytes.
> 
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> ---
> drivers/crypto/ccree/cc_aead.c | 26 ++++++++++++++++++++------
> 1 file changed, 20 insertions(+), 6 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
