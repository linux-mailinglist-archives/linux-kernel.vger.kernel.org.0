Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3BBD184D3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 07:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfEIFZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 01:25:38 -0400
Received: from [5.180.42.13] ([5.180.42.13]:53938 "EHLO deadmen.hmeau.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfEIFZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 01:25:38 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hObYk-0001DJ-Iq; Thu, 09 May 2019 13:25:34 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hObYj-0001ao-Cl; Thu, 09 May 2019 13:25:33 +0800
Date:   Thu, 9 May 2019 13:25:33 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] crypto: caam: fix caam_dump_sg that iterates through
 scatterlist
Message-ID: <20190509052533.rqodnozdaescixqz@gondor.apana.org.au>
References: <1557236223-31492-1-git-send-email-iuliana.prodan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557236223-31492-1-git-send-email-iuliana.prodan@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 04:37:03PM +0300, Iuliana Prodan wrote:
> Fix caam_dump_sg by correctly determining the next scatterlist
> entry in the list.
> 
> Fixes: 5ecf8ef9103c ("crypto: caam - fix sg dump")
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> ---
>  drivers/crypto/caam/error.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
