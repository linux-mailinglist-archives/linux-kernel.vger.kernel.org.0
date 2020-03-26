Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5B4193A86
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 09:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgCZIOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 04:14:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbgCZIOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 04:14:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CAC82070A;
        Thu, 26 Mar 2020 08:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585210476;
        bh=elz3UD004qynkZxjoJv1nYmnugnX1dCGwgJS0d8+k4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y9+4WRWnBTZ4ra47yUm7mmra9bmFqu1h7f7HB6RjbmAhL43j7Iy3niG05rhzaD0K/
         5mJRdJl3Ts07KRxp/f70IXq0X6fH5jxc54OvzoLILi+2i4aZ8lcxOgc22fZz5AELx+
         jxdQL6+7di777t5ZsUpmXbMy7tcWBnPvZZV/XEI8=
Date:   Thu, 26 Mar 2020 09:14:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, anenbupt@gmail.com
Subject: Re: [PATCH] USB: io_edgeport: fix  slab-out-of-bounds Read in
 edge_interrupt_callback
Message-ID: <20200326081433.GA979574@kroah.com>
References: <1585122757-4528-1-git-send-email-hqjagain@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585122757-4528-1-git-send-email-hqjagain@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 03:52:37PM +0800, Qiujun Huang wrote:
> The boundary condition should be (length - 1) as we access data[position+1].
> 
> Reported-and-tested-by: syzbot+37ba33391ad5f3935bbd@syzkaller.appspotmail.com
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> ---
>  drivers/usb/serial/io_edgeport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
> index 5737add..4cca0b8 100644
> --- a/drivers/usb/serial/io_edgeport.c
> +++ b/drivers/usb/serial/io_edgeport.c
> @@ -710,7 +710,7 @@ static void edge_interrupt_callback(struct urb *urb)
>  		/* grab the txcredits for the ports if available */
>  		position = 2;
>  		portNumber = 0;
> -		while ((position < length) &&
> +		while ((position < length - 1) &&
>  				(portNumber < edge_serial->serial->num_ports)) {
>  			txCredits = data[position] | (data[position+1] << 8);
>  			if (txCredits) {
> -- 
> 1.8.3.1
> 

Johan, any objection from me taking this in my tree now?

thanks,

greg k-h
