Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4811055E16
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 04:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfFZCDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 22:03:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfFZCDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 22:03:31 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA084205C9;
        Wed, 26 Jun 2019 02:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561514610;
        bh=62LoSwtXHpbnbCH3C/+D4GuQrQ/r6+lINTf9IHhDVnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sr8P26hcL0mrsOSIY0mf890uVjyghZvny3f090YK7szhXZlagCeOLKvIC7BI4g7jR
         QXaWTARPZX5eE28hPdMWtULJgLCVIt6DmZDEwQg/32U7uiUVJdfgrNVNFWxUk6jgWO
         /84SYo0QztGQ6Mqh98fQUdpCDzzi6PaYLNbw+lNA=
Date:   Wed, 26 Jun 2019 09:56:22 +0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>
Cc:     devel@driverdev.osuosl.org, gneukum1@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] staging: kpc2000: remove unnecessary parentheses in
 kpc2000_spi.c
Message-ID: <20190626015622.GC30966@kroah.com>
References: <20190625084130.1107-1-simon@nikanor.nu>
 <20190625084130.1107-4-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190625084130.1107-4-simon@nikanor.nu>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 10:41:29AM +0200, Simon Sandström wrote:
> Fixes checkpatch "CHECK: Unnecessary parentheses around '...'".
> 
> Signed-off-by: Simon Sandström <simon@nikanor.nu>
> ---
>  drivers/staging/kpc2000/kpc2000_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
> index 98484fbb9d2e..68b049f9ad69 100644
> --- a/drivers/staging/kpc2000/kpc2000_spi.c
> +++ b/drivers/staging/kpc2000/kpc2000_spi.c
> @@ -164,7 +164,7 @@ kp_spi_read_reg(struct kp_spi_controller_state *cs, int idx)
>  	u64 val;
>  
>  	addr += idx;
> -	if ((idx == KP_SPI_REG_CONFIG) && (cs->conf_cache >= 0)) {
> +	if (idx == KP_SPI_REG_CONFIG && cs->conf_cache >= 0) {

Ick, no.  I don't want to have to remember the priority order of
operations.  Leave this as-is, I HATE this checkpatch message.

thanks,

greg k-h
