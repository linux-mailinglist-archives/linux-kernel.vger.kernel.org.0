Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 631676D0C3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 17:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390668AbfGRPLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 11:11:04 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:52928 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390241AbfGRPLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 11:11:04 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ho83i-0000i2-P0; Thu, 18 Jul 2019 23:11:02 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ho83h-0006eW-81; Thu, 18 Jul 2019 23:11:01 +0800
Date:   Thu, 18 Jul 2019 23:11:01 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] crypto: gcm - restrict assoclen for rfc4543
Message-ID: <20190718151101.hutxnd7u5nfrikx2@gondor.apana.org.au>
References: <1563460984-24593-1-git-send-email-iuliana.prodan@nxp.com>
 <20190718144647.bbsd65qabqpafehe@gondor.apana.org.au>
 <VI1PR04MB44451D12B66EE3FADA1ECE208CC80@VI1PR04MB4445.eurprd04.prod.outlook.com>
 <20190718145907.wercecqwr3wlny73@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718145907.wercecqwr3wlny73@gondor.apana.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 10:59:07PM +0800, Herbert Xu wrote:
> 
> So I presume the driver does enforce the limit.  Please actually
> state that in the commit description for future reference.

Also have you looked at whether other drivers would be affected
by this? It wouldn't be so nice if this change makes other drivers
fail the same test as a result.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
