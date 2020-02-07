Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7A31554C2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 10:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgBGJeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Feb 2020 04:34:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27795 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726935AbgBGJeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 04:34:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581068059;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=N9HQa1eUJe3cNssku5cbzrtf54NZBWLo6fyeOybyo9A=;
        b=HQtqsD1c+lc+93Hty/wPzvw2HKQLVDkCuyOZhQxzU0i+z8l9OG8HRVviaGo3y/978i6+at
        3SpVIy2nf35hckVi+MSUiun6NAgw9o1mFRecQ6ISpYgivsNTicQ/Oib4TtBNbzv7EMWibB
        1ZdJiOwynG0+vBOwOvdRdaeGTRkRe18=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-vL5RDOiqP5Sn4Ow7-CEZDw-1; Fri, 07 Feb 2020 04:34:17 -0500
X-MC-Unique: vL5RDOiqP5Sn4Ow7-CEZDw-1
Received: by mail-yb1-f200.google.com with SMTP id 195so1584673ybc.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 01:34:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=N9HQa1eUJe3cNssku5cbzrtf54NZBWLo6fyeOybyo9A=;
        b=EW/I8k32BdQdIHGrnjrWmqPycqHCkiL5hjNzEE/epvjSyKpW+Vqz8lBW75nhSNeoS9
         NyBQNT8eG0B1ajbGT4cZ7ShXkN5DX2gI01VJcuzWHo5SfcQTuhotn0YO3bi5kD8VXieN
         AEwL3KyuMhZBbF/elzptrX/fsBWyH4qJ0MJzgDa/QJ88MRYFed8dEDPN6oo+o6htLrD2
         9j+4QkVUkgyzDS27zMCxz1NuYol2tiGQYIcswkzpUajUsOuFXsnx+pcO72RC+Lrqbx2l
         vJWUwOEYjYned+DPJZT6MNPKzH6MBUUc5k0AYsR7DUnlar9InWeNkMeMsCL64llfrHjs
         TB0A==
X-Gm-Message-State: APjAAAWoAzAduHJ7Ow+Ezis25SkD1gNp+8+vOmBZcmJqmA2eR8dc9W5Z
        FoPokKnd3DisOLCni6H7XQpDXy1lnQyiRnizSZCUFfFjBAj8uOz63SuD2yGPHUAqyDNPY8jCo2j
        TtgdOrMtfb7h0hudZa+WUoYDj
X-Received: by 2002:a0d:cd84:: with SMTP id p126mr7372328ywd.319.1581068056142;
        Fri, 07 Feb 2020 01:34:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqzCNoQSY+X7YTTMBJouw/gVANVmrX8glJOPrbxzL6EIgigQq81V7jxOu9SPeDfYNYIAaVyHUg==
X-Received: by 2002:a0d:cd84:: with SMTP id p126mr7372307ywd.319.1581068055743;
        Fri, 07 Feb 2020 01:34:15 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id i17sm1016568ywg.66.2020.02.07.01.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 01:34:15 -0800 (PST)
Date:   Fri, 7 Feb 2020 02:34:13 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: warning from domain_get_iommu
Message-ID: <20200207093413.oy4tclbrb3vqs3vz@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
References: <20200204200714.u4ezhi6vhqhxog6e@cantor>
 <20200206174358.shzhieijle5wdshr@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200206174358.shzhieijle5wdshr@cantor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Feb 06 20, Jerry Snitselaar wrote:
