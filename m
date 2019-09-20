Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC451B8EED
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 13:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438170AbfITLXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 07:23:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45684 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393608AbfITLXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 07:23:36 -0400
Received: from mail-ot1-f71.google.com ([209.85.210.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iBH0f-0002aL-Be
        for linux-kernel@vger.kernel.org; Fri, 20 Sep 2019 11:23:33 +0000
Received: by mail-ot1-f71.google.com with SMTP id l21so3417251otr.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 04:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iV27nI8Jtkumr2nEeO8gy6V9pQ8fT+/smrbZCaOLJgg=;
        b=sL+SyiYLnYuUUhJ8zNOJ8SJdke9CRPiromrJRjdh4yHsoDuDNHVahQIqfOwJWiwr8U
         Juk/p5UAEnU7hnsoOo6qfEkUuYd/75k29zWbpYioQ0rCFcgSHb+k1+MWa4Mzzwrq2mXw
         ek5gH5Nd8IGQTEPHJAl16lCGwpopQbAKFsfGZWbHkjiKT+gqJhODaZXlkSyYYvmLB/Gz
         Ir0V92T5wTH9ExvfVnf2rwXnieTbqhtT+XhZv2i1QjqUddXmZpRkPQ4quJ1TU9Ybtzod
         /AAkxRGFloViPJekGwK+u/Wa1z2uoBYzuSDJWcJ0JXBozj/+oMDKHAThnlX0JOnBFqjG
         EqdQ==
X-Gm-Message-State: APjAAAWCSe00JLUk4bSOIlmcVWWLFeqz+Iauh7QoUT5BpembI9L7UGtN
        lVTRfkX3FIVeL+LDHZOomP7z2dVc3IavL/s4T7TIoll5McwZG1g5a+0/4oAW7hvUS6M3fapA5+6
        GCoJHcvFl4i/YzRYXUMhV70Lbz8svp6HV/debKKlK6I2cQ/OYNceRNi9pyA==
X-Received: by 2002:aca:d9c3:: with SMTP id q186mr2385459oig.53.1568978612345;
        Fri, 20 Sep 2019 04:23:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxGE0CXP73wztiKAwRdZskwBr2gJgJJW4tcjb56ypIA/roYner5Ad1WU7kgluJgxuZoVUwvadLKzGua+CFsLXU=
X-Received: by 2002:aca:d9c3:: with SMTP id q186mr2385434oig.53.1568978612029;
 Fri, 20 Sep 2019 04:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190827134756.10807-1-kai.heng.feng@canonical.com> <20190909114129.GT103977@google.com>
In-Reply-To: <20190909114129.GT103977@google.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 20 Sep 2019 13:23:20 +0200
Message-ID: <CAAd53p4mc0tgCBiwfZRowr4os_bqDP+7Ko=d+do8OW2aH1Whzg@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: Add a helper to check Power Resource
 Requirements _PR3 existence
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     tiwai@suse.com, Linux PCI <linux-pci@vger.kernel.org>,
        alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

I didn't find your reply in my mailbox earlier.

On Mon, Sep 9, 2019 at 1:41 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Maybe:
>
>   PCI: Add pci_pr3_present() to check for Power Resources for D3hot

Ok, this is a good title.

>
> On Tue, Aug 27, 2019 at 09:47:55PM +0800, Kai-Heng Feng wrote:
> > A driver may want to know the existence of _PR3, to choose different
> > runtime suspend behavior. A user will be add in next patch.
>
> Maybe include something like this in the commit lot?
>
>   Add pci_pr3_present() to check whether the platform supplies _PR3 to
>   tell us which power resources the device depends on when in D3hot.

Ok.

>
> > This is mostly the same as nouveau_pr3_present().
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/pci/pci.c   | 20 ++++++++++++++++++++
> >  include/linux/pci.h |  2 ++
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 1b27b5af3d55..776af15b92c2 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -5856,6 +5856,26 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
> >       return 0;
> >  }
> >
> > +bool pci_pr3_present(struct pci_dev *pdev)
> > +{
> > +     struct pci_dev *parent_pdev = pci_upstream_bridge(pdev);
> > +     struct acpi_device *parent_adev;
> > +
> > +     if (acpi_disabled)
> > +             return false;
> > +
> > +     if (!parent_pdev)
> > +             return false;
> > +
> > +     parent_adev = ACPI_COMPANION(&parent_pdev->dev);
> > +     if (!parent_adev)
> > +             return false;
> > +
> > +     return parent_adev->power.flags.power_resources &&
> > +             acpi_has_method(parent_adev->handle, "_PR3");
>
> I think this is generally OK, but it doesn't actually check whether
> *pdev* has a _PR3; it checks whether pdev's *parent* does.  So does
> that mean this is dependent on the GPU topology, i.e., does it assume
> that there is an upstream bridge and that power for everything under
> that bridge can be managed together?

Yes, the power resource is managed by its upstream port.

>
> I'm wondering whether the "parent_pdev = pci_upstream_bridge()" part
> should be in the caller rather than in pci_pr3_present()?

This will make the function more align to its name, but needs more
work from caller side.
How about rename the function to pci_upstream_pr3_present()?

>
> I can't connect any of the dots from _PR3 through to
> "need_eld_notify_link" (whatever "eld" is :)) and the uses of
> hda_intel.need_eld_notify_link (and needs_eld_notify_link()).
>
> But that's beyond the scope of *this* patch and it makes sense that
> you do want to discover the _PR3 existence, so I'm fine with this once
> we figure out the pdev vs parent question.

Thanks for your review.

Kai-Heng

>
> > +}
> > +EXPORT_SYMBOL_GPL(pci_pr3_present);
> > +
> >  /**
> >   * pci_add_dma_alias - Add a DMA devfn alias for a device
> >   * @dev: the PCI device for which alias is added
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 82e4cd1b7ac3..9b6f7b67fac9 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -2348,9 +2348,11 @@ struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus);
> >
> >  void
> >  pci_msi_register_fwnode_provider(struct fwnode_handle *(*fn)(struct device *));
> > +bool pci_pr3_present(struct pci_dev *pdev);
> >  #else
> >  static inline struct irq_domain *
> >  pci_host_bridge_acpi_msi_domain(struct pci_bus *bus) { return NULL; }
> > +static bool pci_pr3_present(struct pci_dev *pdev) { return false; }
> >  #endif
> >
> >  #ifdef CONFIG_EEH
> > --
> > 2.17.1
> >
