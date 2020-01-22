Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52F7D1453BB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 12:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgAVL0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 06:26:32 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39044 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgAVL0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 06:26:32 -0500
Received: by mail-lf1-f66.google.com with SMTP id y1so5029456lfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 03:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V+lAqSz5wTyi+61b7EReWzxQYkZJK8Gs3cUoV5MfV44=;
        b=p5oGBTAxQmLBtccQRaQ2oVSkL+RzSCXT0Z/JjFVX+bcLFhxw/vs7l8BqOhA27CPDOL
         4BDZGjlG2gbs1OptsnX4TE0WE0VD/CZdvL5pgKMMNDEqGBoGElXbbJHIMhpszrNi9cPK
         jm2NfHFPDpIc5+laM2OAi3ZnBoD4JK9pETBgWXe1IjWxzkwHSGTtjSFn3tpdD1ugOqm0
         dIa7b3guZNdE7sDHXj+g5DjodZ7J0jJoyuVp1Q/ZTyoPdUCx8fkj3ceUZ8KWdmIArn1Q
         cnJjn5IOLHABrpRmtoaBtt+xqaFH34OuNhjvYNMAYgNBkm8yToZOuxEc+4RmYIpBY0zx
         YXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V+lAqSz5wTyi+61b7EReWzxQYkZJK8Gs3cUoV5MfV44=;
        b=fwTcNug18oocVNdbhD5yjEoG76T0P2NNkU1VmLAjZxk1aXZ5TsAG1pi0aIR05lTgi1
         A9Tc0sdV3D/zNlCC3b9p4802ixiIPcXktXRyrJHTQ1HuTB6wogS5V2IY73n8MaDFUFA6
         riuya9s0+VJPkc4cL5eMNqsMXP2EGU6fCFVXaTLoSy+J+ONNcMoakStzr5FILKDpAxti
         gWKX/R/Yd44kamxdiRWM1a+7qrDN9bWy64dRPKg8uXDfWbqRseoO8+q8/CmGROEPkoMr
         pEdBtWtelYlfYvU+h5wXqP/NAqaPAL3cY+kjAfYAlaIa1WFShIgy4e/n+P7lftrxX8tK
         auRg==
X-Gm-Message-State: APjAAAU7YSVLPaR3gLhg900OXJ92Ki56qtFuKCNxbXJ/2XLPVmWcMmm5
        qVXHGbJbPIxfLhGu0JpZcTmfKGqMNJzr7fbOk+A9iw==
X-Google-Smtp-Source: APXvYqzV86bG+SaA5gWIm2t8JcBLYOOxi23mSwF9M9j2CTJmmh1L/ilDcaE8/ZC6b6VRNmfBAQroQMCw7DBh8wpbKrs=
X-Received: by 2002:ac2:5f74:: with SMTP id c20mr1549303lfc.15.1579692390036;
 Wed, 22 Jan 2020 03:26:30 -0800 (PST)
MIME-Version: 1.0
References: <20200117162444.v2.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid>
In-Reply-To: <20200117162444.v2.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid>
From:   Rajat Jain <rajatja@google.com>
Date:   Wed, 22 Jan 2020 03:25:52 -0800
Message-ID: <CACK8Z6Ft95qj4e_fsA32r_bcz2SsHOW1xxqZJt3_DBAJw=NMGA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/MSI: Avoid torn updates to MSI pairs
To:     Evan Green <evgreen@chromium.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 4:26 PM Evan Green <evgreen@chromium.org> wrote:
>
> __pci_write_msi_msg() updates three registers in the device: address
> high, address low, and data. On x86 systems, address low contains
> CPU targeting info, and data contains the vector. The order of writes
> is address, then data.
>
> This is problematic if an interrupt comes in after address has
> been written, but before data is updated, and both the SMP affinity
> and target vector are being changed. In this case, the interrupt targets
> the wrong vector on the new CPU.
>
> This case is pretty easy to stumble into using xhci and CPU hotplugging.
> Create a script that repeatedly targets interrupts at a set of cores and
> then offlines those cores. Put some stress on USB, and then watch xhci
> lose an interrupt and die.

Do I understand it right, that even with this patch, the driver might
still miss the same interrupt (because we are disabling the interrupt
for that time) -  the improvement this patch brings is that it will at
least not be delivered to the wrong CPU or via a wrong vector?

Thanks,
Rajat

>
> Avoid this by disabling MSIs during the update.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
>
> Changes in v2:
> - Also mask msi-x interrupts during the update
> - Restore the enable/mask bit to its previous value, rather than
> unconditionally enabling interrupts
>
>
> Bjorn,
> I was unsure whether disabling MSIs temporarily is actually an okay
> thing to do. I considered using the mask bit, but got the impression
> that not all devices support the mask bit. Let me know if this going to
> cause problems or there's a better way. I can include the repro
> script I used to cause mayhem if needed.
>
> ---
>  drivers/pci/msi.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 6b43a5455c7af..bb21a7739fa2c 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -311,6 +311,7 @@ void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
>  void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
>  {
>         struct pci_dev *dev = msi_desc_to_pci_dev(entry);
> +       u16 msgctl;
>
>         if (dev->current_state != PCI_D0 || pci_dev_is_disconnected(dev)) {
>                 /* Don't touch the hardware now */
> @@ -320,15 +321,25 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
>                 if (!base)
>                         goto skip;
>
> +               pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS,
> +                                    &msgctl);
> +
> +               pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS,
> +                                     msgctl | PCI_MSIX_FLAGS_MASKALL);
> +
>                 writel(msg->address_lo, base + PCI_MSIX_ENTRY_LOWER_ADDR);
>                 writel(msg->address_hi, base + PCI_MSIX_ENTRY_UPPER_ADDR);
>                 writel(msg->data, base + PCI_MSIX_ENTRY_DATA);
> +               pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS,
> +                                     msgctl);
> +
>         } else {
>                 int pos = dev->msi_cap;
> -               u16 msgctl;
> +               u16 enabled;
>
>                 pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
> -               msgctl &= ~PCI_MSI_FLAGS_QSIZE;
> +               enabled = msgctl & PCI_MSI_FLAGS_ENABLE;
> +               msgctl &= ~(PCI_MSI_FLAGS_QSIZE | PCI_MSI_FLAGS_ENABLE);
>                 msgctl |= entry->msi_attrib.multiple << 4;
>                 pci_write_config_word(dev, pos + PCI_MSI_FLAGS, msgctl);
>
> @@ -343,6 +354,9 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
>                         pci_write_config_word(dev, pos + PCI_MSI_DATA_32,
>                                               msg->data);
>                 }
> +
> +               msgctl |= enabled;
> +               pci_write_config_word(dev, pos + PCI_MSI_FLAGS, msgctl);
>         }
>
>  skip:
> --
> 2.24.1
>
