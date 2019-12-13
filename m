Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3E111DC42
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 03:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731792AbfLMCwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 21:52:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48826 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726631AbfLMCwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 21:52:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576205539;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cD1L+8FREG+GUDcMz+uat68SlppNJ1ul4pAa2adOJms=;
        b=HQ7K4Q2Yb0jJw4bWNsQQduqYLY8QRGMk7p0hJg0g14gnKwDYWf0tq+Mw6LBuX4yXZMgho8
        Z7kfzkUG+RndNYIVcHBfoA1bgBw5SHa1X5hiznXnSZM7yS70q3s/tWEaLoDtKjAz2QVR67
        5BKDgmuIVnla8+BgwNi8/EdVIKvUGAQ=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-9sV7kxYDO0Sb1xIYCOdpug-1; Thu, 12 Dec 2019 21:52:18 -0500
X-MC-Unique: 9sV7kxYDO0Sb1xIYCOdpug-1
Received: by mail-yb1-f197.google.com with SMTP id g132so837604ybf.21
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 18:52:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=cD1L+8FREG+GUDcMz+uat68SlppNJ1ul4pAa2adOJms=;
        b=mCcp8kzQUoVj2R0OhxmGXQoR+4qajAH0B1TTbHdGu3I4gEo2afSFB9jA7cxFkL15TU
         ClApa3o6Q+YWtB18Aos3QkRVPbOnixmvnOxnxYerE5tWpvKlePPDw5ovzJzvLs6sU+4F
         pK0jOR9vn/X40T+JoUlj1HTcpTMEeQ4vD/lLwPJXOFOUlxCRlsCgClO/6xgs/nczvy+Q
         JX474QCnb2yo/nNvJTcSKx74zY2spwVYgHuAZBiew9KlNI2HBtHQVFiRtDkPFaXwEfjV
         U14tes8v+nRsC+o4CArH8/WDdNzXZyl+AYSe5TvebUq1EvK9wCQ+8d0aYShJv1JDUHCx
         gX1w==
X-Gm-Message-State: APjAAAX6NkdPAnOXK4GNpSDtSxpirXfH3DaBt4iiApfXxilLkzcCeV5I
        Km4GiQWzZiJdHOc+2KJaQnuolJpdJJ+i5Lm/oyhGM+QFa0swMB0mtarUhLal4FEWGsgMpKJme7K
        I2/jHQC+mCnXVQ7b6i/1TWS6m
X-Received: by 2002:a25:b814:: with SMTP id v20mr7059590ybj.108.1576205537844;
        Thu, 12 Dec 2019 18:52:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqxKfbL8mDNB7zRISO5Uc+9Lbw1DKFRT8f3eUHKdf/Rvj+kSjJjTiPaM16CZsiJA82Bqiv70yQ==
X-Received: by 2002:a25:b814:: with SMTP id v20mr7059569ybj.108.1576205537478;
        Thu, 12 Dec 2019 18:52:17 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id g64sm3548300ywa.20.2019.12.12.18.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 18:52:16 -0800 (PST)
Date:   Thu, 12 Dec 2019 19:51:59 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix dmar pte read access not set error
Message-ID: <20191213025159.kwf6f6zjmcjecamp@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20191211014015.7898-1-baolu.lu@linux.intel.com>
 <20191212014952.vlrmxrk2cebwxjnp@cantor>
 <6f3bcad9-b9b3-b349-fdad-ce53a79a665b@linux.intel.com>
 <20191213003013.gc3zg3fpzpjntnzg@cantor>
 <7d58da5b-3f55-72b2-0638-ae561446d207@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d58da5b-3f55-72b2-0638-ae561446d207@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Dec 13 19, Lu Baolu wrote:
