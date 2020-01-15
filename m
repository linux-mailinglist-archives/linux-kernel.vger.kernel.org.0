Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA3B13CBA2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 19:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgAOSGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 13:06:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57514 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729008AbgAOSGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 13:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579111572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5/JVNCvoMKLbuw+th8Mvpr4NSmYiudENwSQlfto1vYg=;
        b=XIm/1wIL+v8VymJIBNUelsevMvXU1g4/Fc2etWk/pCdA5Zklc53u8QNbMqQVlseFyFk1Tn
        WZYPD0G4r39BP+oOR1aRLQ7OJ4claDnFXLcYT7TTZEQ+fFrr+YbFYgROhL+wSyOJ7Ti6Xh
        XKDek0k7uli/6FDRI4DpguyfMTsF7kg=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-c9Hkd2hkPXC5fXpomk6M-g-1; Wed, 15 Jan 2020 13:06:10 -0500
X-MC-Unique: c9Hkd2hkPXC5fXpomk6M-g-1
Received: by mail-io1-f71.google.com with SMTP id s6so3749868iod.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 10:06:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5/JVNCvoMKLbuw+th8Mvpr4NSmYiudENwSQlfto1vYg=;
        b=H1t+gzLfywOmUrXj2DvN2V1RFtHkO5+hLnWxIjS4HNzhXWh3wRR+SxQv2GUcUQPRKh
         TiMEqqVR/7FD8zGoo5N5jfVIiXTG8RZ6oANYY2mxW6Xkj2e1P2+/Zvzx4We/SI+X7KWu
         hv4Y7aUeeIouqxWeC+wW3i5zBsTB7BsQ3SHWSrP1ZgrycRq5UZuQ0P9ElJuLyp5abKbO
         +IxhkKWetEJyb+fpSkOSiAd0Diwd66f4SBZcdewvR11VdCVBEqqnzX6ml8UtNkOc+Tfm
         DwAkJ7g6m9zlHqf5M4ozs22pPOtK4QMXSsWfTke2z9mE6B6vp1pjlv3nHi0y+X8PbsC5
         IDTw==
X-Gm-Message-State: APjAAAXa1lFUpSGdXF9ONdXGt0e/VKEZpqvR+2ZaUlrUFX0i1l9DCpyA
        Z/3oSx+vGnVjL1Ty8Nxaueyv/r/Mllq+X3qKoQreZJMELmXBTmGFS/Nrr4D96FA4xphX1059bS8
        aSmeT99pwBfGmJnymR3U9Ccp78RoXtUeEsDvT2gAd
X-Received: by 2002:a92:3a95:: with SMTP id i21mr4486733ilf.249.1579111569278;
        Wed, 15 Jan 2020 10:06:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqyiSpVTrT9xrjDsRfXMdNMLD3zLf65q5AGAKjzBKvyYRr2MTNUMJyyycnXSNnfMh8iTlOsaFXQttkz/wrm0e3g=
X-Received: by 2002:a92:3a95:: with SMTP id i21mr4486711ilf.249.1579111569023;
 Wed, 15 Jan 2020 10:06:09 -0800 (PST)
MIME-Version: 1.0
References: <20200110214217.GA88274@google.com> <e0194581-4cdd-3629-d9fe-10a1cfd29d03@gonehiking.org>
 <20200110230003.GB1875851@anatevka.americas.hpqcorp.net> <d2715683-f171-a825-3c0b-678b6c5c1a79@gonehiking.org>
 <20200111005041.GB19291@MiWiFi-R3L-srv> <dc46c904-1652-09b3-f351-6b3a3e761d74@gonehiking.org>
 <CACPcB9c0-nRjM3DSN8wzZBTPsJKWjZ9d_aNTq5zUj4k4egb32Q@mail.gmail.com>
 <CABeXuvqquCU+1G=5onk9owASorhpcYWeWBge9U35BrorABcsuw@mail.gmail.com>
 <CACPcB9cQY9Vu3wG-QYZS6W6T_PZxnJ1ABNUUAF_qvk-VSxbpTA@mail.gmail.com> <b2360db7-66f5-421d-8fe0-150f08aa2f39@gonehiking.org>
