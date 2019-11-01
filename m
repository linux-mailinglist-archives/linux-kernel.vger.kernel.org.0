Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E097AEBD93
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 07:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbfKAGHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 02:07:42 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37530 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfKAGHm (ORCPT <rfc822;linux-kernel@vger.kernel.orG>);
        Fri, 1 Nov 2019 02:07:42 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iQQ5n-0001sz-Vi; Fri, 01 Nov 2019 14:07:28 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iQQ5i-0004pU-QY; Fri, 01 Nov 2019 14:07:22 +0800
Date:   Fri, 1 Nov 2019 14:07:22 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Matt Mackall <mpm@selenic.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Adam Ford <aford173@gmail.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh@kernel.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwrng: omap3-rom - Fix unused function warnings
Message-ID: <20191101060722.56nbwi575qpzj65e@gondor.apana.org.au>
References: <20191022142741.1794378-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022142741.1794378-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 04:27:31PM +0200, Arnd Bergmann wrote:
> When runtime-pm is disabled, we get a few harmless warnings:
> 
> drivers/char/hw_random/omap3-rom-rng.c:65:12: error: unused function 'omap_rom_rng_runtime_suspend' [-Werror,-Wunused-function]
> drivers/char/hw_random/omap3-rom-rng.c:81:12: error: unused function 'omap_rom_rng_runtime_resume' [-Werror,-Wunused-function]
> 
> Mark these functions as __maybe_unused so gcc can drop them
> silently.
> 
> Fixes: 8d9d4bdc495f ("hwrng: omap3-rom - Use runtime PM instead of custom functions")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/char/hw_random/omap3-rom-rng.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
