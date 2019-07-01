Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D064303EC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 23:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfE3VPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 17:15:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfE3VPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 17:15:14 -0400
Received: from localhost (unknown [207.225.69.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB80921E6D;
        Thu, 30 May 2019 21:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559250913;
        bh=td1ZMqdWFXe4eiww03RgX6CVYsoiM7Kuh45FZNRGmJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=faMNQ1PBLFR1RwoVfreFw1diU2hoNFv274ZDQvqxI5FkO+YxocpCpuTOe/7kE2lUd
         FAyNaf4BxGOm7swFfgyJ5+aWkhqCgeEIZ68RgInNoVhsbZigGH0DukU28jg7pUflzU
         EGcVneyU8r/XsSKrhaXiAFzja/EcBO1PJXcvSBrU=
Date:   Thu, 30 May 2019 14:15:13 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     forest@alittletooquiet.net, madhumithabiw@gmail.com,
        brandonbonaby94@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: Change return type of function and
 remove variable
Message-ID: <20190530211513.GA25966@kroah.com>
References: <20190529134529.8481-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529134529.8481-1-nishkadg.linux@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 07:15:29PM +0530, Nishka Dasgupta wrote:
> As the function CARDbRadioPowerOff always returns true, and this value
> does not appear to be used anywhere, the return variable can be entirely
> removed and the function converted to type void.
> Issue found with Coccinelle.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---
>  drivers/staging/vt6655/card.c | 56 ++++++++++++++++-------------------
>  drivers/staging/vt6655/card.h |  2 +-
>  2 files changed, 27 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
> index 6ecbe925026d..2aca5b38be5c 100644
> --- a/drivers/staging/vt6655/card.c
> +++ b/drivers/staging/vt6655/card.c
> @@ -409,42 +409,38 @@ bool CARDbSetBeaconPeriod(struct vnt_private *priv,
>   *  Out:
>   *      none
>   *
> - * Return Value: true if success; otherwise false
> + * Return Value: none

That's obvious and the whole line can be removed.

>   */
> -bool CARDbRadioPowerOff(struct vnt_private *priv)
> +void CARDbRadioPowerOff(struct vnt_private *priv)
>  {
> -	bool bResult = true;
> -
> -	if (priv->bRadioOff)
> -		return true;
> -
> -	switch (priv->byRFType) {
> -	case RF_RFMD2959:
> -		MACvWordRegBitsOff(priv->PortOffset, MAC_REG_SOFTPWRCTL,
> -				   SOFTPWRCTL_TXPEINV);
> -		MACvWordRegBitsOn(priv->PortOffset, MAC_REG_SOFTPWRCTL,
> -				  SOFTPWRCTL_SWPE1);
> -		break;
> +	if (!priv->bRadioOff) {
> +		switch (priv->byRFType) {

No, don't do that.  Leave the indentation alone and just return "early"
like the code did.

thanks,

greg k-h
