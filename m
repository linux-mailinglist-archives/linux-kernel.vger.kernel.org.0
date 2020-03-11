Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38D7D181170
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 08:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgCKHII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 03:08:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbgCKHIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:08:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 309BB208E4;
        Wed, 11 Mar 2020 07:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583910485;
        bh=KWEMZBtvojoiS04WgF5wQ4fehfKEjCOMaHzHE9OimCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i8mlWTqL8hQaKdnBrGXlmaFGFg14Y58UbQQPFmbkMSqc09kQUUJnoi30vPVobfFZT
         n1flj0u5KAweKqLuUA9tKjx4qzht5Ljz8Nska+4sDXiRp+7gNtCgj6ytN5ve1KbtpW
         heAls2eIfiR94jE9W3SBdKMq/WdTWh19vhQELeGc=
Date:   Wed, 11 Mar 2020 08:08:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thiago Souza Ferreira <thsouza2013@gmail.com>
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Subject: Re: [PATCH] staging: rtl8188eu: Fix block comments to use *
Message-ID: <20200311070803.GA3585003@kroah.com>
References: <20200311012332.27498-1-thsouza2013@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311012332.27498-1-thsouza2013@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 01:23:32AM +0000, Thiago Souza Ferreira wrote:
> Fix "Block comments use * on subsequent lines" warning of
> rtw_mlme_ext.c, found by checkpatch.pl script
> 
> Signed-off-by: Thiago Souza Ferreira <thsouza2013@gmail.com>
> ---
>  drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 69 ++++++++++---------
>  1 file changed, 35 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> index 36841d20c..02b87a804 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> @@ -20,8 +20,8 @@
>  static u8 null_addr[ETH_ALEN] = {};
>  
>  /**************************************************
> -OUI definitions for the vendor specific IE
> -***************************************************/
> + *OUI definitions for the vendor specific IE
> + ***************************************************/

Please use a ' ' before the text to make it look "clean".

thanks,

greg k-h