In-Reply-To: <b2360db7-66f5-421d-8fe0-150f08aa2f39@gonehiking.org>
From:   Kairui Song <kasong@redhat.com>
Date:   Thu, 16 Jan 2020 02:05:57 +0800
Message-ID: <CACPcB9epDPcowhnSJuEHQ8miCBX1oKjFx4Wdn4aYPe2_pueA5A@mail.gmail.com>
Subject: Re: [RFC PATCH] PCI, kdump: Clear bus master bit upon shutdown in
 kdump kernel
To:     Khalid Aziz <khalid@gonehiking.org>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Baoquan He <bhe@redhat.com>, linux-pci@vger.kernel.org,
        kexec@lists.infradead.org, Jerry Hoemann <Jerry.Hoemann@hpe.com>,
        Randy Wright <rwright@hpe.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 1:31 AM Khalid Aziz <khalid@gonehiking.org> wrote:
>
> On 1/13/20 10:07 AM, Kairui Song wrote:
> > On Sun, Jan 12, 2020 at 2:33 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> >>
> >>> Hi, there are some previous works about this issue, reset PCI devices
> >>> in kdump kernel to stop ongoing DMA:
> >>>
> >>> [v7,0/5] Reset PCIe devices to address DMA problem on kdump with iommu
> >>> https://lore.kernel.org/patchwork/cover/343767/
> >>>
> >>> [v2] PCI: Reset PCIe devices to stop ongoing DMA
> >>> https://lore.kernel.org/patchwork/patch/379191/
> >>>
> >>> And didn't get merged, that patch are trying to fix some DMAR error
> >>> problem, but resetting devices is a bit too destructive, and the
> >>> problem is later fixed in IOMMU side. And in most case the DMA seems
> >>> harmless, as they targets first kernel's memory and kdump kernel only
> >>> live in crash memory.
> >>
> >> I was going to ask the same. If the kdump kernel had IOMMU on, would
> >> that still be a problem?
> >
> > It will still fail, doing DMA is not a problem, it only go wrong when
> > a device's upstream bridge is mistakenly shutdown before the device
> > shutdown.
> >
> >>
> >>> Also, by the time kdump kernel is able to scan and reset devices,
> >>> there are already a very large time window where things could go
> >>> wrong.
> >>>
> >>> The currently problem observed only happens upon kdump kernel
> >>> shutdown, as the upper bridge is disabled before the device is
> >>> disabledm so DMA will raise error. It's more like a problem of wrong
> >>> device shutting down order.
> >>
> >> The way it was described earlier "During this time, the SUT sometimes
> >> gets a PCI error that raises an NMI." suggests that it isn't really
> >> restricted to kexec/kdump.
> >> Any attached device without an active driver might attempt spurious or
> >> malicious DMA and trigger the same during normal operation.
> >> Do you have available some more reporting of what happens during the
> >> PCIe error handling?
> >
> > Let me add more info about this:
> >
> > On the machine where I can reproduce this issue, the first kernel
> > always runs fine, and kdump kernel works fine during dumping the
> > vmcore, even if I keep the kdump kernel running for hours, nothing
> > goes wrong. If there are DMA during normal operation that will cause
> > problem, this should have exposed it.
> >
>
> This is the part that is puzzling me. Error shows up only when kdump
> kernel is being shut down. kdump kernel can run for hours without this
> issue. What is the operation from downstream device that is resulting in
> uncorrectable error - is it indeed a DMA request? Why does that
> operation from downstream device not happen until shutdown?
>
> I just want to make sure we fix the right problem in the right way.
>

Actually the device could keep sending request with no problem during
kdump kernel running. Eg. keep sending DMA, and all DMA targets first
kernel's system memory, so kdump runs fine as long as nothing touch
the reserved crash memory. And the error is reported by the port, when
shutdown it has bus master bit, and downstream request will cause
error.

I'm not sure what request it really is either, it could depend on
device. On that machine, error could be reproduced when either the NIC
or HPSA is not reset in kdump, and from the bug report, the reporter
used a different NIC card and it's also reproducible.
The NIC is much less like to cause bridge error though (HPSA is about
7/10 reproducible, NIC is about 3/10), so the device could send
different requests but fail in the same way (UR error reported from
the bridge).

Will try to do more debug, but I'm not sure how can I intercept the
PCIe operation to get some info about what is actually causing the
issue, do you have any suggestion?

-- 
Best Regards,
Kairui Song

