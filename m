Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD2C3FEC78
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2019 14:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfKPNix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Nov 2019 08:38:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:49370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727550AbfKPNiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 08:38:52 -0500
Received: from localhost (unknown [84.241.192.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1EB0206D4;
        Sat, 16 Nov 2019 13:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573911532;
        bh=gci994AaOD042gwx45qSUayCaGQNJRTbBIZw0AMtQgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jcXxsQB66dHaomQQGlWE97weyHvZ5fH+lVWQ1XN2jYqReLmDo8u3RY9kE9tni2Ugo
         /jMGz6bh/o/QH2Rmms8QJyqWxfuPa1HkV3LVHPQPTHNTbJ0SMeQC2a4QNY19Y62ZlL
         YFOeA+gS+3r1nUHYI7rKeO+YJeWTZs6pHLHsgv9o=
Date:   Sat, 16 Nov 2019 14:38:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     patrick.rudolph@9elements.com
Cc:     linux-kernel@vger.kernel.org, coreboot@coreboot.org,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Arthur Heymans <arthur@aheymans.xyz>
Subject: Re: [PATCH 1/3] firmware: google: Release devices before
 unregistering the bus
Message-ID: <20191116133849.GC454551@kroah.com>
References: <20191115134842.17013-1-patrick.rudolph@9elements.com>
 <20191115134842.17013-2-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115134842.17013-2-patrick.rudolph@9elements.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 02:48:37PM +0100, patrick.rudolph@9elements.com wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Fix a bug where the kernel module can't be loaded after it has been
> unloaded as the devices are still present and conflicting with the
> to be created coreboot devices.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---
>  drivers/firmware/google/coreboot_table.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
> index 8d132e4f008a..88c6545bebf4 100644
> --- a/drivers/firmware/google/coreboot_table.c
> +++ b/drivers/firmware/google/coreboot_table.c
> @@ -163,8 +163,14 @@ static int coreboot_table_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static int __cb_dev_unregister(struct device *dev, void *dummy)
> +{
> +	device_unregister(dev);

Did you build this patch???

Did it work when you tested it?  How?

Please fix up,

greg k-h
