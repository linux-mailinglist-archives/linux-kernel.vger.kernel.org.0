Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45E249053F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 18:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfHPQCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 12:02:21 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:36434 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbfHPQCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 12:02:19 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23992741AbfHPQCQmL3Md (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 18:02:16 +0200
Date:   Fri, 16 Aug 2019 18:02:15 +0200
From:   Ladislav Michl <ladis@linux-mips.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     vkoul@kernel.org, sanyog.r.kale@intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH -next] soundwire: Fix -Wunused-function
 warning
Message-ID: <20190816160215.GA6048@lenoch>
References: <20190816141409.49940-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816141409.49940-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 10:14:09PM +0800, YueHaibing wrote:
> If CONFIG_ACPI is not set, gcc warning this:
> 
> drivers/soundwire/slave.c:16:12: warning:
>  'sdw_slave_add' defined but not used [-Wunused-function]
> 
> move them to #ifdef CONFIG_ACPI block.

...and that makes slave.c empty, right? So it boils down to
obj-$(CONFIG_ACPI) += slave.o

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/soundwire/slave.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
> index f39a581..34c7e65 100644
> --- a/drivers/soundwire/slave.c
> +++ b/drivers/soundwire/slave.c
> @@ -6,6 +6,7 @@
>  #include <linux/soundwire/sdw_type.h>
>  #include "bus.h"
>  
> +#if IS_ENABLED(CONFIG_ACPI)
>  static void sdw_slave_release(struct device *dev)
>  {
>  	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> @@ -60,7 +61,6 @@ static int sdw_slave_add(struct sdw_bus *bus,
>  	return ret;
>  }
>  
> -#if IS_ENABLED(CONFIG_ACPI)
>  /*
>   * sdw_acpi_find_slaves() - Find Slave devices in Master ACPI node
>   * @bus: SDW bus instance
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
