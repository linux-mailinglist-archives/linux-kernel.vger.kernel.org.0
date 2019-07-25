Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 410E4757DA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 21:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfGYT3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 15:29:52 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:43157 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfGYT3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 15:29:52 -0400
Received: by mail-qk1-f174.google.com with SMTP id m14so11644912qka.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 12:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=si1Bg5d4DG/siyTiXvmamj/8p+ZxXVSJ3UQi4yT7UUs=;
        b=OjPF1rzG6j00lyx9qskWReDCQZ4A335Yk6oMrrcwap2n+dj1NcZUPBuK0tsSPF+y7E
         Kv9L8jcA4TpdUf8UG95Pyeo69nZO1kzFOGsC2of/qgrFKUH8uJQNZFTQVUaWGsDRfa2D
         noanR1FhbaOdRTKNuRw76Agsiv61gjkwZOGT75g6QFs8RUKPSMoYXDEe2FLAQewUPDNM
         lDWrMlIi+YnDFuYC3Ootmy8nO4DeTF1s9wmVJhAORZImjXMXP0oDMAcp938dZp4CDBan
         IfH7PNa4bGY/vYhSy/BsA6kHLFrl9zQRen9ZIAk6ikxl1v9hzkmzxIi/cbg19fG84TKt
         VgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=si1Bg5d4DG/siyTiXvmamj/8p+ZxXVSJ3UQi4yT7UUs=;
        b=GueA3rDW8S57CAa4tmLPElT7yM5YQpiJAJqA0nyM4v0ZkdqdfdV+3M/mc8AOqzMn/g
         SeP4vgwf/8GYbPlOl+tX/OxeUtvd195bcFfSw6Sb7DeQmtUJ6iPZXgDrCt3M5E11xh05
         cPgMqCr6d9QRG22uIj9kehF/7+lxTTuktLDwnkClCOOdwEZoWkCbhE56SyrAqSBcfsPz
         +obJ/LzcxIQW29owvzVXalyHIww0aDvdC0+HfG6/F/ejhRUoXjAr2iBSQAAcRP1uHd3U
         QIT3Gyq8aYCG3ROtOTHeCQaNTl30n4+NsLFe/IG6F2jLFbGvyE+e59IWczYQTrsHrA4m
         kH2A==
X-Gm-Message-State: APjAAAU+WAAM+km/kaVpPLv9E5R4a06TrKuX+oaCQdjId8dVb092q2GD
        u7/qgl/78ferDrv9uizg5RhHlZpcKO7k8geEBzI=
X-Google-Smtp-Source: APXvYqzHXGhtFa/wQAPpmBiS/0sdVeAOWcBceZoWIjzA6wYqKPid+xvQH9ep5xOPrm7Hdowc7CFgFdh6rmrwTjLrU3w=
X-Received: by 2002:ae9:f017:: with SMTP id l23mr60057787qkg.457.1564082990063;
 Thu, 25 Jul 2019 12:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAOKSTBs-cHMr7xbJVVUjZ9C3__bY6jZU-_TZ0RmMRMJ3dBk3PA@mail.gmail.com>
 <0c3f445d-1e37-1531-d3d5-f7ad75c58343@metux.net> <CADnq5_NqDNLzZW6h3cXBUfTMsBe6isvE6YQH=9Op6Gews=ubGg@mail.gmail.com>
In-Reply-To: <CADnq5_NqDNLzZW6h3cXBUfTMsBe6isvE6YQH=9Op6Gews=ubGg@mail.gmail.com>
From:   Gilberto Nunes <gilberto.nunes32@gmail.com>
Date:   Thu, 25 Jul 2019 16:29:14 -0300
Message-ID: <CAOKSTBvjJ+3he9AJoRGkxQfQLoG_T9jY+H8p0o6A6FdmnisSJA@mail.gmail.com>
Subject: Re: AMD Drivers
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        LKML <linux-kernel@vger.kernel.org>,
        dri devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there!

I try the kernel 5.3.0-050300rc1-generic and almost everything works
perfectly, except there's no sound in HDMI!!!
Pavucontrol show me device unplugged!
But I have now work properly NIC and GPU!


