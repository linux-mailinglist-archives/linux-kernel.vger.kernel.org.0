Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9271141DD4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jan 2020 13:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgASMu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jan 2020 07:50:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:35308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgASMu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 07:50:28 -0500
Received: from localhost (lns-bzn-36-82-251-23-53.adsl.proxad.net [82.251.23.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BAE620714;
        Sun, 19 Jan 2020 12:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579438228;
        bh=EpoPZpgS3rLbMCPJwdXNNLBTTwSV212aIU12MPC6Ui8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ujtTUo6hJ4L5DvNSqixpuZnGzqAOUpxnerJbRXd8SdGVbOYFBeqAeUMIZYkeQJzGg
         c0lhLppIOxwcmYL/mRRMrpv6yNgdh4Jz9NE0eG8CxAeYRscItR7TpQ4/w3cV2yEVZ7
         ndbPVwrVfNR4pJ8+IHDIcneaV7NanEzxOz1OawlM=
Date:   Sun, 19 Jan 2020 13:50:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Simon Fong <simon.fongnt@gmail.com>
Cc:     abbotti@mev.co.uk, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, colin.king@canonical.com
Subject: Re: [PATCH 3/3] Staging: comedi: usbdux: cleanup long line and align
 it
Message-ID: <20200119125024.GA149057@kroah.com>
References: <20200119035243.7819-1-simon.fongnt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200119035243.7819-1-simon.fongnt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2020 at 11:52:43AM +0800, Simon Fong wrote:
> Clean up long line and align it
> 
> Signed-off-by: Simon Fong <simon.fongnt@gmail.com>
> ---
>  drivers/staging/comedi/drivers/usbdux.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/comedi/drivers/usbdux.c b/drivers/staging/comedi/drivers/usbdux.c
> index 0350f303d557..b9c0b1a1d86e 100644
> --- a/drivers/staging/comedi/drivers/usbdux.c
> +++ b/drivers/staging/comedi/drivers/usbdux.c
> @@ -204,7 +204,8 @@ struct usbdux_private {
>  	struct mutex mut;
>  };
>  
> -static void usbdux_unlink_urbs(struct urb **urbs, int num_urbs)
> +static void usbdux_unlink_urbs(struct urb **urbs,
> +			       int num_urbs)

As Joe said, there is no reason to change this line that I can see, why
do you want to do that?

greg k-h
