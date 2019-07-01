Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F799184D6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 07:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfEIF1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 01:27:35 -0400
Received: from [5.180.42.13] ([5.180.42.13]:53964 "EHLO deadmen.hmeau.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfEIF1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 01:27:35 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hOba7-0001EH-AS; Thu, 09 May 2019 13:26:59 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hObZx-0001bA-St; Thu, 09 May 2019 13:26:49 +0800
Date:   Thu, 9 May 2019 13:26:49 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Stephan Mueller <smueller@chronox.de>, mpm@selenic.com,
        robh+dt@kernel.org, mark.rutland@arm.com, matthias.bgg@gmail.com,
        wsd_upstream@mediatek.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, Crystal.Guo@mediatek.com
Subject: Re: [PATCH 3/3] hwrng: add mt67xx-rng driver
Message-ID: <20190509052649.xfkgb3qd7rhcgktj@gondor.apana.org.au>
References: <1557287937-2410-1-git-send-email-neal.liu@mediatek.com>
 <1557287937-2410-4-git-send-email-neal.liu@mediatek.com>
 <12193108.aNnqf5ydOJ@tauon.chronox.de>
 <1557311737.11818.11.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557311737.11818.11.camel@mtkswgap22>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 06:35:37PM +0800, Neal Liu wrote:
> Hi Stephan,
> 	We think the cast is fine, and it cannot guarantee the buf is
> word-align.
> 	I reference multiple rng driver's implementation and found it's common
> usage for this. So it might be general usage for community. Is there any
> suggestion that is more appropriate?

If you don't know whether it's unaligned or not then you should
do an unaligned operation.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
