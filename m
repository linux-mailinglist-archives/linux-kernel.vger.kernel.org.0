Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3F33B4A0C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 11:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfIQJGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 05:06:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38700 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfIQJGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 05:06:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id o184so2155923wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 02:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nFF/4XckwgtJQC2Enr9cy65XMeRaKHCD6+b4rJzMQBQ=;
        b=NQI/irYOEC0oW/wTvSbDnELKuUZeOpofWBHyAhmiMiiCEhNSbh4NplUrKqmII7kbWC
         Q4G0P/l5i1MupUFwmcu5DFteIib7wU9MgNHMUaJNFixmlxPAuWXylmdDQaCiOe+sUrE5
         3QiGm0Cb9e3q9ReqXGQfHfbfieGrxLaGWXul+xuyxl3/GHazE3oNK4MuKLHF/yl7sIRb
         cNmsdVTLAKDGWytATZvP9VG1BS/7B2/RW4Kpxf0PJlzq/qask3x/4+rfYwpeNktmfig9
         7vGPKDGgIRohp3hTtYv4y31AnvclEPpAmC3ZSAP+4t7z7IMHQl3Ddb8iyh9/KTiaJSpR
         OXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nFF/4XckwgtJQC2Enr9cy65XMeRaKHCD6+b4rJzMQBQ=;
        b=RoosrVzhtWqV7C6qp475Pyw/jOwZuo991qQl7SqOhS+hkUlnyW/s9SdM5JlZU2e5rY
         RkSXSNfSlgLo+0F3D4XJucbwlN07EqZl9JALExmmgLKAh0lwAYFZhaKxR0P91vWxgjxM
         aLOxhbi/05dqmzuVlBkACPWHUAPXzWM2cQva72ENZZxrNss4s36IUezuIs+70rWu9i3C
         cE2bsz0QQ+X8iH3d0b1+zn6UbtNaWkGIJctE+KHFGWElSbj5ZQgDSCimVNdrz2OAqN+U
         cnY4Zi+dd0ZnWEnEpBVOLd11apw4sNsbmiVIEoGCS7BPyPKxj8qVUTxHYFjVQxaHa1NX
         nBGg==
X-Gm-Message-State: APjAAAWr2sjeEtu7UwMuKwkuoWFGDF0fCS9JMUzqWaGad3/u9v0rK89m
        Hp4+kriIT9No3XBEy5KYo2JD7+YBSiW7VctGLYhvAA==
X-Google-Smtp-Source: APXvYqy2Qpxco8CrOgIuQYRcL2hUkHM8zw0gIl2jvM254AOtptuMeubrSXnRgxqPY7xMUBI6qgrs+ImepthxQ7sZ4Us=
X-Received: by 2002:a1c:4384:: with SMTP id q126mr2837215wma.153.1568711177926;
 Tue, 17 Sep 2019 02:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190916204158.6889-1-efremov@linux.com> <20190916204158.6889-19-efremov@linux.com>
In-Reply-To: <20190916204158.6889-19-efremov@linux.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 17 Sep 2019 11:06:06 +0200
Message-ID: <CAMGffEk6=EoJTHKgsJzNs27mUdSj2zin5N8MsdtOK5rZh17JeQ@mail.gmail.com>
Subject: Re: [PATCH v3 18/26] scsi: pm80xx: Use PCI_STD_NUM_BARS
To:     Denis Efremov <efremov@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 10:47 PM Denis Efremov <efremov@linux.com> wrote:
>
> Replace the magic constant (6) with define PCI_STD_NUM_BARS representing
> the number of PCI BARs.
>
> Cc: Jack Wang <jinpu.wang@cloud.ionos.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Signed-off-by: Denis Efremov <efremov@linux.com>
Looks fine, thanks!
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/scsi/pm8001/pm8001_hwi.c  | 2 +-
>  drivers/scsi/pm8001/pm8001_init.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
> index 68a8217032d0..1a3661d6be06 100644
> --- a/drivers/scsi/pm8001/pm8001_hwi.c
> +++ b/drivers/scsi/pm8001/pm8001_hwi.c
> @@ -1186,7 +1186,7 @@ static void pm8001_hw_chip_rst(struct pm8001_hba_info *pm8001_ha)
>  void pm8001_chip_iounmap(struct pm8001_hba_info *pm8001_ha)
>  {
>         s8 bar, logical = 0;
> -       for (bar = 0; bar < 6; bar++) {
> +       for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
>                 /*
>                 ** logical BARs for SPC:
>                 ** bar 0 and 1 - logical BAR0
> diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
> index 3374f553c617..aca913490eb5 100644
> --- a/drivers/scsi/pm8001/pm8001_init.c
> +++ b/drivers/scsi/pm8001/pm8001_init.c
> @@ -401,7 +401,7 @@ static int pm8001_ioremap(struct pm8001_hba_info *pm8001_ha)
>
>         pdev = pm8001_ha->pdev;
>         /* map pci mem (PMC pci base 0-3)*/
> -       for (bar = 0; bar < 6; bar++) {
> +       for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
>                 /*
>                 ** logical BARs for SPC:
>                 ** bar 0 and 1 - logical BAR0
> --
> 2.21.0
>


-- 
Jack Wang
Linux Kernel Developer
Platform Engineering Compute (IONOS Cloud)