>Hi,
>
>On 12/13/19 8:30 AM, Jerry Snitselaar wrote:
>>On Thu Dec 12 19, Lu Baolu wrote:
>>>Hi,
>>>
>>>On 12/12/19 9:49 AM, Jerry Snitselaar wrote:
>>>>On Wed Dec 11 19, Lu Baolu wrote:
>>>>>If the default DMA domain of a group doesn't fit a device, it
>>>>>will still sit in the group but use a private identity domain.
>>>>>When map/unmap/iova_to_phys come through iommu API, the driver
>>>>>should still serve them, otherwise, other devices in the same
>>>>>group will be impacted. Since identity domain has been mapped
>>>>>with the whole available memory space and RMRRs, we don't need
>>>>>to worry about the impact on it.
>>>>>
>>>>>Link: https://www.spinics.net/lists/iommu/msg40416.html
>>>>>Cc: Jerry Snitselaar <jsnitsel@redhat.com>
>>>>>Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
>>>>>Fixes: 942067f1b6b97 ("iommu/vt-d: Identify default domains 
>>>>>replaced with private")
>>>>>Cc: stable@vger.kernel.org # v5.3+
>>>>>Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>>>
>>>>Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
>>>
>>>Can you please try this fix and check whether it can fix your problem?
>>>If it helps, do you mind adding a Tested-by?
>>>
>>>Best regards,
>>>baolu
>>>
>>
>>I'm testing with this patch, my patch that moves the direct mapping call,
>>and Alex's patch for the ISA bridge. It solved the 2 iommu mapping errors
>>I was seeing with default passthrough, I no longer see all the dmar pte
>>read access errors, and the system boots allowing me to login. I'm tracking
>>down 2 issues at the moment. With passthrough I see a problem with 01:00.4
>>that I mentioned in the earlier email:
>>
>>[   78.978573] uhci_hcd: USB Universal Host Controller Interface driver
>>[   78.980842] uhci_hcd 0000:01:00.4: UHCI Host Controller
>>[   78.982738] uhci_hcd 0000:01:00.4: new USB bus registered, 
>>assigned bus number 3
>>[   78.985222] uhci_hcd 0000:01:00.4: detected 8 ports
>>[   78.986907] uhci_hcd 0000:01:00.4: port count misdetected? 
>>forcing to 2 ports
>>[   78.989316] uhci_hcd 0000:01:00.4: irq 16, io base 0x00003c00
>>[   78.994634] uhci_hcd 0000:01:00.4: DMAR: 32bit DMA uses 
>>non-identity mapping
>>[   7 0000:01:00.4: unable to allocate consistent memory for frame list
>>[   79.499891] uhci_hcd 0000:01:00.4: startup error -16
>>[   79.501588] uhci_hcd 0000:01:00.4: USB bus 3 deregistered
>>[   79.503494] uhci_hcd 0000:01:00.4: init 0000:01:00.4 fail, -16
>>[   79.505497] uhci_hcd: probe of 0000:01:00.4 failed with error -16
>>
>>If I boot the system with iommu=nopt I see an iommu map failure due to
>>the prot check in __domain_mapping:
>>
>>[   40.940589] pci 0000:00:1f.0: iommu_group_add_device: calling 
>>iommu_group_create_direct_mappings
>>[   40.943558] pci 0000:00:1f.0: iommu_group_create_direct_mappings: 
>>iterating through mappings
>>[   40.946402] pci 0000:00:1f.0: iommu_group_create_direct_mappings: 
>>calling apply_resv_region
>>[   40.949184] pci 0000:00:1f.0: iommu_group_create_direct_mappings: 
>>entry type is direct
>>[   40.951819] DMAR: intel_iommu_map: enter
>>[   40.953128] DMAR: __domain_mapping: prot & 
>>(DMA_PTE_READ|DMA_PTE_WRITE) == 0
>>[   40.955486] DMAR: domain_mapping: __domain_mapping failed
>>[   40.957348] DMAR: intel_iommu_map: domain_pfn_mapping returned -22
>>[   40.959466] DMAR: intel_iommu_map: leave
>>[   40.959468] iommu: iommu_map: ops->map failed iova 0x0 pa 
>>0x0000000000000000 pgsize 0x1000
>>[   40.963511] pci 0000:00:1f.0: iommu_group_create_direct_mappings: 
>>iommu_map failed
>>[   40.966026] pci 0000:00:1f.0: iommu_group_create_direct_mappings: 
>>leaving func
>>[   40.968487] pci 0000:00:1f.0: iommu_group_add_device: calling 
>>__iommu_attach_device
>>[   40.971016] pci 0000:00:1f.0: Adding to iommu group 19
>>[   40.972731] pci 0000:00:1f.0: DMAR: domain->type is dma
>>
>>/sys/kernel/iommu_groups/19
>>[root@hp-dl388g8-07 19]# cat reserved_regions 0x0000000000000000 
>>0x0000000000ffffff direct
>>0x00000000bdf6e000 0x00000000bdf84fff direct
>>0x00000000fee00000 0x00000000feefffff msi
>>
>>00:1f.0 ISA bridge: Intel Corporation C600/X79 series chipset LPC 
>>Controller
>
>This seems to be another issue?
>
>Best regards,
>baolu

In intel_iommu_get_resv_regions this iommu_alloc_resv_region is called
with prot set to 0:

                 if ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA) {
                         reg = iommu_alloc_resv_region(0, 1UL << 24, 0,
                                                       IOMMU_RESV_DIRECT_RELAXABLE);
                         if (reg)

I wonder if this is an issue with the region starting at 0x0 and this
bit in iommu_group_create_mappings:

			phys_addr = iommu_iova_to_phys(domain, addr);
			if (phys_addr)
				continue;

Off to stick in some more debugging statements.

Regards,
Jerry

>_______________________________________________
>iommu mailing list
>iommu@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/iommu

