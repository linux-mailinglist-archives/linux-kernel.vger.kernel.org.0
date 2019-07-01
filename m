Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B26DF331D4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 16:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbfFCOPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 10:15:48 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60672 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbfFCOPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:15:48 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hXnkK-0003TA-Vh; Mon, 03 Jun 2019 22:15:33 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hXnkC-0002q7-KC; Mon, 03 Jun 2019 22:15:24 +0800
Date:   Mon, 3 Jun 2019 22:15:24 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Harald Freudenberger <freude@linux.ibm.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-imx@nxp.com,
        festevam@gmail.com, kernel <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>, shawnguo@kernel.org,
        davem@davemloft.net, david <david@sigma-star.at>
Subject: Re: [RFC PATCH 1/2] crypto: Allow working with key references
Message-ID: <20190603141524.wmjmgre4qge7zqjh@gondor.apana.org.au>
References: <20190529224844.25203-1-richard@nod.at>
 <20190530023357.2mrjtslnka4i6dbl@gondor.apana.org.au>
 <2084969721.73871.1559201016164.JavaMail.zimbra@nod.at>
 <14ffcdf2-ed9f-be07-fde5-62dfb1fce4f9@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14ffcdf2-ed9f-be07-fde5-62dfb1fce4f9@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 09:59:53AM +0200, Harald Freudenberger wrote:
>
> The "p" in paes is because we call it "protected key aes". I think you are not limited
> to the "p". What Herbert tries to point out is that you may define your own
> cipher with an unique name and there you can handle your secure key references
> as you like. You may use the s390 paes implementation as a starting point.

Well we have one other driver that is also using the paes name
ccree so I think we should all use this name for hardware keys
with AES.  Only the driver name needs to be unique.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
