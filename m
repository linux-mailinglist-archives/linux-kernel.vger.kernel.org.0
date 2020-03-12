Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1BEE182750
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 04:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbgCLDMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 23:12:14 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:56808 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387453AbgCLDMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 23:12:14 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jCEG9-0001ok-N0; Thu, 12 Mar 2020 14:11:46 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 12 Mar 2020 14:11:45 +1100
Date:   Thu, 12 Mar 2020 14:11:45 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, miguel.ojeda.sandonis@gmail.com,
        willy@haproxy.com, ksenija.stanojevic@gmail.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, mpm@selenic.com,
        jonathan@buzzard.org.uk, benh@kernel.crashing.org,
        davem@davemloft.net, b.zolnierkie@samsung.com, rjw@rjwysocki.net,
        pavel@ucw.cz, len.brown@intel.com
Subject: Re: [PATCH v2 1/2] misc: cleanup minor number definitions in c file
 into miscdevice.h
Message-ID: <20200312031145.GA19920@gondor.apana.org.au>
References: <20200311071654.335-1-zhenzhong.duan@gmail.com>
 <20200311071654.335-2-zhenzhong.duan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311071654.335-2-zhenzhong.duan@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 03:16:53PM +0800, Zhenzhong Duan wrote:
> HWRNG_MINOR and RNG_MISCDEV_MINOR are duplicate definitions, use
> unified HWRNG_MINOR instead and moved into miscdevice.h
> 
> ANSLCD_MINOR and LCD_MINOR are duplicate definitions, use unified
> LCD_MINOR instead and moved into miscdevice.h
> 
> MISCDEV_MINOR is renamed to PXA3XX_GCU_MINOR and moved into
> miscdevice.h
> 
> Other definitions are just moved without any change.
> 
> Link: https://lore.kernel.org/lkml/20200120221323.GJ15860@mit.edu/t/
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Build-tested-by: Willy TARREAU <wtarreau@haproxy.com>
> Build-tested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/um/drivers/random.c         |  4 +---
>  drivers/auxdisplay/charlcd.c     |  2 --
>  drivers/auxdisplay/panel.c       |  2 --
>  drivers/char/applicom.c          |  1 -
>  drivers/char/nwbutton.h          |  1 -
>  drivers/char/toshiba.c           |  2 --
>  drivers/macintosh/ans-lcd.c      |  2 +-
>  drivers/macintosh/ans-lcd.h      |  2 --
>  drivers/macintosh/via-pmu.c      |  3 ---
>  drivers/sbus/char/envctrl.c      |  2 --
>  drivers/sbus/char/uctrl.c        |  2 --
>  drivers/video/fbdev/pxa3xx-gcu.c |  7 +++----
>  include/linux/miscdevice.h       | 10 ++++++++++
>  kernel/power/user.c              |  2 --
>  14 files changed, 15 insertions(+), 27 deletions(-)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
