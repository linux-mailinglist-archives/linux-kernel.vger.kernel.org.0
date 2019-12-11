Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34B8511A774
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 10:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfLKJiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 04:38:25 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:54320 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbfLKJiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:38:20 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ieyRn-00006H-Iu; Wed, 11 Dec 2019 17:38:19 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ieyRm-00050Y-Bl; Wed, 11 Dec 2019 17:38:18 +0800
Date:   Wed, 11 Dec 2019 17:38:18 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Alison Wang <alison.wang@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v3] crypto: caam - do not reset pointer size from MCFGR
 register
Message-ID: <20191211093818.tny64ctuqqxlznxq@gondor.apana.org.au>
References: <1574808866-16764-1-git-send-email-iuliana.prodan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1574808866-16764-1-git-send-email-iuliana.prodan@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 12:54:26AM +0200, Iuliana Prodan wrote:
> In commit 'a1cf573ee95 ("crypto: caam - select DMA address size at runtime")'
> CAAM pointer size (caam_ptr_size) is changed from
> sizeof(dma_addr_t) to runtime value computed from MCFGR register.
> Therefore, do not reset MCFGR[PS].
> 
> Fixes: a1cf573ee95 ("crypto: caam - select DMA address size at runtime")
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> Cc: <stable@vger.kernel.org>
> Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Alison Wang <alison.wang@nxp.com>
> Reviewed-by: Horia Geantă <horia.geanta@nxp.com>
> ---
> Changes since v2:
> - update description so the referred commit is not split on 2 lines;
> - added Reviewed-by.
> 
>  drivers/crypto/caam/ctrl.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
