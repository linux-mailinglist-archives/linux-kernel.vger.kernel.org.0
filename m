Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2ED2F71C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 07:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfE3Fec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 01:34:32 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60942 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfE3Fec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 01:34:32 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hWDhr-0002Go-07; Thu, 30 May 2019 13:34:27 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hWDhl-0005JK-D2; Thu, 30 May 2019 13:34:21 +0800
Date:   Thu, 30 May 2019 13:34:21 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Iuliana Prodan <iuliana.prodan@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Horia Geanta <horia.geanta@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] crypto: gcm - fix cacheline sharing
Message-ID: <20190530053421.keesqb54yu5w7hgk@gondor.apana.org.au>
References: <1559149856-7938-1-git-send-email-iuliana.prodan@nxp.com>
 <20190529202728.GA35103@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529202728.GA35103@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 01:27:28PM -0700, Eric Biggers wrote:
>
> So what about the other places that also pass an IV located next to the data,
> like crypto/ccm.c and crypto/adiantum.c?  If we're actually going to make this a
> new API requirement, then we need to add a debugging option that makes the API
> detect this violation so that the other places can be fixed too.
> 
> Also, doing a kmalloc() per requset is inefficient and very error-prone.  In
> fact there are at least 3 bugs here: (1) not checking the return value, (2)
> incorrectly using GFP_KERNEL when it may be atomic context, and (3) not always
> freeing the memory.  Why not use cacheline-aligned memory within the request
> context, so that a separate kmalloc() isn't needed?
> 
> Also, did you consider whether there's any way to make the crypto API handle
> this automatically, so that all the individual users don't have to?

You're absolutely right Eric.

What I suggested in the old thread is non-sense.  While you can
force GCM to provide the right pointers you cannot force all the
other crypto API users to do this.

It would appear that Ard's latest suggestion should fix the problem
and is the correct approach.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
