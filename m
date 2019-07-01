Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14CE74C8F0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 10:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbfFTIF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 04:05:56 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:43568 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfFTIFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 04:05:55 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hds4o-0002CJ-VD; Thu, 20 Jun 2019 16:05:46 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hds4k-0007C0-6f; Thu, 20 Jun 2019 16:05:42 +0800
Date:   Thu, 20 Jun 2019 16:05:42 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, stefan.wahren@i2se.com,
        wahrenst@gmx.net, linux-crypto@vger.kernel.org, mpm@selenic.com
Subject: Re: [PATCH 0/2] hwrng: Support for 7211 in iproc-rng200
Message-ID: <20190620080542.b5hrd2c5lxl7pejp@gondor.apana.org.au>
References: <20190510173112.2196-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510173112.2196-1-f.fainelli@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 10:31:09AM -0700, Florian Fainelli wrote:
> Hi Herbert,
> 
> This patch series adds support for BCM7211 to the iproc-rng200 driver,
> nothing special besides matching the compatibile string and updating the
> binding document.
> 
> Florian Fainelli (2):
>   dt-bindings: rng: Document BCM7211 RNG compatible string
>   hwrng: iproc-rng200: Add support for 7211
> 
>  Documentation/devicetree/bindings/rng/brcm,iproc-rng200.txt | 1 +
>  drivers/char/hw_random/iproc-rng200.c                       | 1 +
>  2 files changed, 2 insertions(+)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
