Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0853BCBF7D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 17:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbfJDPmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 11:42:12 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42510 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389921AbfJDPmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:42:12 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iGPhs-0001Gn-Ca; Sat, 05 Oct 2019 01:41:25 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 05 Oct 2019 01:41:24 +1000
Date:   Sat, 5 Oct 2019 01:41:24 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Nagadheeraj Rottela <rnagadheeraj@marvell.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        Srikanth Jampala <jsrikanth@marvell.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: cavium/nitrox - Fix cbc ciphers self test
 failures
Message-ID: <20191004154124.GN5148@gondor.apana.org.au>
References: <20190917063627.27472-1-rnagadheeraj@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917063627.27472-1-rnagadheeraj@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 06:36:50AM +0000, Nagadheeraj Rottela wrote:
> Self test failures are due to wrong output IV. This patch fixes this
> issue by copying back output IV into skcipher request.
> 
> Signed-off-by: Nagadheeraj Rottela <rnagadheeraj@marvell.com>
> Reviewed-by: Srikanth Jampala <jsrikanth@marvell.com>
> ---
>  drivers/crypto/cavium/nitrox/nitrox_req.h      |   4 +
>  drivers/crypto/cavium/nitrox/nitrox_skcipher.c | 133 ++++++++++++++++++-------
>  2 files changed, 103 insertions(+), 34 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
