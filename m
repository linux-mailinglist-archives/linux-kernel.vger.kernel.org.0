Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7689B7328
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 08:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388075AbfISG11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 02:27:27 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33847 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387929AbfISG10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 02:27:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id d3so1130903plr.1;
        Wed, 18 Sep 2019 23:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zYC9c0xzUXu9+1JCCZ/6grej11cpKjpeT/pQEN2qRIM=;
        b=L4XqqS3n1K8UuyE00P2dcioyr7f2tslP+5gokPZOLa18lUOudGiu7ALFKe15xvlfUo
         7vjfPuTuRyxc1/7y6sQSdrxfnIwkjzl/YYHWQX6V+CyxEXY46YqKUO2kjkbmHjkvXTVq
         7tUPBr8X3Sa2LFFNwpbdbPWtfM22lzEFRdvGaZAB69HTMk5Dm0q1WYnKoZtlPgHiEk0e
         KqffXAPAXw5JJCO0AMNRepTrcA8IxeJHpDz8Z7zok2jwhu/Dt3Ur2QnLFcUVJ3lzRpQW
         KmzfJqTPjj9fcUAXsDCxwYnVUYc7Vro8fQAyiGoN5XpP0sZsiuqi9qR1/B1ymX1VKGvM
         2Y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zYC9c0xzUXu9+1JCCZ/6grej11cpKjpeT/pQEN2qRIM=;
        b=Ne36q+C1wjSjhQbgu9Qf+xAx8Yrm3Xai6FUYs5nTfG6GMxP582+Q+fFV1MCmA+iYTx
         rORv+bVFu9R8/h85edCIrN6QlakkvfaQAn2L2qsWXm1n+PclTl72qHHvLDf29cYJFX+e
         PDIRpVpQugdb0L6+T+fDYZOyFm5ny8e6gNn90wDdmcpIjCkB2axERkYLEel4UVi6EZvn
         mZIr16OSS0BoQjjnmL657Cg2TG8ihSy11z47yrbzLXgvF65MofANcXeJeP9DcMHu8HDB
         p45DZwXshLYAy3UnLcenM/p73jSfY4dIttmIUgJuudOnm/NlOlWbV5egTiu+CYFWvJAz
         yy3A==
X-Gm-Message-State: APjAAAX6O+WbWn7JSjeqBWZMWFm0h0fgD8udE6bS340EXhCMp2d0sd5J
        dw/XanWgb2Etj2u1d5gRIqyDlhQeo2hd6HMurU0=
X-Google-Smtp-Source: APXvYqxqc5vMu+781v0PNAPt9FTbqLzUtIJNkufAV5+W4y8Md/hvxxXV5jBa5HhjvMAAvilAX5BBhy0UNuW0xh+HNoA=
X-Received: by 2002:a17:902:b208:: with SMTP id t8mr8179629plr.262.1568874445884;
 Wed, 18 Sep 2019 23:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190918225337.9860-1-jekhor@gmail.com> <20190918225337.9860-2-jekhor@gmail.com>
In-Reply-To: <20190918225337.9860-2-jekhor@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 19 Sep 2019 09:27:14 +0300
Message-ID: <CAHp75Ve1mifO9iJJUo=zdFYi3X20ye=w1p0Z+-GmjQEpnmiS4Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] platform/x86/intel_cht_int33fe: Split code to USB
 Micro-B and Type-C variants
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 1:53 AM Yauhen Kharuzhy <jekhor@gmail.com> wrote:
>

You so fast with new versions that I had no chance to comment on.
Finally here mine.

> Existing intel_cht_int33fe ACPI pseudo-device driver assumes that
> hardware has Type-C connector and register related devices described as
> I2C connections in the _CRS resource.
>
> There is at least one hardware (Lenovo Yoga Book YB1-91L/F) with Micro-B
> USB connector exists. It has INT33FE device in the DSDT table but
> there are only two I2C connection described: PMIC and BQ27452 battery
> fuel gauge.
>
> Splitting existing INT33FE driver allow to maintain code for USB Micro-B
> (AB) connector variant separately and make it simpler.

I didn't get what (AB) means in this context?
Did you mean "(or AB)"?

> Split driver to intel_cht_int33fe_common.c and
> intel_cht_int33fe_{typeb,typec}.c. Compile all this sources to one .ko
> module to make user experience easier.

You forgot to replace typeb here.

> -       ---help---
> +       help

This is unneeded churn



> +         CONFIG_BATTERY_BQ27XXX=m and CONFIG_BATTERY_BQ27XXX_I2C=m for Micro-B
> +         device and CONFIG_TYPEC_FUSB302=m and CONFIG_BATTERY_MAX17042=m

First s/and/or/.

> +         for Type-C device.

> + * 1. The Whiskey Cove pmic, which is also described by the INT34D3 ACPI device

pmic -> PMIC

> +       if (IS_ERR(data->battery_fg)) {
> +               int err = PTR_ERR(data->battery_fg);
> +
> +               if (err != -EPROBE_DEFER)
> +                       dev_err(dev,
> +                               "Failed to register battery fuel gauge: %d\n",
> +                               err);
> +               return err;
> +       }
> +
> +       return 0;

I would rather replace this altogether by return PTR_ERR_OR_ZERO()
like it's done in the other function in the original driver.

-- 
With Best Regards,
Andy Shevchenko
