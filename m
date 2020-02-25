Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F26D316EB82
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 17:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbgBYQdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 11:33:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33424 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730628AbgBYQde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 11:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=YKyZV60LHUuQnl24YQ6e7CN9lTy1VXZjsH7/atkgKsQ=; b=lTpmZeZ1NeoF6dscoMg4qMMjFo
        glMYR+C65qyUo9XeiQnzabqMC7yYHKugSV9aEx4q2bfFnZyr60vQTPd8Kf/UhIZHUNcyam1POEBuV
        vc/XzzQPk9KxrdLDFtulgA59QtmYM/nSoKY4M8hCrdgHzDIvGeHtdBbx3djNmAjsMXAJZ/StGa7NN
        irttrCy8WbAwz9vC0ihJM9pKB+D4cUL66aIEflu+R+kwLj/fk2IJFu00pZUU9NXQWT7cfHRG6UqXl
        VI2pdKL1/UdqS7wLaZFULOlPOs3YIA62BCA2etGDwY1DXdGVw//V6KKMAQ/UJkqIljws5M5knWV93
        oUNXOZTA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6d9G-0007zL-Uv; Tue, 25 Feb 2020 16:33:31 +0000
Subject: Re: [PATCH] Initialize ATA before graphics
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-nvme@lists.infradead.org,
        Arjan van de Ven <arjan@linux.intel.com>
References: <041f4abd-f894-b990-b320-bf0aab4242f2@molgen.mpg.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0da5bb70-2e55-0fa2-d950-3832f9ff7bcd@infradead.org>
Date:   Tue, 25 Feb 2020 08:33:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <041f4abd-f894-b990-b320-bf0aab4242f2@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,
You should have also Cc-ed Arjan on this email. [done]


On 2/24/20 6:09 AM, Paul Menzel wrote:
> From: Arjan van de Ven <arjan@linux.intel.com>
> Date: Thu, 2 Jun 2016 23:36:32 -0500
> 
> ATA init is the long pole in the boot process, and its asynchronous.
> Move the graphics init after it, so that ATA and graphics initialize
> in parallel.
> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
> 
> 1.  Taken from Clear Linux: https://github.com/clearlinux-pkgs/linux/commits/master/0110-Initialize-ata-before-graphics.patch
> 2.  Arjan, can you please add your Signed-off-by line?
> 
>  drivers/Makefile | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/Makefile b/drivers/Makefile
> index aaef17c..d08f3a3 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -58,15 +58,8 @@ obj-y                                += char/
>  # iommu/ comes before gpu as gpu are using iommu controllers
>  obj-y                          += iommu/
>  
> -# gpu/ comes after char for AGP vs DRM startup and after iommu
> -obj-y                          += gpu/
> -
>  obj-$(CONFIG_CONNECTOR)                += connector/
>  
> -# i810fb and intelfb depend on char/agp/
> -obj-$(CONFIG_FB_I810)           += video/fbdev/i810/
> -obj-$(CONFIG_FB_INTEL)          += video/fbdev/intelfb/
> -
>  obj-$(CONFIG_PARPORT)          += parport/
>  obj-$(CONFIG_NVM)              += lightnvm/
>  obj-y                          += base/ block/ misc/ mfd/ nfc/
> @@ -79,6 +72,14 @@ obj-$(CONFIG_IDE)            += ide/
>  obj-y                          += scsi/
>  obj-y                          += nvme/
>  obj-$(CONFIG_ATA)              += ata/
> +
> +# gpu/ comes after char for AGP vs DRM startup and after iommu
> +obj-y                          += gpu/
> +
> +# i810fb and intelfb depend on char/agp/
> +obj-$(CONFIG_FB_I810)           += video/fbdev/i810/
> +obj-$(CONFIG_FB_INTEL)          += video/fbdev/intelfb/
> +
>  obj-$(CONFIG_TARGET_CORE)      += target/
>  obj-$(CONFIG_MTD)              += mtd/
>  obj-$(CONFIG_SPI)              += spi/
> 


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
