Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3290EB7225
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 06:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbfISEUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 00:20:51 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45345 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbfISEUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 00:20:51 -0400
Received: by mail-ot1-f67.google.com with SMTP id 41so1845283oti.12;
        Wed, 18 Sep 2019 21:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j6ktaKerA6qNCNUVOJpqP9XS7SoRgjTBYtdJRVNyhcw=;
        b=B5ZuP2QirBOxP8R4Vuk7t6QPgJAudPXy3O8bZJY+rcApaDVAU+jgjaU9a1iluML0DJ
         3qAi/Gww7GqOOou2O1sYCeFnsWz5mKYSrbCsdVhWdJ5cpO29uBNTWp7wIOZIlHVLEtvy
         klTgBbplg4XmhPpFOIM0us0oSVRyUOaHlum3QlZ1iM2mHWzGZvHVMWiJUMXv8Qjdsxfc
         v+N8xVfUHouGPsbNQePXKRLwRmCRFVSdLKkvntP2TZsa3CSHyRbEBhfeB6gVSH52yi8V
         PrgXhQlB2flQV6fz+YY3NY+e2glt88lyUd2qwncGUCTiySGRTEoNwVn4Qvf7h4MG5cIy
         sC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6ktaKerA6qNCNUVOJpqP9XS7SoRgjTBYtdJRVNyhcw=;
        b=J6zRe0hOHSigbGeNivZ6TnaSCRaJLEmecM8eNanojdhv2aLbOE+A1bPx5T7rD/QW2J
         OEL5ITj3639VCvUqbb9IQhzobccEs4cuu5bsqZq4o2QDPwT5JeB4G9vGvZtHEsydrar8
         88w3euk090+LIhXQvDX4O+Bud990jZ4SEsEU85BtOAJ2a7aXmSCqGgUkKUxnrzswBz00
         XqPiYwTmylFkSh69tf12norUISysv9Nt6wJ/bIWTdipW1O6R2Lxqsk3ECn/eJEnPKcRf
         iDDm0Ex3Tse8ubp1T9axz6JkMIdFOOsW9d0tyy/eh9PsL2LVq9InBDE4mg+D+iZ5XrhG
         cTLQ==
X-Gm-Message-State: APjAAAU3PxfTdZjPjE1ku9rXqHnepNL/OEwk/ZFHabRrOlwGFhRaeQ6D
        TyWcrrxlVP6snUZg/MKTbkK1ZfgLaWHgWSa/kjWXCSHR
X-Google-Smtp-Source: APXvYqxjyCXBVLXbbc37aFrdNvvbQpskLVO+apNEFZ3ayPK48X288HghyPp33qNmLTr3e8fC29soNN0avIt7kWpkVFQ=
X-Received: by 2002:a05:6830:1f0f:: with SMTP id u15mr5581667otg.34.1568866850204;
 Wed, 18 Sep 2019 21:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <1c16a43c-3a01-8a86-02b0-1941ab7321dd@web.de>
In-Reply-To: <1c16a43c-3a01-8a86-02b0-1941ab7321dd@web.de>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 19 Sep 2019 06:20:39 +0200
Message-ID: <CAMhs-H9q16kGOse9pMbj3O9hoOO5de_wa9VRi_HcPo0_GbTw1g@mail.gmail.com>
Subject: Re: [PATCH] staging: mt7621-pci-phy: Use devm_platform_ioremap_resource()
 in mt7621_pci_phy_probe()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        =?UTF-8?Q?Antti_Ker=C3=A4nen?= <detegr@gmail.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Neil Brown <neil@brown.name>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Himanshu Jha <himanshujha199640@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

Thanks for the patch. It looks good to me.

On Wed, Sep 18, 2019 at 9:12 PM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 18 Sep 2019 21:01:32 +0200
>
> Simplify this function implementation by using a known wrapper function.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/staging/mt7621-pci-phy/pci-mt7621-phy.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/staging/mt7621-pci-phy/pci-mt7621-phy.c b/drivers/staging/mt7621-pci-phy/pci-mt7621-phy.c
> index d2a07f145143..6ca4a33d13c3 100644
> --- a/drivers/staging/mt7621-pci-phy/pci-mt7621-phy.c
> +++ b/drivers/staging/mt7621-pci-phy/pci-mt7621-phy.c
> @@ -324,7 +324,6 @@ static int mt7621_pci_phy_probe(struct platform_device *pdev)
>         const struct soc_device_attribute *attr;
>         struct phy_provider *provider;
>         struct mt7621_pci_phy *phy;
> -       struct resource *res;
>         int port;
>         void __iomem *port_base;
>
> @@ -344,14 +343,7 @@ static int mt7621_pci_phy_probe(struct platform_device *pdev)
>
>         phy->dev = dev;
>         platform_set_drvdata(pdev, phy);
> -
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       if (!res) {
> -               dev_err(dev, "failed to get address resource\n");
> -               return -ENXIO;
> -       }
> -
> -       port_base = devm_ioremap_resource(dev, res);
> +       port_base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(port_base)) {
>                 dev_err(dev, "failed to remap phy regs\n");
>                 return PTR_ERR(port_base);
> --
> 2.23.0
>

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
