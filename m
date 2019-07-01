Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6E921392
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 08:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfEQGAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 02:00:15 -0400
Received: from [128.1.224.119] ([128.1.224.119]:54042 "EHLO deadmen.hmeau.com"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727242AbfEQGAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 02:00:15 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hRVuf-0007s2-In; Fri, 17 May 2019 14:00:13 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hRVua-0000Y1-Ne; Fri, 17 May 2019 14:00:08 +0800
Date:   Fri, 17 May 2019 14:00:08 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] crypto: caam - fix typo in i.MX6 devices list for errata
Message-ID: <20190517060008.pcjwjlsiscmjtlht@gondor.apana.org.au>
References: <1557853989-29075-1-git-send-email-iuliana.prodan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557853989-29075-1-git-send-email-iuliana.prodan@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 08:13:09PM +0300, Iuliana Prodan wrote:
> Fix a typo in the list of i.MX6 devices affected by an
> issue wherein AXI bus transactions may not occur in
> the correct order.
> 
> Fixes: 33d69455e402 ("crypto: caam - limit AXI pipeline to a depth of
> 1")
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> ---
>  drivers/crypto/caam/ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
