Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D46D174D53
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Mar 2020 13:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgCAMZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Mar 2020 07:25:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:54990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCAMZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 07:25:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDD0520880;
        Sun,  1 Mar 2020 12:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583065517;
        bh=iwl45dktsriIQbBFVjaFO9PWC/Xfz0mIkUcdKvoKvP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ud2jSOiCjXYngm+tP22PoFfyggtDCHH/5M/DC8QPtchPnlQhfvBmXWMa9aS2mK01x
         WMyf/NAiAVHt1o/VDwFrk+GgSZw7ZFx3gNEahQUAEZB+CzxO1OY1njUWM+KF0hs5Ek
         S+xql6mkqy0aKMUp5FzqVhcGfie/NO7LAY32b5ww=
Date:   Sun, 1 Mar 2020 13:25:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        devel@driverdev.osuosl.org, Malcolm Priestley <tvboxspy@gmail.com>,
        linux-kernel@vger.kernel.org,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] staging: vt6656: Declare a few variables as __read_mostly
Message-ID: <20200301122514.GA1461917@kroah.com>
References: <20200301112620.7892-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200301112620.7892-1-oscar.carter@gmx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 12:26:20PM +0100, Oscar Carter wrote:
> These include module parameters.
> 
> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> ---
>  drivers/staging/vt6656/main_usb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
> index 5e48b3ddb94c..701300202b21 100644
> --- a/drivers/staging/vt6656/main_usb.c
> +++ b/drivers/staging/vt6656/main_usb.c
> @@ -49,12 +49,12 @@ MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION(DEVICE_FULL_DRV_NAM);
> 
>  #define RX_DESC_DEF0 64
> -static int vnt_rx_buffers = RX_DESC_DEF0;
> +static int __read_mostly vnt_rx_buffers = RX_DESC_DEF0;
>  module_param_named(rx_buffers, vnt_rx_buffers, int, 0644);
>  MODULE_PARM_DESC(rx_buffers, "Number of receive usb rx buffers");
> 
>  #define TX_DESC_DEF0 64
> -static int vnt_tx_buffers = TX_DESC_DEF0;
> +static int __read_mostly vnt_tx_buffers = TX_DESC_DEF0;
>  module_param_named(tx_buffers, vnt_tx_buffers, int, 0644);
>  MODULE_PARM_DESC(tx_buffers, "Number of receive usb tx buffers");
> 

Why?  What does this help with?

thanks,

greg k-h
