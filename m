Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCBA174E33
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 14:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbfGYMei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 08:34:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729381AbfGYMeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:34:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C55A218D4;
        Thu, 25 Jul 2019 12:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564058077;
        bh=AInVxhE3Idi0ugTvrzFKIapKo+bdLWUILig2EoSAw7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jbIqz6838IiuZYE6lauTyoR24nT8i2QDmjfRC9EXlKOkiQ5bemEHUuIr2f9kEbbsc
         18vvIrcChurvx3ekHkc4/gjsJTTokPpgZQpnt9Z/6Ztfe4ljd+3SRKlqKK/09zxRmT
         wqhH7p7A+o+3IMMktwP4JutVkoaF3if19UQbeRXY=
Date:   Thu, 25 Jul 2019 14:34:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hpet: Drop unused variable 'm' in hpet_interrupt()
Message-ID: <20190725123434.GA16355@kroah.com>
References: <20190711133238.131602-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190711133238.131602-1-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 09:32:38PM +0800, Kefeng Wang wrote:
> ../drivers/char/hpet.c:159:17: warning: variable ‘m’ set but not used
> [-Wunused-but-set-variable]
>    unsigned long m, t, mc, base, k;
>                  ^
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/char/hpet.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
> index 9ac6671bb514..039398cb14aa 100644
> --- a/drivers/char/hpet.c
> +++ b/drivers/char/hpet.c
> @@ -156,12 +156,11 @@ static irqreturn_t hpet_interrupt(int irq, void *data)
>  	 * This has the effect of treating non-periodic like periodic.
>  	 */
>  	if ((devp->hd_flags & (HPET_IE | HPET_PERIODIC)) == HPET_IE) {
> -		unsigned long m, t, mc, base, k;
> +		unsigned long t, mc, base, k;
>  		struct hpet __iomem *hpet = devp->hd_hpet;
>  		struct hpets *hpetp = devp->hd_hpets;
>  
>  		t = devp->hd_ireqfreq;
> -		m = read_counter(&devp->hd_timer->hpet_compare);

Are you sure this is ok to remove?  You are reading from the hardware
here, and often times that is required in order to achive something
else.

So this function does not "do nothing", be careful and you will have to
test this before I can take it.

thanks,

greg k-h
