Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9133E1E4F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 16:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392290AbfJWOjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 10:39:41 -0400
Received: from muru.com ([72.249.23.125]:39286 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389921AbfJWOjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 10:39:41 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B4C7480CF;
        Wed, 23 Oct 2019 14:40:14 +0000 (UTC)
Date:   Wed, 23 Oct 2019 07:39:36 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Adam Ford <aford173@gmail.com>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>,
        Tero Kristo <t-kristo@ti.com>, Rob Herring <robh@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwrng: omap3-rom - Fix unused function warnings
Message-ID: <20191023143936.GH5610@atomide.com>
References: <20191022142741.1794378-1-arnd@arndb.de>
 <20191023131452.2rilepif7x5lpfma@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023131452.2rilepif7x5lpfma@earth.universe>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [191023 13:15]:
> Hi,
> 
> On Tue, Oct 22, 2019 at 04:27:31PM +0200, Arnd Bergmann wrote:
> > When runtime-pm is disabled, we get a few harmless warnings:
> > 
> > drivers/char/hw_random/omap3-rom-rng.c:65:12: error: unused function 'omap_rom_rng_runtime_suspend' [-Werror,-Wunused-function]
> > drivers/char/hw_random/omap3-rom-rng.c:81:12: error: unused function 'omap_rom_rng_runtime_resume' [-Werror,-Wunused-function]
> > 
> > Mark these functions as __maybe_unused so gcc can drop them
> > silently.
> > 
> > Fixes: 8d9d4bdc495f ("hwrng: omap3-rom - Use runtime PM instead of custom functions")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Thanks for fixing these similar issues again:

Reviewwed-by: Tony Lindgren <tony@atomide.com>
