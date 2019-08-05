Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 808B581FB0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 17:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbfHEPDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 11:03:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728043AbfHEPDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 11:03:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46BBA206C1;
        Mon,  5 Aug 2019 15:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565017386;
        bh=+Xz3bwnFyaWyqY9a37gwwnBNAogellhkHzcb0xquKIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=au5ozn6Us640CQSmT+gPP1wjfGcLKu+5AO3u44G76dCrxZWNyyj1JcwczmM6US+Dn
         IiWu9CBPX4J8YB54hKk0nqGlb9y9AuROg+Rzr1ViY2xle0v+U4k59UI9YGzet5c7YZ
         Uu9F7zgngDfMe+2b6iAurxNCW5MLhRAYDMZGoEO8=
Date:   Mon, 5 Aug 2019 17:03:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Giridhar Prasath R <cristianoprasath@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433 line over 80 characters in multiple places
Message-ID: <20190805150304.GA746@kroah.com>
References: <20190805000248.4902-1-cristianoprasath@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805000248.4902-1-cristianoprasath@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 05:32:45AM +0530, Giridhar Prasath R wrote:
> Fix the following checkpatch warnings:
> 
> WARNING: line over 80 characters
> FILE: drivers/staging/pi433/pi433_if.h
> 
> Signed-off-by: Giridhar Prasath R <cristianoprasath@gmail.com>
> ---
>  drivers/staging/pi433/pi433_if.h | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
> index 9feb95c431cb..915bd96910c6 100644
> --- a/drivers/staging/pi433/pi433_if.h
> +++ b/drivers/staging/pi433/pi433_if.h
> @@ -117,9 +117,14 @@ struct pi433_rx_cfg {
>  
>  	/* packet format */
>  	enum option_on_off	enable_sync;
> -	enum option_on_off	enable_length_byte;	  /* should be used in combination with sync, only */
> -	enum address_filtering	enable_address_filtering; /* operational with sync, only */
> -	enum option_on_off	enable_crc;		  /* only operational, if sync on and fixed length or length byte is used */
> +	/* should be used in combination with sync, only */
> +	enum option_on_off	enable_length_byte;
> +	/* operational with sync, only */
> +	enum address_filtering	enable_address_filtering;
> +	/* only operational,
> +	 * if sync on and fixed length or length byte is used
> +	 */
> +	enum option_on_off	enable_crc;
>  
>  	__u8			sync_length;
>  	__u8			fixed_message_length;
> @@ -132,10 +137,14 @@ struct pi433_rx_cfg {
>  
>  #define PI433_IOC_MAGIC			'r'
>  
> -#define PI433_IOC_RD_TX_CFG	_IOR(PI433_IOC_MAGIC, PI433_TX_CFG_IOCTL_NR, char[sizeof(struct pi433_tx_cfg)])
> -#define PI433_IOC_WR_TX_CFG	_IOW(PI433_IOC_MAGIC, PI433_TX_CFG_IOCTL_NR, char[sizeof(struct pi433_tx_cfg)])
> +#define PI433_IOC_RD_TX_CFG	_IOR(PI433_IOC_MAGIC, PI433_TX_CFG_IOCTL_NR,\
> +char[sizeof(struct pi433_tx_cfg)])

Ick, that does not look better :(

We write code for humans first, compilers second.

The original is fine, thanks.

greg k-h
