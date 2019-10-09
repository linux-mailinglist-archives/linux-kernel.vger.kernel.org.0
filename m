Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44031D17DD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 20:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731692AbfJISzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 14:55:10 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:65467 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729535AbfJISzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 14:55:10 -0400
X-IronPort-AV: E=Sophos;i="5.67,277,1566856800"; 
   d="scan'208";a="405482097"
Received: from 81-65-53-202.rev.numericable.fr (HELO hadrien) ([81.65.53.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 20:55:08 +0200
Date:   Wed, 9 Oct 2019 20:55:08 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Wambui Karuga <wambui.karugax@gmail.com>
cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: kpc2000: Remove unnecessary
 return variable
In-Reply-To: <20191009170703.GA2869@wambui>
Message-ID: <alpine.DEB.2.21.1910092054540.2570@hadrien>
References: <20191009170703.GA2869@wambui>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Oct 2019, Wambui Karuga wrote:

> Remove unnecessary variable `val` in kp_spi_read_reg() that only holds
> the return value from readq().
> Issue found by coccinelle using the script:
>
> @@
> local idexpression ret;
> expression e;
> @@
>
> -ret =
> +return
>      e;
> -return ret;
>
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>


> ---
>  drivers/staging/kpc2000/kpc2000_spi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
> index 3be33c450cab..6ba94b0131da 100644
> --- a/drivers/staging/kpc2000/kpc2000_spi.c
> +++ b/drivers/staging/kpc2000/kpc2000_spi.c
> @@ -162,14 +162,12 @@ union kp_spi_ffctrl {
>  kp_spi_read_reg(struct kp_spi_controller_state *cs, int idx)
>  {
>  	u64 __iomem *addr = cs->base;
> -	u64 val;
>
>  	addr += idx;
>  	if ((idx == KP_SPI_REG_CONFIG) && (cs->conf_cache >= 0))
>  		return cs->conf_cache;
>
> -	val = readq(addr);
> -	return val;
> +	return readq(addr);
>  }
>
>  	static inline void
> --
> 2.23.0
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20191009170703.GA2869%40wambui.
>