>On Tue Feb 04 20, Jerry Snitselaar wrote:
>>I'm working on getting a system to reproduce this, and verify it also occurs
>>with 5.5, but I have a report of a case where the kdump kernel gives
>>warnings like the following on a hp dl360 gen9:
>>
>>[    2.830589] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
>>[    2.832615] ehci-pci: EHCI PCI platform driver
>>[    2.834190] ehci-pci 0000:00:1a.0: EHCI Host Controller
>>[    2.835974] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
>>[    2.838276] ehci-pci 0000:00:1a.0: debug port 2
>>[    2.839700] WARNING: CPU: 0 PID: 1 at drivers/iommu/intel-iommu.c:598 domain_get_iommu+0x55/0x60
>>[    2.840671] Modules linked in:
>>[    2.840671] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.0-170.el8.kdump2.x86_64 #1
>>[    2.840671] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9, BIOS P89 07/21/2019
>>[    2.840671] RIP: 0010:domain_get_iommu+0x55/0x60
>>[    2.840671] Code: c2 01 eb 0b 48 83 c0 01 8b 34 87 85 f6 75 0b 48 63 c8 48 39 c2 75 ed 31 c0 c3 48 c1 e1 03 48 8b 05 70 f3 91 01 48 8b 04 08 c3 <0f> 0b 31 c0 c3 31 c9 eb eb 66 90 0f 1f 44 00 00 41 55 40 0f b6 f6
>>[    2.840671] RSP: 0018:ffffc900000dfab8 EFLAGS: 00010202
>>[    2.840671] RAX: ffff88ec7f1c8000 RBX: 0000006c7c867000 RCX: 0000000000000000
>>[    2.840671] RDX: 00000000fffffff0 RSI: 0000000000000000 RDI: ffff88ec7f1c8000
>>[    2.840671] RBP: ffff88ec6f7000b0 R08: ffff88ec7f19d000 R09: ffff88ec7cbfcd00
>>[    2.840671] R10: 0000000000000095 R11: ffffc900000df928 R12: 0000000000000000
>>[    2.840671] R13: ffff88ec7f1c8000 R14: 0000000000001000 R15: 00000000ffffffff
>>[    2.840671] FS:  0000000000000000(0000) GS:ffff88ec7f600000(0000) knlGS:0000000000000000
>>[    2.840671] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>[    2.840671] CR2: 00007ff3e1713000 CR3: 0000006c7de0a004 CR4: 00000000001606b0
>>[    2.840671] Call Trace:
>>[    2.840671]  __intel_map_single+0x62/0x140
>>[    2.840671]  intel_alloc_coherent+0xa6/0x130
>>[    2.840671]  dma_pool_alloc+0xd8/0x1e0
>>[    2.840671]  e_qh_alloc+0x55/0x130
>>[    2.840671]  ehci_setup+0x284/0x7b0
>>[    2.840671]  ehci_pci_setup+0xa3/0x530
>>[    2.840671]  usb_add_hcd+0x2b6/0x800
>>[    2.840671]  usb_hcd_pci_probe+0x375/0x460
>>[    2.840671]  local_pci_probe+0x41/0x90
>>[    2.840671]  pci_device_probe+0x105/0x1b0
>>[    2.840671]  driver_probe_device+0x12d/0x460
>>[    2.840671]  device_driver_attach+0x50/0x60
>>[    2.840671]  __driver_attach+0x61/0x130
>>[    2.840671]  ? device_driver_attach+0x60/0x60
>>[    2.840671]  bus_for_each_dev+0x77/0xc0
>>[    2.840671]  ? klist_add_tail+0x3b/0x70
>>[    2.840671]  bus_add_driver+0x14d/0x1e0
>>[    2.840671]  ? ehci_hcd_init+0xaa/0xaa
>>[    2.840671]  ? do_early_param+0x91/0x91
>>[    2.840671]  driver_register+0x6b/0xb0
>>[    2.840671]  ? ehci_hcd_init+0xaa/0xaa
>>[    2.840671]  do_one_initcall+0x46/0x1c3
>>[    2.840671]  ? do_early_param+0x91/0x91
>>[    2.840671]  kernel_init_freeable+0x1af/0x258
>>[    2.840671]  ? rest_init+0xaa/0xaa
>>[    2.840671]  kernel_init+0xa/0xf9
>>[    2.840671]  ret_from_fork+0x35/0x40
>>[    2.840671] ---[ end trace e87b0d9a1c8135c4 ]---
>>[    3.010848] ehci-pci 0000:00:1a.0: Using iommu dma mapping
>>[    3.012551] ehci-pci 0000:00:1a.0: 32bit DMA uses non-identity mapping
>>[    3.018537] ehci-pci 0000:00:1a.0: cache line size of 64 is not supported
>>[    3.021188] ehci-pci 0000:00:1a.0: irq 18, io mem 0x93002000
>>[    3.029006] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
>>[    3.030918] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.18
>>[    3.033491] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>>[    3.035900] usb usb1: Product: EHCI Host Controller
>>[    3.037423] usb usb1: Manufacturer: Linux 4.18.0-170.el8.kdump2.x86_64 ehci_hcd
>>[    3.039691] usb usb1: SerialNumber: 0000:00:1a.0
>>
>>It looks like the device finishes initializing once it figures out it
>>needs dma mapping instead of the default
>>passthrough. intel_alloc_coherent calls iommu_need_mapping, before it
>>calls __intel_map_single, so I'm not sure why it is tripping over the
>>WARN_ON in domain_get_iommu.
>>
>>one thing I noticed while looking at this is that domain_get_iommu can
>>return NULL. So should there be something like the following in
>>__intel_map_single after the domain_get_iommu call?
>>
>>if (!iommu)
>>  goto error;
>>
>>It is possible to deref the null pointer later otherwise.
>>
>>Regards,
>>Jerry
>
>I reproduced the warning with a 5.5 kernel on an Intel NUC5i5MYBE.

Hi Baolu,

I think I understand what is happening here. With the kdump boot
translation is pre-enabled, so in intel_iommu_add_device things are
getting set to DEFER_DEVICE_DOMAIN_INFO. When intel_alloc_coherent
calls iommu_need_mapping it returns true, but doesn't do the dma
domain switch because of DEFER_DEVICE_DOMAIN_INFO. Then
__intel_map_single gets called and it calls deferred_attach_domain,
which sets the domain to the group domain, which in this case is the
identity domain. Then it calls domain_get_iommu, which spits out the
warning because the domain type was dma and returns null. My
workaround was to add a call to iommu_need_mapping and find_domain
after the deferred_attach_domain, but I don't know if that is the
correct solution. There are a couple other spots like intel_map_sg
that have the deferred_attach_domain after iommu_need_mapping that
possibly will suffer from the same problem.

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b5c5ab58d395..063f45323cfc 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3515,6 +3515,10 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
         if (!domain)
                 return DMA_MAPPING_ERROR;
  
+       if (!iommu_need_mapping(dev))
+               return paddr;
+
+       domain = find_domain(dev);
         iommu = domain_get_iommu(domain);
         size = aligned_nrpages(paddr, size);


I finally got a git repo over to one of these systems, and was
able to reproduce the issue with the head of linus's tree. With commit
9235cb13d7d1 ("iommu/vt-d: Allow devices with RMRRs to use identity domain")
there are more of the warnings, because devices are using identity that
weren't before.

Regards,
Jerry

