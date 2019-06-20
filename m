Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A735D4D80C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 20:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfFTSWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 14:22:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55181 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfFTSWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:22:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id g135so3983455wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 11:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6W69Du1bctBdAeWrQSZ50pOOXCwaxniMxHy/YbHqEqI=;
        b=JICpQbU5muSaMtq1JB5VHNGLUk8jq3GGBHMiNUcw23ZBGD91CH2nTZBoRUjsuDGAVT
         HJIZBXEoJE+TVP+YgbXTHwtMgd2rAmWJxaNZ8RcAgDR9Z1sMjuss+1HsQtsInCd0+03t
         In0ETrRALkN8OAWS22SMSF+hsKL4ynnzIiMIzZlzKtlmThca1O3VmBMcNird/HI8Yt+u
         Jf1KYASutl7mZG4sEy8uTBX4FTwS27OgA/SP95K3IQhbIiopmXI2bm+0x0oYHaxSUyiF
         mT/G68xQfAwPH+DK4LFFzXcsR9mbHRIm+o5AMVNheK8HwJgeIPlOerpn9B8GTjWuqA1P
         FuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6W69Du1bctBdAeWrQSZ50pOOXCwaxniMxHy/YbHqEqI=;
        b=YVtcJyBhEbtxTJ6avBBay1XXQzkvI7DuFlfxPkiv4fp3/lxX9Md4WF3tD/ICHmB4ft
         TAPw36pO1WSd9ShgOwQ9Is04L8UmqSgrCt5KbHfZlLicx+ucf4FyOSiAsZIoPBemGwx6
         GxaGShrTqUB2yryzjIvoe8ipTNsI7Nqr1dVU6twYeTaHchW7m2F2QpHjWGIt8Y0O+jTF
         kf2rpN8QtU/M7YceI6cao8QsShpNu5OhDxQjcD5AVR7BzyHR7nkbHrZQ/YoQehg63Vup
         FeqeNNbkW+mtqOfPqo1RcbyTWlS8aMzhoCzP6Zn/kpOZ1h+3YbRsajdnOb8RjG0uvuCW
         Qe3A==
X-Gm-Message-State: APjAAAWOGHhPH9ta5LqWchKSaJVn9936p9VLB48MKJ/tzVFIxdAROH++
        vx2ne0I+7Hb3FOZr1QZqc5wO8zerJqAPyhDn/73F
X-Google-Smtp-Source: APXvYqztEC3ToiRcw+BN0gYrgLc79Cen4f6cFKKe1+9L7Veg67QIX9zR7+/BxyQbhLEPicpGGpytgYQSxRHRZ1v9Nk0=
X-Received: by 2002:a1c:1a88:: with SMTP id a130mr556373wma.149.1561054963668;
 Thu, 20 Jun 2019 11:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561050806.git.mchehab+samsung@kernel.org> <3b8d7c64f887ddea01df3c4eeabc745c8ec45406.1561050806.git.mchehab+samsung@kernel.org>
In-Reply-To: <3b8d7c64f887ddea01df3c4eeabc745c8ec45406.1561050806.git.mchehab+samsung@kernel.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu, 20 Jun 2019 13:22:31 -0500
Message-ID: <CAErSpo5+MH4t0OVZkuLykZhiQg-3itaozeXO6v=nnc6e1UvCSw@mail.gmail.com>
Subject: Re: [PATCH v2 01/22] ABI: sysfs-bus-pci-devices-aer_stats uses an
 invalid tag
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 12:23 PM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> According with Documentation/ABI/, the right tag to describe
> an ABI symbol is "What:", and not "Where:".
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume somebody else will merge this series as a whole.

> ---
>  .../ABI/testing/sysfs-bus-pci-devices-aer_stats      | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> index 4b0318c99507..ff229d71961c 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> +++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> @@ -9,7 +9,7 @@ errors may be "seen" / reported by the link partner and not the
>  problematic endpoint itself (which may report all counters as 0 as it never
>  saw any problems).
>
> -Where:         /sys/bus/pci/devices/<dev>/aer_dev_correctable
> +What:          /sys/bus/pci/devices/<dev>/aer_dev_correctable
>  Date:          July 2018
>  Kernel Version: 4.19.0
>  Contact:       linux-pci@vger.kernel.org, rajatja@google.com
> @@ -31,7 +31,7 @@ Header Log Overflow 0
>  TOTAL_ERR_COR 2
>  -------------------------------------------------------------------------
>
> -Where:         /sys/bus/pci/devices/<dev>/aer_dev_fatal
> +What:          /sys/bus/pci/devices/<dev>/aer_dev_fatal
>  Date:          July 2018
>  Kernel Version: 4.19.0
>  Contact:       linux-pci@vger.kernel.org, rajatja@google.com
> @@ -62,7 +62,7 @@ TLP Prefix Blocked Error 0
>  TOTAL_ERR_FATAL 0
>  -------------------------------------------------------------------------
>
> -Where:         /sys/bus/pci/devices/<dev>/aer_dev_nonfatal
> +What:          /sys/bus/pci/devices/<dev>/aer_dev_nonfatal
>  Date:          July 2018
>  Kernel Version: 4.19.0
>  Contact:       linux-pci@vger.kernel.org, rajatja@google.com
> @@ -103,19 +103,19 @@ collectors) that are AER capable. These indicate the number of error messages as
>  device, so these counters include them and are thus cumulative of all the error
>  messages on the PCI hierarchy originating at that root port.
>
> -Where:         /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_cor
> +What:          /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_cor
>  Date:          July 2018
>  Kernel Version: 4.19.0
>  Contact:       linux-pci@vger.kernel.org, rajatja@google.com
>  Description:   Total number of ERR_COR messages reported to rootport.
>
> -Where:     /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_fatal
> +What:      /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_fatal
>  Date:          July 2018
>  Kernel Version: 4.19.0
>  Contact:       linux-pci@vger.kernel.org, rajatja@google.com
>  Description:   Total number of ERR_FATAL messages reported to rootport.
>
> -Where:     /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_nonfatal
> +What:      /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_nonfatal
>  Date:          July 2018
>  Kernel Version: 4.19.0
>  Contact:       linux-pci@vger.kernel.org, rajatja@google.com
> --
> 2.21.0
>
