Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4DC027C42
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 13:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbfEWLz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 07:55:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730369AbfEWLz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 07:55:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F26C20881;
        Thu, 23 May 2019 11:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558612555;
        bh=puKLNTiE7cwyf6xYtoR1KxBZnqtcCNUUrpxzR1l2XNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bfSxSYHWib7RKerqZ7PBtGoXvOrTDtTmqD2U0Hu4ZJcKaES8KbxBFvBeXvdfPpmh+
         cSCuoGOPeAIWKBGxrrDfczrinK/Nd2zWokRXbFG8k56NYkIEUxGNWLpz7ViQZ1ijgZ
         Jo+Q2LcQ4DoiPoSMEoZuYGCunHxM6MPUTf4wdu9Y=
Date:   Thu, 23 May 2019 13:55:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH 2/8] staging: kpc2000: use __func__ in debug messages
Message-ID: <20190523115553.GA6953@kroah.com>
References: <20190523113613.28342-1-simon@nikanor.nu>
 <20190523113613.28342-3-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190523113613.28342-3-simon@nikanor.nu>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 01:36:07PM +0200, Simon Sandström wrote:
> Fixes checkpatch.pl warning "Prefer using '"%s...", __func__' to using
> '<function name>', this function's name, in a string".
> 
> Signed-off-by: Simon Sandström <simon@nikanor.nu>
> ---
>  drivers/staging/kpc2000/kpc2000/cell_probe.c | 22 +++++++++++++-------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
> index 95bfbe4aae4d..7b850f3e808b 100644
> --- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
> +++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
> @@ -299,7 +299,8 @@ static int probe_core_uio(unsigned int core_num, struct kp2000_device *pcard,
>  
>  	kudev = kzalloc(sizeof(struct kpc_uio_device), GFP_KERNEL);
>  	if (!kudev) {
> -		dev_err(&pcard->pdev->dev, "probe_core_uio: failed to kzalloc kpc_uio_device\n");
> +		dev_err(&pcard->pdev->dev, "%s: failed to kzalloc kpc_uio_device\n",
> +			__func__);

kmalloc and friend error messages should just be deleted.  Didn't
checkpatch say something about that?

thanks,

greg k-h
