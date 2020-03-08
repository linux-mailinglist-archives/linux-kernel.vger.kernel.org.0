Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9599317D21F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Mar 2020 07:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgCHGzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Mar 2020 01:55:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:33136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbgCHGzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 01:55:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52B9420828;
        Sun,  8 Mar 2020 06:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583650541;
        bh=lAhBIsdsIoz5OulCUzYlLY6/s6fpUovxZYcQI0rfdIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l1IIJTAJDx5Qruopgru/0PHNXaifkm/SG+nmoGSA+OoHvztPFvHRABTQAaUA+jFtg
         PY1LVMKQWkdbSYFJmE/AhZ8eG1ysmmpbYH9EwlYboup0gqmdxTWt57xzpNiwMZICl5
         cC00WBkrfsBeesUzridpLEEHJ5hlrFGmKHiXp1sM=
Date:   Sun, 8 Mar 2020 07:55:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        devel@driverdev.osuosl.org, Malcolm Priestley <tvboxspy@gmail.com>,
        linux-kernel@vger.kernel.org,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] staging: vt6656: Use BIT_ULL() macro instead of bit
 shift operation
Message-ID: <20200308065538.GF3983392@kroah.com>
References: <20200307104929.7710-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307104929.7710-1-oscar.carter@gmx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 07, 2020 at 11:49:29AM +0100, Oscar Carter wrote:
> Replace the bit left shift operation with the BIT_ULL() macro and remove
> the unnecessary "and" operation against the bit_nr variable.
> 
> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> ---
>  drivers/staging/vt6656/main_usb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
> index 5e48b3ddb94c..f7ca9e97594d 100644
> --- a/drivers/staging/vt6656/main_usb.c
> +++ b/drivers/staging/vt6656/main_usb.c
> @@ -21,6 +21,7 @@
>   */
>  #undef __NO_VERSION__
> 
> +#include <linux/bits.h>
>  #include <linux/etherdevice.h>
>  #include <linux/file.h>
>  #include "device.h"
> @@ -802,8 +803,7 @@ static u64 vnt_prepare_multicast(struct ieee80211_hw *hw,
> 
>  	netdev_hw_addr_list_for_each(ha, mc_list) {
>  		bit_nr = ether_crc(ETH_ALEN, ha->addr) >> 26;
> -
> -		mc_filter |= 1ULL << (bit_nr & 0x3f);
> +		mc_filter |= BIT_ULL(bit_nr);

Are you sure this does the same thing?  You are not masking off bit_nr
anymore, why not?

thanks,

greg k-h
