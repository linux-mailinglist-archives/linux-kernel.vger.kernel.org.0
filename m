Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB4771802FB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 17:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgCJQQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 12:16:35 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:51438 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbgCJQQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 12:16:34 -0400
Received: by mail-pj1-f67.google.com with SMTP id y7so620091pjn.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 09:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DOrOSAeLspFbYbXz9Qm/Iq7jD9WCeEQR9ClLCc8oPgE=;
        b=Glbfrsj7qXW4XMlk6izswgcTuUnOnVPLyYa+uub7K5RG2kDn5MM0jlfIGlnZa/a6Fi
         JM7faDFxwn2OwVOjimQ+/BpZYEcYWVo7+hehHp33EXuY6cTKoNTj4TTsV8zAv4SGPyUQ
         5IIqAms0w7M4YbMKtFuwtietZSDqNxSCfixoS2bgiOxUt/vDX7z7uSd/dzQFRcoSbw6/
         TrxDPnGIbTPpgQ6OoiFEuVxyHy6iTF+/gx5LxgHIPwyrauhRWVBQIfyqhERtmrkdWkrP
         lrYf/iyLB801FKeNh6HwLe+SV1oEnX9PcILV3bZPELG+kM1bZq9Q1ml/CXQ7FZaCFkt7
         Deeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DOrOSAeLspFbYbXz9Qm/Iq7jD9WCeEQR9ClLCc8oPgE=;
        b=fsn35dq6SwDgn0xIABdLfAf0Ak9VCZa3K0mrcOvAqJ+qjc1roLY0W96jj9ViCER23q
         LhJY5j5yrrcjqkkoC0sgETX3oMZRCscwlqNmJH5s36VhIIImeRlTjWzxw/R9RbUt4jtV
         VDU2cVkaJgeu1SZAPJ/kjRe0BzorZ4WbQYE/7M9IcOxC140iDIsIthvNFg1+iZ5O7VPx
         yU8q3xhXy8VJ3W1UVE3nB7FQeYpZem11yzih7QPGHlxgbyM6C7LRNq6uu+tZXqiid341
         ji9OPXUJbHZs4xFIC5ww5UboC1WD6UDcFBxCLI3n4AKUqKywKPFDHfWw42CmA8W6Ty5P
         AuUw==
X-Gm-Message-State: ANhLgQ02ra5Vjdp2yzF7AKhwSUXHu5AnYsz8S2Owh+r1BJuVBYW8PvEv
        1QE+rQylqTX0Caj+MVz59oUOFY5K7NV4YO/+tVayRg==
X-Google-Smtp-Source: ADFU+vsc0zHMVKED7UniO5Kq+6KFg/Q4A+f3RC2sHN2BOg94KRCK01t/8vKmmhnfMSyOr/sGx3XAEwjNEqAKkkXFq24=
X-Received: by 2002:a17:90a:1f8d:: with SMTP id x13mr2509613pja.27.1583856993053;
 Tue, 10 Mar 2020 09:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200308073400.23398-1-natechancellor@gmail.com>
 <CAK7LNARcTHpd8fzrAhFVB_AR7NoBgenX64de0eS2uN8g0by9PQ@mail.gmail.com>
 <20200310012545.GA16822@ubuntu-m2-xlarge-x86> <c2a687d065c1463d8eea9947687b3b05@AcuMS.aculab.com>
 <CAK7LNARMsO0AeO8-kH4czMuW0Y_=dN+ZhtXNdRE7CWGvU2PNvA@mail.gmail.com>
In-Reply-To: <CAK7LNARMsO0AeO8-kH4czMuW0Y_=dN+ZhtXNdRE7CWGvU2PNvA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 10 Mar 2020 09:16:22 -0700
Message-ID: <CAKwvOdmf0V61O5gsuby_50fijrxe=LNh4pTtRGy_8=5637P7qw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Disable -Wpointer-to-enum-cast
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        stable <stable@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Saravana, who I spoke to briefly about this.


On Tue, Mar 10, 2020 at 8:32 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Tue, Mar 10, 2020 at 8:31 PM David Laight <David.Laight@aculab.com> wrote:
> >
> > From: Nathan Chancellor
> > > Sent: 10 March 2020 01:26
> > ...
> > > Sure, I can send v2 to do that but I think that sending 97 patches just
> > > casting the small values (usually less than twenty) to unsigned long
> > > then to the enum is rather frivolous. I audited at least ten to fifteen
> > > of these call sites when creating the clang patch and they are all
> > > basically false positives.
> >
> > Such casts just make the code hard to read.
> > If misused casts can hide horrid bugs.
> > IMHO sprinkling the code with casts just to remove
> > compiler warnings will bite back one day.
> >
>
> I agree that too much casts make the code hard to read,
> but irrespective of this patch, there is no difference
> in the fact that we need a cast to convert
> (const void *) to a non-pointer value.
>
> The difference is whether we use
> (uintptr_t) or (enum foo).
>
>
>
>
> If we want to avoid casts completely,
> we could use union in struct of_device_id
> although this might be rejected.
>
>
> FWIW:
>
> diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
> index 6853dbb4131d..534170bea134 100644
> --- a/drivers/ata/ahci_brcm.c
> +++ b/drivers/ata/ahci_brcm.c
> @@ -415,11 +415,11 @@ static struct scsi_host_template ahci_platform_sht = {
>  };
>
>  static const struct of_device_id ahci_of_match[] = {
> -       {.compatible = "brcm,bcm7425-ahci", .data = (void *)BRCM_SATA_BCM7425},
> -       {.compatible = "brcm,bcm7445-ahci", .data = (void *)BRCM_SATA_BCM7445},
> -       {.compatible = "brcm,bcm63138-ahci", .data = (void *)BRCM_SATA_BCM7445},
> -       {.compatible = "brcm,bcm-nsp-ahci", .data = (void *)BRCM_SATA_NSP},
> -       {.compatible = "brcm,bcm7216-ahci", .data = (void *)BRCM_SATA_BCM7216},
> +       {.compatible = "brcm,bcm7425-ahci", .data2 = BRCM_SATA_BCM7425},
> +       {.compatible = "brcm,bcm7445-ahci", .data2 = BRCM_SATA_BCM7445},
> +       {.compatible = "brcm,bcm63138-ahci", .data2 = BRCM_SATA_BCM7445},
> +       {.compatible = "brcm,bcm-nsp-ahci", .data2 = BRCM_SATA_NSP},
> +       {.compatible = "brcm,bcm7216-ahci", .data2 = BRCM_SATA_BCM7216},
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, ahci_of_match);
> @@ -442,7 +442,7 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>         if (!of_id)
>                 return -ENODEV;
>
> -       priv->version = (enum brcm_ahci_version)of_id->data;
> +       priv->version = of_id->data2;
>         priv->dev = dev;
>
>         res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "top-ctrl");
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index e3596db077dc..98d44ebf146a 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -261,7 +261,10 @@ struct of_device_id {
>         char    name[32];
>         char    type[32];
>         char    compatible[128];
> -       const void *data;
> +       union {
> +               const void *data;
> +               unsigned long data2;
> +       };
>  };
>

-- 
Thanks,
~Nick Desaulniers
