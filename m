Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEF87106E8B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 12:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731576AbfKVLJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 06:09:24 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:53888 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730318AbfKVLJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:09:21 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iY6oQ-00059i-N5; Fri, 22 Nov 2019 19:09:18 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iY6oN-0002it-ME; Fri, 22 Nov 2019 19:09:15 +0800
Date:   Fri, 22 Nov 2019 19:09:15 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 08/12] crypto: caam - support crypto_engine framework for
 SKCIPHER algorithms
Message-ID: <20191122110915.f7rsqb4hnsg4pfci@gondor.apana.org.au>
References: <1574029845-22796-1-git-send-email-iuliana.prodan@nxp.com>
 <1574029845-22796-9-git-send-email-iuliana.prodan@nxp.com>
 <20191122103309.wf2hg7km45ugzzhr@gondor.apana.org.au>
 <VI1PR04MB4445DACDF6F1AF1CDABC6E7A8C490@VI1PR04MB4445.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4445DACDF6F1AF1CDABC6E7A8C490@VI1PR04MB4445.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 11:05:59AM +0000, Iuliana Prodan wrote:
>
> Sorry, but I don't understand what is wrong here? I'm using the correct 
> type, the specific type, for the request when sending it to crypto engine.
> This transfer_request_to_engine function is called from caam_jr_enqueue, 
> where I have all types of request, so I'm using the async_request, and 
> when transferring to crypto engine I cast it to the specific type.

These internal types are only for use by the crypto API and helper
code such as crypto_engine.  They should not be used by drivers in
general.

> I believe is an overhead to sent all request to crypto engine since most 
> of them can be directly executed by hw.
> Also, in case there is no need for backlog and the hw is busy we can 
> drop the request.

If the crypto_engine has so much overhead then you should work on
fixing crypto_engine and not work around it like this.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