lspci
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
(Models 60h-6fh) Processor Root Complex
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Family 15h (Models
60h-6fh) I/O Memory Management Unit
00:01.0 VGA compatible controller: Advanced Micro Devices, Inc.
[AMD/ATI] Wani [Radeon R5/R6/R7 Graphics] (rev c8)
00:01.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Kabini
HDMI/DP Audio
00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
(Models 60h-6fh) Host Bridge
00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
(Models 60h-6fh) Processor Root Port
00:02.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
(Models 60h-6fh) Processor Root Port
00:03.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
(Models 60h-6fh) Host Bridge
00:03.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
(Models 60h-6fh) Processor Root Port
00:08.0 Encryption controller: Advanced Micro Devices, Inc. [AMD] Device 15=
78
00:09.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 157d
00:09.2 Audio device: Advanced Micro Devices, Inc. [AMD] Family 15h
(Models 60h-6fh) Audio Controller
00:10.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB
XHCI Controller (rev 20)
00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA
Controller [AHCI mode] (rev 49)
00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB
EHCI Controller (rev 49)
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev=
 4a)
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev =
11)
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
(Models 60h-6fh) Processor Function 0
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
(Models 60h-6fh) Processor Function 1
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
(Models 60h-6fh) Processor Function 2
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
(Models 60h-6fh) Processor Function 3
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
(Models 60h-6fh) Processor Function 4
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
(Models 60h-6fh) Processor Function 5
01:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd.
RTL8411B PCI Express Card Reader (rev 01)
01:00.1 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 12)
02:00.0 Network controller: Qualcomm Atheros QCA9377 802.11ac Wireless
Network Adapter (rev 31)
03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI]
Lexa PRO [Radeon RX 550/550X] (rev c3)
---
Gilberto Nunes Ferreira

(47) 3025-5907
(47) 99676-7530 - Whatsapp / Telegram

Skype: gilberto.nunes36


Em qui, 25 de jul de 2019 =C3=A0s 14:26, Alex Deucher
<alexdeucher@gmail.com> escreveu:
>
> On Thu, Jul 25, 2019 at 3:30 AM Enrico Weigelt, metux IT consult
> <lkml@metux.net> wrote:
> >
> > On 24.07.19 16:17, Gilberto Nunes wrote:
> >
> > Hi,
> >
> > crossposting to dri-devel, as it smells like a problem w/ amdgpu driver=
.
> >
> > > CPU - AMD A12-9720P RADEON R7, 12 COMPUTE CORES 4C+8G
> > > GPU - Wani [Radeon R5/R6/R7 Graphics] (amdgpu)
> > > Network Interface card:
> > > 01:00.1 Ethernet controller: Realtek Semiconductor Co., Ltd.
> > > RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 12)
> > >
> > > When I install kernel 4.18.x or 5.x, the network doesn't work anymore=
...
> >
> > What about other versions (eg. v4.19) ?
> > Which is the last working version ?
> >
> > > I can loaded the modulo r8169 andr8168.
> > > I saw enp1s0f1 as well but there's no link at all!
> > > Even when I fixed the IP none link!
> > > I cannot ping the network gateway or any other IP inside LAN!
> > > Right now, I booted my laptop with kernel
> > > Linux version 5.2.2-050202-generic (kernel@kathleen) (gcc version
> > > 9.1.0 (Ubuntu 9.1.0-9ubuntu2)) #201907231250 SMP Tue Jul 23 12:53:21
> > > UTC 2019
> >
> > Could you also try 5.3 ?
> >
> > > The system boot slowly, and I have a SSD Samsung, which in kernel
> > > 4.15, boot quickly.
> > > And there's many errors in dmesg command, like you can see in this pa=
stbin
> > >
> > > https://paste.ubuntu.com/p/YhbjnzYYYh/
> >
> > looks like something's wrong w/ reading gpu registers (more precisely
> > waiting for some changing), that's causing the soft lockup. (maybe too
> > big timeout ?)
>
> It looks like the dGPU fails to power up properly when you attempt to
> use it.  You can append amdgpu.runpm=3D0 to the kernel command line in
> grub to disable dynamically powering down the dGPU.
>
> Alex
>
> >
> > > Oh! By the way, the network card r8169 are work wonderful!
> >
> > Didn't you say (above) that it does not work ?
> > Or is it just an immediate fail and later comes back ?
> >
> >
> > --mtx
> >
> >
> > --
> > Enrico Weigelt, metux IT consult
> > Free software and Linux embedded engineering
> > info@metux.net -- +49-151-27565287
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
