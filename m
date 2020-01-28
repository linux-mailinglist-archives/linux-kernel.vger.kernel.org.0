Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C41114BEEC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 18:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgA1RvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 12:51:17 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:34764 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgA1RvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 12:51:17 -0500
Received: by mail-io1-f65.google.com with SMTP id z193so15360275iof.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 09:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yzboYpUm2NHrNXjdOkZz9gUvbP91cmk09HeOAkmzxck=;
        b=kjeTt6Lae+yXJVpPn6kBnijTjViSXoHH/hn6rqj1xXt8ZDsqnsygPnw260Q0jrP1Ko
         R56Jt8rpcHez0C8NeqRMmbWkZTkimEAgE3n+7hxA3XFz1iecXRVlFlopTB6nP3HfSotx
         OJdiQ5EpMris9LSiDkRsFHNks1bcNUp50t603t38RzXr1n9OrdtnSrDrwq9gER64mPU9
         9EGKuaQe/qAyr3ZA/Bi2BQ27hyGKzKliQGJD/jvjaOKUC4D0yi1+D8kazYFHjEH9HuR3
         BsA8beTB9pgoGwejzT7c9qX98fsZzDPjqAqj+1m8/kYsGahJPaLsZikpu70R3uGJgbNK
         C9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yzboYpUm2NHrNXjdOkZz9gUvbP91cmk09HeOAkmzxck=;
        b=tE05PFj8Cwn3LjCdrezPBq+/s+jtWirwdE5RIZA8IhHktZ7SDJq9n8uKRo5t5xUqxv
         32SCum8snVtPr4gIcsIX++V8LgBoCuDumJ3YRsL9TJLQjPARDwj9ffs88hvl9XZn7e2g
         iAYUWYfU/gzU+Z3IFivUx7wEcbKBPHbiJ3+ZWsrF57AFkMv5KCCGKItRsY2i4wVjxxmF
         3kprsW1VCV5jCYV1Yaw72KmQEXAZL55ZjK8gDyRQ10FJX/WUJ9XiMygHfc9TONzo3c0d
         N54zFOwQjRLWC5QF19ekmOBwKsLKSYcwB81A3Y75emhPSmp2Xxl8gNs8O3hXiFejH7oP
         QeSQ==
X-Gm-Message-State: APjAAAXohU4ZIMxF9IbwPi73BZ58s0fRMIobuetUpXZSYUNLFXv7OSv9
        Xi8lBsNg4CbBjN3DOzA18zohju/KwvkKk8C2hW0lSw==
X-Google-Smtp-Source: APXvYqwbEiJFE2jfQRGcTMflEcecZ9yJMLXO38LB9PmG0x1wyDZq2K6SaZ4NolfLhlBtezFUXdhnLmha9p7ITFn7YqY=
X-Received: by 2002:a5d:9c8c:: with SMTP id p12mr17084437iop.72.1580233876063;
 Tue, 28 Jan 2020 09:51:16 -0800 (PST)
MIME-Version: 1.0
References: <1580210059-199540-1-git-send-email-john.garry@huawei.com> <1580210059-199540-3-git-send-email-john.garry@huawei.com>
In-Reply-To: <1580210059-199540-3-git-send-email-john.garry@huawei.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 28 Jan 2020 09:51:04 -0800
Message-ID: <CAOesGMiCVSvL8H+haLoz=xyiX1CxBSRL_pbCgx-DLhN+5xRn9g@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] soc: Add a basic ACPI generic driver
To:     John Garry <john.garry@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, jeremy.linton@arm.com,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 28, 2020 at 3:18 AM John Garry <john.garry@huawei.com> wrote:
>
> Add a generic driver for platforms which populate their ACPI PPTT
> processor package ID Type Structure according to suggestion in the ACPI
> spec - see ACPI 6.2, section 5.2.29.3 ID structure Type 2.
>
> The soc_id is from member LEVEL_2_ID.
>
> For this, we need to use a whitelist of platforms which are known to
> populate the structure as suggested.
>
> For now, only the vendor and soc_id fields are exposed.
>
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/soc/Makefile       |   1 +
>  drivers/soc/acpi_generic.c | 102 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 103 insertions(+)
>  create mode 100644 drivers/soc/acpi_generic.c
>
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 8b49d782a1ab..2a59a30a22cd 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -3,6 +3,7 @@
>  # Makefile for the Linux Kernel SOC specific device drivers.
>  #
>
> +obj-$(CONFIG_ACPI_PPTT)                += acpi_generic.o
>  obj-$(CONFIG_ARCH_ACTIONS)     += actions/
>  obj-$(CONFIG_SOC_ASPEED)       += aspeed/
>  obj-$(CONFIG_ARCH_AT91)                += atmel/

