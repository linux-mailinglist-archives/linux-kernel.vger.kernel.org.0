Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C655A108CA5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 12:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfKYLJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 06:09:20 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40904 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbfKYLJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 06:09:20 -0500
Received: by mail-pj1-f66.google.com with SMTP id ep1so6453157pjb.7;
        Mon, 25 Nov 2019 03:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3RKvLOzF9+MmABc+PUEDXQ5lz3mg8l+5+Zx2PV1HpuY=;
        b=Zv0LlB1InIJ7QdZg4B+r05QW5D5Y3/YdMR63Vn5uiikkZ+b3P1JKYpZowVgoG0RVq7
         6h9VJuFmgTLyXaZUojuf5axn4e5fI5foANkXSpqXyoDdBk+CO79P4B0vPYZfj+yr/wH8
         gKHiEHpssNfoJ6v7pH4F58bjPP0zXj0PbkUKkLBwcAkEtyuT7NFCs1qJd70vi2IAjFs0
         LHEDhSRSaRASRf0jWXZwGGwqLjq6aPSaidH2WN3zUKxC5bQdVKYYvZOOJ5dy316xvtnG
         Vy2fdigpvWUqYjOs7dvSpXQ7V1i2gmWQVLvelND2pqq2DUgSOqH8i/F3eSMydypcFBvm
         srhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3RKvLOzF9+MmABc+PUEDXQ5lz3mg8l+5+Zx2PV1HpuY=;
        b=NqBjNCzCpPWTXAlPgtUm6Hi3Ih4P8UVNpx/G86f6DNnznJGjnOFeZLLEiG5eS+rDhq
         gMI8cD5YFGkXhRYlfOUJS+DZQB3UVQSn6ue5k8gb3Gc/3PXlUXXWFPS/f6cMJDfvEVff
         y7UqOlcnaPiYKRCwNDl4H8d7KG3qU1cQPophZKKjNpJqG8gwsixVSDqSxBxi+51xEELv
         EorbWJAI2PVROHV2G2kBNt9phUrm23BZAg7ni+c+nOMIQ4kgwRZhGWjBlZb4DC5djw38
         W8XFrb3Hk4INt0H9kuraxagUBIrGgS11xJrOjIDARq3bKD0Huvqao8FsJTPLX2Uas+cH
         62OA==
X-Gm-Message-State: APjAAAVrcQVdr0fIUW1wKPOQ213D2G5inbvl/01I8leNwbjzQ26NxA2E
        braA83w5a5ZbQTQUe/E3rFR8KC8eBUF9czelKoo=
X-Google-Smtp-Source: APXvYqz3UC3+6qpjJn7Nqp9Uln3MDVv+yzBF5D/05BEtOGJJse5Ldc7bJGdhz69pWKVV6bGLUNIHHUBQZZiXrJ4qa+4=
X-Received: by 2002:a17:902:9889:: with SMTP id s9mr28430329plp.18.1574680158260;
 Mon, 25 Nov 2019 03:09:18 -0800 (PST)
MIME-Version: 1.0
References: <20191124140625.20736-1-leonmaxx@gmail.com>
In-Reply-To: <20191124140625.20736-1-leonmaxx@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Nov 2019 13:09:08 +0200
Message-ID: <CAHp75VeD4bKLrhnWw6vPa_K7QQXGsvyD3COZb9FwripOVAawvQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] platform/x86 asus_wmi: Support of ASUS TUF laptops
 on Ryzen CPUs
To:     Leonid Maksymchuk <leonmaxx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Chris Chiu <chiu@endlessm.com>,
        Kristian Klausen <kristian@klausen.dk>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Corentin Chary <corentin.chary@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 24, 2019 at 4:07 PM Leonid Maksymchuk <leonmaxx@gmail.com> wrote:
>
> Hi,
>
> this patch series adds support of Throttle themal policy ACPI device to
> existing asus_wmi platform driver. Support of this device is required
> for ASUS TUF laptops on Ryzen CPUs to properly work on Linux.
>

In both patches you forgot a colon after platform/x86 prefix.

> v2: fixed indentation.
> v3: patches 2/3 and 3/3 are refactored.
> v4: patch 2/3 are simplified.
> v5: add new device instead of merging with fan boost mode
>
> Leonid Maksymchuk (2):
>   platform/x86 asus_wmi: Support throttle thermal policy
>   platform/x86 asus_wmi: Set throttle thermal policy to default
>
>  drivers/platform/x86/asus-wmi.c            | 128 +++++++++++++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h |   1 +
>  2 files changed, 129 insertions(+)
>
> --
> 1.8.3.1
>


-- 
With Best Regards,
Andy Shevchenko
