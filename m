Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A788D19884
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 08:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfEJGkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 02:40:05 -0400
Received: from orcrist.hmeau.com ([5.180.42.13]:34110 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726940AbfEJGkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 02:40:05 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hOzBj-0001Lo-Ph; Fri, 10 May 2019 14:39:23 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hOzBb-0004u3-V0; Fri, 10 May 2019 14:39:16 +0800
Date:   Fri, 10 May 2019 14:39:15 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Stephan Mueller <smueller@chronox.de>, mpm@selenic.com,
        robh+dt@kernel.org, mark.rutland@arm.com, matthias.bgg@gmail.com,
        wsd_upstream@mediatek.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, Crystal.Guo@mediatek.com
Subject: Re: [PATCH 3/3] hwrng: add mt67xx-rng driver
Message-ID: <20190510063915.kwqy3e5urs6j7ity@gondor.apana.org.au>
References: <1557287937-2410-1-git-send-email-neal.liu@mediatek.com>
 <1557287937-2410-4-git-send-email-neal.liu@mediatek.com>
 <12193108.aNnqf5ydOJ@tauon.chronox.de>
 <1557311737.11818.11.camel@mtkswgap22>
 <20190509052649.xfkgb3qd7rhcgktj@gondor.apana.org.au>
 <1557413686.23445.6.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557413686.23445.6.camel@mtkswgap22>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 10:54:46PM +0800, Neal Liu wrote:
>
> Hi Stephan/Herbert,
> 	My mistake. This buffer is allocated by kmalloc with larger than 32
> bytes. So yes, it's word-align for sure.
> 	reference:
> https://elixir.bootlin.com/linux/latest/source/drivers/char/hw_random/core.c#L590

Yes you're right.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
