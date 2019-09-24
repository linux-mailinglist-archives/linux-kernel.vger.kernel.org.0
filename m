Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBC50BC0B9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 05:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408982AbfIXD24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 23:28:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42212 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408847AbfIXD2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 23:28:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id n14so175530wrw.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 20:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BOntdqNAzJq09OHpR8y1tYGj1Bvw6Q9JNvhQORlIsxk=;
        b=TEbQNYRoY0DL6fKSICuqMJZuH9R7sIv7XrMy4vxuBCFoYXnZbGMgGvkTL57hdXsv0S
         Im4MJJCNVtZ2dFPcG24aCiO6P7LOhI4bzGu4LbXQMIlNKnPs+cJV1AdDA4wPdFhfiv8X
         38TDwVx4TisO3PeTlr3ij0yjhtd7F9llsr0bI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BOntdqNAzJq09OHpR8y1tYGj1Bvw6Q9JNvhQORlIsxk=;
        b=Nz7mLli0862EpE8kqw/+V84+zOLPcZXNv9XuTnMK8yTvgT747mJxoj8E3jGvBSwrGX
         KUR5O01PIPhoCgtkblZ6xw23EEQG0XdtOAQcL1TUePjAHwtlzKy0PSBPLpDnq4n3gk/A
         P/I6h5Totwzbgcddzq6rf0dvBipOz4siFs0lL7ctqgacf2XUIJxr1Ee4dTI9rfcIG9wo
         umjW1hiVn8RSTuwTvbk0+2AbhZ3QpBVWDYm6R9sE+RdG01XgfLH/0F2e13UmTsthGePB
         LE845JIh0kNG97cVqTeY1w+PqLVY1jt56XrualzJLZfJT/L8i/07oVn26lLLrsMjGWBr
         aX+A==
X-Gm-Message-State: APjAAAX6Cqit8GfuOfh0RvLEFg0G5sdX9XU1NxJ3eq3IYn/evx+16daB
        4qag+fDsrZ/01IVNpWAMZo4o2k+ViiPNJOjMeVRqyA==
X-Google-Smtp-Source: APXvYqxzxn9kQfZkcW3T0wqOc99Kw0KeUVqqryo2jeSxJpN5gkQ+J1QilZA+ndh4MuioxkMybO2BNrUv6568LouoFOE=
X-Received: by 2002:adf:ce86:: with SMTP id r6mr425937wrn.57.1569295731092;
 Mon, 23 Sep 2019 20:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190906035813.24046-1-abhishek.shah@broadcom.com>
 <20190906083816.GD9720@e119886-lin.cambridge.arm.com> <CAKUFe6ZuRGJSmLdXqTWJzX-nE_Vh4yEQF_-rf+BWFrD_r4BRaQ@mail.gmail.com>
 <20190906100114.GE9720@e119886-lin.cambridge.arm.com> <CAKUFe6aHGM0qHXcwopVfv_6+ALA=zmtBzSwNUO6qg8OEG-h_Ww@mail.gmail.com>
In-Reply-To: <CAKUFe6aHGM0qHXcwopVfv_6+ALA=zmtBzSwNUO6qg8OEG-h_Ww@mail.gmail.com>
From:   Abhishek Shah <abhishek.shah@broadcom.com>
Date:   Tue, 24 Sep 2019 08:58:40 +0530
Message-ID: <CAKUFe6Zoo9r9tw-33VXjECX-iP=PNYJgxBb5LaOQrZ9-Tr+J6A@mail.gmail.com>
Subject: Re: [PATCH 1/1] PCI: iproc: Invalidate PAXB address mapping before
 programming it
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-pci@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn/Lorenzo,

Can you please help review this patch?


Regards,
Abhishek


