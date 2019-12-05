Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2C31140A6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 13:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfLEMNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 07:13:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:55992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729048AbfLEMNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 07:13:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4EF424249;
        Thu,  5 Dec 2019 12:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575547992;
        bh=Vzy8R53ZVKTDj13WA/tyhafFPACRJeIQkz7cNZmXZWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GWi89UGTyrmN3gyhSG7SUelx22s3kK+wT3tuZOiN4jfAJ2ZMWA99eqWzKHEyDwuIc
         rZpe/47XRDO4yRLWnzZEObL9ere1VR566vrbW/9LRASpN49DRMtE3uCCJE2ZSKdcvS
         jzzubV2C24ZRGOfbBC49/NFbHpX1+2SCycRZvzpc=
Date:   Thu, 5 Dec 2019 13:13:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, huawei.libin@huawei.com
Subject: Re: [PATCH] tty: omap-serial: remove set but unused variable
Message-ID: <20191205121310.GA389695@kroah.com>
References: <1575547476-51996-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575547476-51996-1-git-send-email-wangxiongfeng2@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 08:04:36PM +0800, Xiongfeng Wang wrote:
> Fix the following warning:
> drivers/tty/serial/omap-serial.c: In function serial_omap_rlsi:
> drivers/tty/serial/omap-serial.c:496:16: warning: variable ch set but not used [-Wunused-but-set-variable]
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/tty/serial/omap-serial.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index 6420ae5..54ee3ae 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -493,10 +493,9 @@ static unsigned int check_modem_status(struct uart_omap_port *up)
>  static void serial_omap_rlsi(struct uart_omap_port *up, unsigned int lsr)
>  {
>  	unsigned int flag;
> -	unsigned char ch = 0;
>  
>  	if (likely(lsr & UART_LSR_DR))
> -		ch = serial_in(up, UART_RX);
> +		serial_in(up, UART_RX);

Shouldn't you be doing something with 'ch'?