Based on everything I've seen so far, this should go under drivers/acpi instead.

> diff --git a/drivers/soc/acpi_generic.c b/drivers/soc/acpi_generic.c
> new file mode 100644
> index 000000000000..34a1f5f8e063
> --- /dev/null
> +++ b/drivers/soc/acpi_generic.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) John Garry, john.garry@huawei.com
> + */
> +
> +#define pr_fmt(fmt) "SOC ACPI GENERIC: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/sys_soc.h>
> +
> +/*
> + * Known platforms that fill in PPTT package ID structures according to
> + * ACPI spec examples, that being:
> + * - Custom driver attribute is in ID Type Structure VENDOR_ID member
> + * - SoC id is in ID Type Structure LEVEL_2_ID member
> + *    See ACPI SPEC 6.2 Table 5-154 for PPTT ID Type Structure
> + */
> +static struct acpi_platform_list plat_list[] = {
> +       {"HISI  ", "HIP08   ", 0, ACPI_SIG_PPTT, all_versions},
> +       { } /* End */
> +};

As others have said, this will become a mess over time, and will
require changes for every new platform. Which, unfortunately, is
exactly what ACPI is supposed to provide relief from by making
standardized platforms... standardized.

> +
> +struct acpi_generic_soc_struct {
> +       struct soc_device_attribute dev_attr;
> +       u32 vendor;
> +};
> +
> +static ssize_t vendor_show(struct device *dev,
> +                          struct device_attribute *attr,
> +                          char *buf)
> +{
> +       struct acpi_generic_soc_struct *soc = dev_get_drvdata(dev);
> +       u8 vendor_id[5] = {};
> +
> +       *(u32 *)vendor_id = soc->vendor;
> +
> +       return sprintf(buf, "%s\n", vendor_id);
> +}
> +
> +static DEVICE_ATTR_RO(vendor);
> +
> +static __init int soc_acpi_generic_init(void)
> +{
> +       int index;
> +
> +       index = acpi_match_platform_list(plat_list);
> +       if (index < 0)
> +               return -ENOENT;
> +
> +       index = 0;
> +       while (true) {
> +               struct acpi_pptt_package_info info;
> +
> +               if (!acpi_pptt_get_package_info(index, &info)) {
> +                       struct soc_device_attribute *soc_dev_attr;
> +                       struct acpi_generic_soc_struct *soc;
> +                       struct soc_device *soc_dev;
> +                       u8 soc_id[9] = {};
> +
> +                       *(u64 *)soc_id = info.LEVEL_2_ID;
> +
> +                       soc = kzalloc(sizeof(*soc), GFP_KERNEL);
> +                       if (!soc)
> +                               return -ENOMEM;
> +
> +                       soc_dev_attr = &soc->dev_attr;
> +                       soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%s",
> +                                                        soc_id);
> +                       if (!soc_dev_attr->soc_id) {
> +                               kfree(soc);
> +                               return -ENOMEM;
> +                       }
> +                       soc->vendor = info.vendor_id;
> +
> +                       soc_dev = soc_device_register(soc_dev_attr);
> +                       if (IS_ERR(soc_dev)) {
> +                               int ret = PTR_ERR(soc_dev);
> +
> +                               pr_info("could not register soc (%d) index=%d\n",
> +                                       ret, index);
> +                               kfree(soc_dev_attr->soc_id);
> +                               kfree(soc);
> +                               return ret;
> +                       }
> +                       dev_set_drvdata(soc_device_to_device(soc_dev), soc);
> +                       device_create_file(soc_device_to_device(soc_dev),
> +                                          &dev_attr_vendor);

Hmm, this doesn't look like much of a driver to me. This looks like
the export of an attribute to userspace, and should probably be done
by ACPI core instead of creating an empty driver for it.

This would also solve the whitelist issue -- always export this
property if it's set. If it's wrong, then the platform vendor needs to
fix it up. That's the approach that is used for other aspects of the
standardized platforms, right? We don't want to litter the kernel with
white/blacklists -- that's not a net improvement.


-Olof
