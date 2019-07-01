Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 047AB1B2E8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 11:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfEMJd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 05:33:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfEMJd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:33:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3365D20873;
        Mon, 13 May 2019 09:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557740006;
        bh=Oh5xXg6uTFSzSLkeVykgO08l4nnAKG9rNXBddLbIWzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mxWEuWK7B06nvRkMIiatxxlv4Z+H8puDaQkfQ097Re5RMkyaxLMZGjHSQ2s2nlHsm
         gOd/TnrushyhGYk+rRfigzDrZx5FyxZVssmt3AwZhDsuFNxp5XsfI+DI8mzRUAsxdl
         BhefurJNWCigEz+aVb8rYZkIXbrl3+DEOqDmUm7o=
Date:   Mon, 13 May 2019 11:33:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vatsala Narang <vatsalanarang@gmail.com>
Cc:     devel@driverdev.osuosl.org, julia.lawall@lip6.fr,
        linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        hadess@hadess.net
Subject: Re: [PATCH v2 6/6] staging: rtl8723bs: core: Move logical operator
 to previous line.
Message-ID: <20190513093324.GA21213@kroah.com>
References: <20190505132253.4516-1-vatsalanarang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190505132253.4516-1-vatsalanarang@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 05, 2019 at 06:52:53PM +0530, Vatsala Narang wrote:
> Move logical operator to previous line to get rid of checkpatch warning.
> 
> Signed-off-by: Vatsala Narang <vatsalanarang@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index 0b5bd047a552..b5e355de1199 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -5656,9 +5656,9 @@ static u8 chk_ap_is_alive(struct adapter *padapter, struct sta_info *psta)
>  	);
>  	#endif
>  
> -	if ((sta_rx_data_pkts(psta) == sta_last_rx_data_pkts(psta))
> -		&& sta_rx_beacon_pkts(psta) == sta_last_rx_beacon_pkts(psta)
> -		&& sta_rx_probersp_pkts(psta) == sta_last_rx_probersp_pkts(psta)
> +	if ((sta_rx_data_pkts(psta) == sta_last_rx_data_pkts(psta)) &&
> +	    sta_rx_beacon_pkts(psta) == sta_last_rx_beacon_pkts(psta) &&
> +	     sta_rx_probersp_pkts(psta) == sta_last_rx_probersp_pkts(psta)

Odd, you should align these two lines, right?

>  	) {

This should go on the previous line.

thanks,

greg k-h