On Fri, Sep 6, 2019 at 7:41 PM Abhishek Shah <abhishek.shah@broadcom.com> wrote:
>
> Hi Andrew,
>
>
> On Fri, Sep 6, 2019 at 3:31 PM Andrew Murray <andrew.murray@arm.com> wrote:
> >
> > On Fri, Sep 06, 2019 at 02:55:19PM +0530, Abhishek Shah wrote:
> > > Hi Andrew,
> > >
> > > Thanks for the review. Please see my response inline:
> > >
> > > On Fri, Sep 6, 2019 at 2:08 PM Andrew Murray <andrew.murray@arm.com> wrote:
> > > >
> > > > On Fri, Sep 06, 2019 at 09:28:13AM +0530, Abhishek Shah wrote:
> > > > > Invalidate PAXB inbound/outbound address mapping each time before
> > > > > programming it. This is helpful for the cases where we need to
> > > > > reprogram inbound/outbound address mapping without resetting PAXB.
> > > > > kexec kernel is one such example.
> > > >
> > > > Why is this approach better than resetting the PAXB (I assume that's
> > > > the PCI controller IP)? Wouldn't resetting the PAXB address this issue,
> > > > and ensure that no other configuration is left behind?
> > > >
> > > We normally reset PAXB in the firmware(ATF). But for cases like kexec
> > > kernel boot,
> > > we do not execute any firmware code and directly boot into kernel.
> > >
> > > We could have done PAXB reset in the driver itself as you have suggested here.
> > > But note that this detail could vary for each SoC, because these
> > > registers are not part
> > > of PAXB register space itself, rather exists in a register space responsible for
> > > controlling power to various wrappers in PCIe IP. Normally, this kind
> > > of SoC specific
> > > details are handled in firmware itself, we don't bring them to driver level.
> >
> > OK understood.
> >
> > >
> > > > Or is this related to earlier boot stages loading firmware for the emulated
> > > > downstream endpoints (ep_is_internal)?
> > > >
> > > > Finally, in the case where ep_is_internal do you need to disable anything
> > > > prior to invalidating the mappings?
> > > >
> > > No, ep_is_internal  is indicator for PAXC IP. It does not have
> > > mappings as in PAXB.
> >
> > I think I meant !ep_is_internal. I.e. is there possibility of inbound traffic
> > prior to invalidating the mappings. I'd assume not, but that's an assumption.
> >
> No, EP devices are not even enumerated yet.
>
> > Either way:
> >
> > Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> >
> > >
> > >
> > > Regards,
> > > Abhishek
> > > > >
> > > > > Signed-off-by: Abhishek Shah <abhishek.shah@broadcom.com>
> > > > > Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> > > > > Reviewed-by: Vikram Mysore Prakash <vikram.prakash@broadcom.com>
> > > > > ---
> > > > >  drivers/pci/controller/pcie-iproc.c | 28 ++++++++++++++++++++++++++++
> > > > >  1 file changed, 28 insertions(+)
> > > > >
> > > > > diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> > > > > index e3ca46497470..99a9521ba7ab 100644
> > > > > --- a/drivers/pci/controller/pcie-iproc.c
> > > > > +++ b/drivers/pci/controller/pcie-iproc.c
> > > > > @@ -1245,6 +1245,32 @@ static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
> > > > >       return ret;
> > > > >  }
> > > > >
> > > > > +static void iproc_pcie_invalidate_mapping(struct iproc_pcie *pcie)
> > > > > +{
> > > > > +     struct iproc_pcie_ib *ib = &pcie->ib;
> > > > > +     struct iproc_pcie_ob *ob = &pcie->ob;
> > > > > +     int idx;
> > > > > +
> > > > > +     if (pcie->ep_is_internal)
> > > > > +             return;
> > > > > +
> > > > > +     if (pcie->need_ob_cfg) {
> > > > > +             /* iterate through all OARR mapping regions */
> > > > > +             for (idx = ob->nr_windows - 1; idx >= 0; idx--) {
> > > > > +                     iproc_pcie_write_reg(pcie,
> > > > > +                                          MAP_REG(IPROC_PCIE_OARR0, idx), 0);
> > > > > +             }
> > > > > +     }
> > > > > +
> > > > > +     if (pcie->need_ib_cfg) {
> > > > > +             /* iterate through all IARR mapping regions */
> > > > > +             for (idx = 0; idx < ib->nr_regions; idx++) {
> > > > > +                     iproc_pcie_write_reg(pcie,
> > > > > +                                          MAP_REG(IPROC_PCIE_IARR0, idx), 0);
> > > > > +             }
> > > > > +     }
> > > > > +}
> > > > > +
> > > > >  static int iproce_pcie_get_msi(struct iproc_pcie *pcie,
> > > > >                              struct device_node *msi_node,
> > > > >                              u64 *msi_addr)
> > > > > @@ -1517,6 +1543,8 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
> > > > >       iproc_pcie_perst_ctrl(pcie, true);
> > > > >       iproc_pcie_perst_ctrl(pcie, false);
> > > > >
> > > > > +     iproc_pcie_invalidate_mapping(pcie);
> > > > > +
> > > > >       if (pcie->need_ob_cfg) {
> > > > >               ret = iproc_pcie_map_ranges(pcie, res);
> > > > >               if (ret) {
> > > >
> > > > The code changes look good to me.
> > > >
> > > > Thanks,
> > > >
> > > > Andrew Murray
> > > >
> > > > > --
> > > > > 2.17.1
> > > > >
