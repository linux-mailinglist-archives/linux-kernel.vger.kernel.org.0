Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9CFC1140C7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 13:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbfLEMWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 07:22:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:38700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729099AbfLEMWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 07:22:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EB8320707;
        Thu,  5 Dec 2019 12:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575548531;
        bh=qgGNtF/l7uOobXAo/txHTzrih0m1E3AsFCzTZTO/ES4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wvT3NdlSMcDl6Rrb4U9G+zs8JaI+M3jRNj6qQJZSkFRLzUmnShicwh0sgML9Dyl1a
         N6qE39Xep1w0X0CiDtm1ODPrxoFb7xNiP+ZL8a7bcc1GJ/7JEPxvlbBKi7VDLbKmD3
         /iwctK45uF0Kr2EFObj1QV+dWqjnldQV4184A8P0=
Date:   Thu, 5 Dec 2019 13:22:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, huawei.libin@huawei.com
Subject: Re: [PATCH] tty: serial: 8250: remove set but unused variable
Message-ID: <20191205122208.GB390369@kroah.com>
References: <1575547903-52355-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575547903-52355-1-git-send-email-wangxiongfeng2@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 08:11:43PM +0800, Xiongfeng Wang wrote:
> Fix the following warning:
> drivers/tty/serial/8250/serial_cs.c: In function multi_config:
> drivers/tty/serial/8250/serial_cs.c:562:7: warning: variable err set but not used [-Wunused-but-set-variable]
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/tty/serial/8250/serial_cs.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/serial_cs.c b/drivers/tty/serial/8250/serial_cs.c
> index c8186a0..eeda6a0 100644
> --- a/drivers/tty/serial/8250/serial_cs.c
> +++ b/drivers/tty/serial/8250/serial_cs.c
> @@ -559,16 +559,13 @@ static int multi_config(struct pcmcia_device *link)
>  	 */
>  	if (info->manfid == MANFID_OXSEMI || (info->manfid == MANFID_POSSIO &&
>  				info->prodid == PRODID_POSSIO_GCC)) {
> -		int err;
> -
>  		if (link->config_index == 1 ||
>  		    link->config_index == 3) {
> -			err = setup_serial(link, info, base2,
> -					link->irq);
> +			setup_serial(link, info, base2, link->irq);
>  			base2 = link->resource[0]->start;
>  		} else {
> -			err = setup_serial(link, info, link->resource[0]->start,
> -					link->irq);
> +			setup_serial(link, info, link->resource[0]->start,
> +				     link->irq);

Again, why ignore the error value?

greg k-h
