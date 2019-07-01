Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16C78374A8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 14:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfFFM73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 08:59:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbfFFM73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 08:59:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FE302070B;
        Thu,  6 Jun 2019 12:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559825968;
        bh=7RZShAsT5Ac6fwFUJ8T+626Y3eZ1PxJCUZdWLG205eg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wRh86ID9iECC18xel4NOQx4MuIWjxcTY7A/Cq7ChoLU+9djPc4mzch9FO8j9RzVoe
         YB2TtTqNJ86cfLEj3lXYWFy4KcmIKHe0HJ/VoyoDmU56sSSfr9QvhfSxY0MlluXH8T
         +rqSl8MdcxtcRlKLZ16dMMjN0BWHvYV+uXUpkF1A=
Date:   Thu, 6 Jun 2019 14:59:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     larry.finger@lwfinger.net, straube.linux@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        flbue@gmx.de, puranjay12@gmail.com
Subject: Re: [PATCH] staging: rtl8188eu: core: Replace function
 rtw_free_network_nolock
Message-ID: <20190606125926.GA1140@kroah.com>
References: <20190604081222.12658-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604081222.12658-1-nishkadg.linux@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 01:42:22PM +0530, Nishka Dasgupta wrote:
> Remove function rtw_free_network_nolock, as all it does is call
> _rtw_free_network_nolock, and rename _rtw_free_network_nolock to
> rtw_free_network_nolock.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---
>  drivers/staging/rtl8188eu/core/rtw_mlme.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
> index 0abb2df32645..454c5795903d 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
> @@ -159,7 +159,7 @@ static void _rtw_free_network(struct mlme_priv *pmlmepriv, struct wlan_network *
>  	spin_unlock_bh(&free_queue->lock);
>  }
>  
> -void _rtw_free_network_nolock(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwork)
> +void rtw_free_network_nolock(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwork)

Why is this function moved from being static to not being static?

that doesn't seem right to me, does it to you?

thanks,

greg k-h
