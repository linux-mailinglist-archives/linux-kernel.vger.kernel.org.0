Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDD7C139DDD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 01:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbgANAOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 19:14:44 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:43194 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728641AbgANAOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 19:14:44 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ir9r1-0002PU-1e; Tue, 14 Jan 2020 08:14:43 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ir9qy-0000s8-T9; Tue, 14 Jan 2020 08:14:40 +0800
Date:   Tue, 14 Jan 2020 08:14:40 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v2 09/10] crypto: caam - add crypto_engine support for
 RSA algorithms
Message-ID: <20200114001440.baeadihvlqiucw63@gondor.apana.org.au>
References: <1578013373-1956-1-git-send-email-iuliana.prodan@nxp.com>
 <1578013373-1956-10-git-send-email-iuliana.prodan@nxp.com>
 <VI1PR0402MB3485162217C242B16CF1371B98380@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <VI1PR04MB44452FF06F35075413CF87F88C350@VI1PR04MB4445.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB44452FF06F35075413CF87F88C350@VI1PR04MB4445.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 09:48:11AM +0000, Iuliana Prodan wrote:
>
> Regarding the transfer request to crypto-engine: if sending all requests 
> to crypto-engine, multibuffer tests, for non-backlogging requests fail 
> after only 10 requests, since crypto-engine queue has 10 entries.

That isn't right.  The crypto engine should never refuse to accept
a request unless the hardware queue is really full.  Perhaps the
crypto engine code needs to be fixed?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
