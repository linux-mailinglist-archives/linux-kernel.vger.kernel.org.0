Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 692DBCBF87
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 17:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389976AbfJDPna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 11:43:30 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42556 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389165AbfJDPn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:43:29 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iGPjT-0001Mn-Hx; Sat, 05 Oct 2019 01:43:04 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 05 Oct 2019 01:43:00 +1000
Date:   Sat, 5 Oct 2019 01:43:00 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Nagadheeraj Rottela <rnagadheeraj@marvell.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        Srikanth Jampala <jsrikanth@marvell.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: cavium/nitrox - Add mailbox message to get mcode
 info in VF
Message-ID: <20191004154300.GT5148@gondor.apana.org.au>
References: <20190918093901.6477-1-rnagadheeraj@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918093901.6477-1-rnagadheeraj@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 09:39:34AM +0000, Nagadheeraj Rottela wrote:
> Add support to get microcode information in VF from PF via mailbox
> message.
> 
> Signed-off-by: Nagadheeraj Rottela <rnagadheeraj@marvell.com>
> Reviewed-by: Srikanth Jampala <jsrikanth@marvell.com>
> ---
>  drivers/crypto/cavium/nitrox/nitrox_dev.h | 15 +++++++++++++++
>  drivers/crypto/cavium/nitrox/nitrox_mbx.c |  8 ++++++++
>  2 files changed, 23 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
