Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F234CD020
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 11:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfJFJuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Oct 2019 05:50:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfJFJuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 05:50:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C62A20867;
        Sun,  6 Oct 2019 09:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570355444;
        bh=IEIOaPM0gWMqpc0zX16Dpknqo7eoR6bXroNx94NIjbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fDoRXRDUAh3f/Wl8m8Vf/KnM7I7dINcMPAD41WRI3EoYkS1D+NMGcmB+k9CX7T2PK
         YOne+95KYCGaaeOr69HmTnV84fF9HvNyvZgp8P2J5UAb3spb29Ecs9IvXfWJ9wxrv7
         gLk7BTpwXrYWdzyS2zRz5WHW2PRUyH63LCHWwe8o=
Date:   Sun, 6 Oct 2019 11:50:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, johan@kernel.org,
        elder@kernel.org, greybus-dev@lists.linaro.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: add blank line after declarations
Message-ID: <20191006095042.GA2918514@kroah.com>
References: <20191005210046.27224-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191005210046.27224-1-gabrielabittencourt00@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2019 at 06:00:46PM -0300, Gabriela Bittencourt wrote:
> Fix CHECK: add blank line after declarations
> 
> Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
> ---
>  drivers/staging/greybus/control.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/greybus/control.h b/drivers/staging/greybus/control.h
> index 3a29ec05f631..5a45d55349a1 100644
> --- a/drivers/staging/greybus/control.h
> +++ b/drivers/staging/greybus/control.h
> @@ -24,6 +24,7 @@ struct gb_control {
>  	char *vendor_string;
>  	char *product_string;
>  };
> +
>  #define to_gb_control(d) container_of(d, struct gb_control, dev)

No, the original code is "better" here, it's a common pattern despite
what checkpatch.pl tells you, sorry.

thanks,

greg k-h
