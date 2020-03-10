Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 311FA17FFBE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 15:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgCJOEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 10:04:05 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:37880 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726512AbgCJOEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:04:05 -0400
Received: (qmail 1815 invoked by uid 2102); 10 Mar 2020 10:04:04 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Mar 2020 10:04:04 -0400
Date:   Tue, 10 Mar 2020 10:04:04 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Lubomir Rintel <lkundrak@v3.sk>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] USB: EHCI: ehci-mv: use a unique bus name
In-Reply-To: <20200309130014.548168-2-lkundrak@v3.sk>
Message-ID: <Pine.LNX.4.44L0.2003101003490.1651-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Mar 2020, Lubomir Rintel wrote:

> In case there are multiple Marvell EHCI blocks in system, we need a
> different bus name for each one. Otherwise debugfs gets mildly upset about
> a directory name in usb/ehci:
> 
>   debugfs: Directory 'mv ehci' with parent 'ehci' already present!
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Alan Stern <stern@rowland.harvard.edu>

> ---
>  drivers/usb/host/ehci-mv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
> index ddb668963955f..1300c457d9ed6 100644
> --- a/drivers/usb/host/ehci-mv.c
> +++ b/drivers/usb/host/ehci-mv.c
> @@ -115,7 +115,7 @@ static int mv_ehci_probe(struct platform_device *pdev)
>  	if (usb_disabled())
>  		return -ENODEV;
>  
> -	hcd = usb_create_hcd(&ehci_platform_hc_driver, &pdev->dev, "mv ehci");
> +	hcd = usb_create_hcd(&ehci_platform_hc_driver, &pdev->dev, dev_name(&pdev->dev));
>  	if (!hcd)
>  		return -ENOMEM;
>  
> 

