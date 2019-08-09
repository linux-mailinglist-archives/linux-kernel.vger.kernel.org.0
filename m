Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0F3D87215
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 08:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405606AbfHIGSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 02:18:14 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37388 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfHIGSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 02:18:14 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hvyDk-0007Fo-KP; Fri, 09 Aug 2019 16:17:48 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hvyDk-0002ne-CN; Fri, 09 Aug 2019 16:17:48 +1000
Date:   Fri, 9 Aug 2019 16:17:48 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v6 05/57] crypto: Remove dev_err() usage after
 platform_get_irq()
Message-ID: <20190809061748.GH10392@gondor.apana.org.au>
References: <20190730181557.90391-1-swboyd@chromium.org>
 <20190730181557.90391-6-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730181557.90391-6-swboyd@chromium.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 11:15:05AM -0700, Stephen Boyd wrote:
> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.
> 
> // <smpl>
> @@
> expression ret;
> struct platform_device *E;
> @@
> 
> ret =
> (
> platform_get_irq(E, ...)
> |
> platform_get_irq_byname(E, ...)
> );
> 
> if ( \( ret < 0 \| ret <= 0 \) )
> {
> (
> -if (ret != -EPROBE_DEFER)
> -{ ...
> -dev_err(...);
> -... }
> |
> ...
> -dev_err(...);
> )
> ...
> }
> // </smpl>
> 
> While we're here, remove braces on if statements that only have one
> statement (manually).
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: <linux-crypto@vger.kernel.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> Please apply directly to subsystem trees
> 
>  drivers/crypto/atmel-aes.c             | 1 -
>  drivers/crypto/atmel-sha.c             | 1 -
>  drivers/crypto/atmel-tdes.c            | 1 -
>  drivers/crypto/ccree/cc_driver.c       | 4 +---
>  drivers/crypto/img-hash.c              | 1 -
>  drivers/crypto/mediatek/mtk-platform.c | 4 +---
>  drivers/crypto/mxs-dcp.c               | 8 ++------
>  drivers/crypto/omap-aes.c              | 1 -
>  drivers/crypto/omap-des.c              | 1 -
>  drivers/crypto/omap-sham.c             | 1 -
>  drivers/crypto/sahara.c                | 4 +---
>  drivers/crypto/stm32/stm32-cryp.c      | 4 +---
>  drivers/crypto/stm32/stm32-hash.c      | 4 +---
>  13 files changed, 7 insertions(+), 28 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
