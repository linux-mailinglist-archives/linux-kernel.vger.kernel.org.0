Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E56E8276D4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 09:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbfEWHWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 03:22:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbfEWHWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:22:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A83A204EC;
        Thu, 23 May 2019 07:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558596169;
        bh=SxGawdpzQ2pd4+QP+LacgHk3fZS2n/0uGx1ffIVK2J4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YUVRZYlh93u2x/cXMIqeZx4IuBo3S3jzovwoAMlNHa8bckRhbOFZQ8syp1GJCVOJ+
         SIaLbJKAQvv6fsjE7rxtQxsEVBYHz6Gd8qk7x4WGz/upqN3ueSCTNZfKdkTwHpw4Nq
         wBmqY3VX1AAa3CqNYV5fXcMzTrE8EZy457ameSmk=
Date:   Thu, 23 May 2019 09:22:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nishka Dasgupta <nishka.dasgupta@yahoo.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fieldbus: anybuss: Remove variable
Message-ID: <20190523072246.GD24998@kroah.com>
References: <20190523070531.13510-1-nishka.dasgupta@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523070531.13510-1-nishka.dasgupta@yahoo.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 12:35:26PM +0530, Nishka Dasgupta wrote:
> Variable client, assigned to priv->client, is used only once in a
> function argument; hence, it can be removed and the function argument
> replaced with priv->client directly.
> Issue found with Coccinelle.
> 
> Signed-off-by: Nishka Dasgupta <nishka.dasgupta@yahoo.com>
> ---
>  drivers/staging/fieldbus/anybuss/hms-profinet.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/fieldbus/anybuss/hms-profinet.c b/drivers/staging/fieldbus/anybuss/hms-profinet.c
> index 5446843e35f4..a7f85912fa92 100644
> --- a/drivers/staging/fieldbus/anybuss/hms-profinet.c
> +++ b/drivers/staging/fieldbus/anybuss/hms-profinet.c
> @@ -124,9 +124,7 @@ static int __profi_enable(struct profi_priv *priv)
>  
>  static int __profi_disable(struct profi_priv *priv)
>  {
> -	struct anybuss_client *client = priv->client;
> -
> -	anybuss_set_power(client, false);
> +	anybuss_set_power(priv->client, false);

Same comments are relevant here as the last patch you sent.

thanks,

greg k-h
