Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 044BEE82FC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 09:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfJ2IKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 04:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbfJ2IKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 04:10:11 -0400
Received: from localhost (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5817720663;
        Tue, 29 Oct 2019 08:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572336611;
        bh=C85TGFeZCrGhOL2LSvwdwkyUtb0eIGs8u6rXwHu3r98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S7XWlfdDSAlv3/uYXRZvk4A1wIhOPLofg4bVvODYpmmX6GbFCtoIWF9uPFB1ALy29
         rybgZME5qU6TosYnR9W1rsrvwxEP0QgO3ZTcwIhMv1brnykO+JrIj+sGKBHmH7tGCO
         EASLpW79fQ3SwYIzI+DMOPusJhZxE3EWssqJ3dOQ=
Date:   Tue, 29 Oct 2019 09:10:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Samuil Ivanov <samuil.ivanovbg@gmail.com>
Cc:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Staging: gasket: implement apex_get_status() to
 check driver status
Message-ID: <20191029081007.GA520581@kroah.com>
References: <20191028225926.8951-1-samuil.ivanovbg@gmail.com>
 <20191028225926.8951-2-samuil.ivanovbg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028225926.8951-2-samuil.ivanovbg@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 12:59:25AM +0200, Samuil Ivanov wrote:
> >From the TODO:
> - apex_get_status() should actually check status
> 
> The function now checkes the status of the driver
> 
> Signed-off-by: Samuil Ivanov <samuil.ivanovbg@gmail.com>
> ---
>  drivers/staging/gasket/apex_driver.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
> index 46199c8ca441..a5dd6f3c367d 100644
> --- a/drivers/staging/gasket/apex_driver.c
> +++ b/drivers/staging/gasket/apex_driver.c
> @@ -247,6 +247,9 @@ module_param(bypass_top_level, int, 0644);
>  static int apex_get_status(struct gasket_dev *gasket_dev)
>  {
>  	/* TODO: Check device status. */
> +	if (gasket_dev->status == GASKET_STATUS_DEAD)
> +		return GASKET_STATUS_DEAD;
> +

Have you tested this to verify that this is what is needed here?

thanks,

greg k-h
