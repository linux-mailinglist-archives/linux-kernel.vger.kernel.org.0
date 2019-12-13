Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 349B211DC89
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 04:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbfLMDQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 22:16:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30396 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726631AbfLMDQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 22:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576207007;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OF6N4wqiULHnhkx+2DOIL/HDlPx6E4fjY6FKxous7Io=;
        b=KmIngwNx7y5eukhj5esJEmug/dT9/NMmRW7Vi0eDE4EO+jFQkT5LQWO1KU3BRRN70Cmeb1
        R12TIvG+CPa9fBbXeAjWvDn/YYsiy9T4tMQo3clZ01keF2Sh7NMTN9UfSMfSzlAImZFaCK
        vhdAzMmtNXU+tIRUQ+/ve4pnBXQifMI=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-pdlFFkkRN56H6Qf44scdZA-1; Thu, 12 Dec 2019 22:16:43 -0500
X-MC-Unique: pdlFFkkRN56H6Qf44scdZA-1
Received: by mail-yb1-f200.google.com with SMTP id b5so879453ybq.23
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 19:16:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=OF6N4wqiULHnhkx+2DOIL/HDlPx6E4fjY6FKxous7Io=;
        b=fdzpTcX2LkXVea8vjmZIKWk+U9FfYDo4Obq1j14sgx28Vn1jDPyx8hpKdi2grWGOgb
         GW473FTwxYHqh9rMYpL/KbF3xlqRwpfftq0lnAvVWuTQPxD5JTUD6dLFXW6qyzLza8B5
         LL0XcSeeJ0OG/HRKFUJXHWF084wuVgUOl5wBmOF6DMS4YoOgwAXZg7ZUhCtqJBl/PSsM
         hSApfUO1Aabo5zArA2svAoKAGGfRZneOxAOtt0LKGnHl61g4fFVnMNgv2tUUWEcYPKa3
         U44sx+8FDa7kawcSTawfBkpfsPuluQbel8aJGmAevuPrx4qmJJYyhtH01eflQhX/bH0p
         wkKg==
X-Gm-Message-State: APjAAAUUL71ScIW4HOrSjmW7uOilkssyNTnNK5Buh8XiE7/w872RWkfw
        N4KiqP96oOahPW4f//a63wjvIU+wncLPlj8GjKJ8HVGLOLIZ8bYqoZeIIfTpLDivzU2qWtmaV4u
        H3kvNBq5I/sbr7HbUHx+fLC2B
X-Received: by 2002:a81:550c:: with SMTP id j12mr6975269ywb.38.1576207002595;
        Thu, 12 Dec 2019 19:16:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqw4yUmpywtUmKkrwEdg58T33LVtLlFVUkyGqlU+wk4uepLmvOkbc5t04OHTCnhGMELRjb1LzA==
X-Received: by 2002:a81:550c:: with SMTP id j12mr6975255ywb.38.1576207002317;
        Thu, 12 Dec 2019 19:16:42 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id j129sm3468145ywf.99.2019.12.12.19.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 19:16:41 -0800 (PST)
Date:   Thu, 12 Dec 2019 20:16:33 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix dmar pte read access not set error
Message-ID: <20191213031633.zxccz5t5yyillxsb@cantor>
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
 <20191213025159.kwf6f6zjmcjecamp@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191213025159.kwf6f6zjmcjecamp@cantor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Dec 12 19, Jerry Snitselaar wrote:
>On Fri Dec 13 19, Lu Baolu wrote:
>>Hi,
>>
>>On 12/13/19 8:30 AM, Jerry Snitselaar wrote:
>>>On Thu Dec 12 19, Lu Baolu wrote:
>>>>Hi,
>>>>
>>>>On 12/12/19 9:49 AM, Jerry Snitselaar wrote:
>>>>>On Wed Dec 11 19, Lu Baolu wrote:
>>>>>>If the default DMA domain of a group doesn't fit a device, it
>>>>>>will still sit in the group but use a private identity domain.
>>>>>>When map/unmap/iova_to_phys come through iommu API, the driver
>>>>>>should still serve them, otherwise, other devices in the same
>>>>>>group will be impacted. Since identity domain has been mapped
>>>>>>with the whole available memory space and RMRRs, we don't need
>>>>>>to worry about the impact on it.
>>>>>>
>>>>>>Link: https://www.spinics.net/lists/iommu/msg40416.html
>>>>>>Cc: Jerry Snitselaar <jsnitsel@redhat.com>
>>>>>>Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
>>>>>>Fixes: 942067f1b6b97 ("iommu/vt-d: Identify default domains 
>>>>>>replaced with private")
>>>>>>Cc: stable@vger.kernel.org # v5.3+
>>>>>>Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>>>>
>>>>>Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
>>>>
>>>>Can you please try this fix and check whether it can fix your problem?
>>>>If it helps, do you mind adding a Tested-by?
>>>>
>>>>Best regards,
>>>>baolu
>>>>
>>>
>>>I'm testing with this patch, my patch that moves the direct mapping call,
>>>and Alex's patch for the ISA bridge. It solved the 2 iommu mapping errors
>>>I was seeing with default passthrough, I no longer see all the dmar pte
>>>read access errors, and the system boots allowing me to login. I'm tracking
>>>down 2 issues at the moment. With passthrough I see a problem with 01:00.4
>>>that I mentioned in the earlier email:
>>>
>>>[   78.978573] uhci_hcd: USB Universal Host Controller Interface driver
>>>[   78.980842] uhci_hcd 0000:01:00.4: UHCI Host Controller
>>>[   78.982738] uhci_hcd 0000:01:00.4: new USB bus registered, 
>>>assigned bus number 3
>>>[   78.985222] uhci_hcd 0000:01:00.4: detected 8 ports
>>>[   78.986907] uhci_hcd 0000:01:00.4: port count misdetected? 
>>>forcing to 2 ports
>>>[   78.989316] uhci_hcd 0000:01:00.4: irq 16, io base 0x00003c00
>>>[   78.994634] uhci_hcd 0000:01:00.4: DMAR: 32bit DMA uses 
>>>non-identity mapping
>>>[   7 0000:01:00.4: unable to allocate consistent memory for frame list
>>>[   79.499891] uhci_hcd 0000:01:00.4: startup error -16
>>>[   79.501588] uhci_hcd 0000:01:00.4: USB bus 3 deregistered
>>>[   79.503494] uhci_hcd 0000:01:00.4: init 0000:01:00.4 fail, -16
>>>[   79.505497] uhci_hcd: probe of 0000:01:00.4 failed with error -16
>>>
>>>If I boot the system with iommu=nopt I see an iommu map failure due to
>>>the prot check in __domain_mapping:
>>>
>>>[   40.940589] pci 0000:00:1f.0: iommu_group_add_device: calling 
>>>iommu_group_create_direct_mappings
>>>[   40.943558] pci 0000:00:1f.0: 
>>>iommu_group_create_direct_mappings: iterating through mappings
>>>[   40.946402] pci 0000:00:1f.0: 
>>>iommu_group_create_direct_mappings: calling apply_resv_region
>>>[   40.949184] pci 0000:00:1f.0: 
>>>iommu_group_create_direct_mappings: entry type is direct
>>>[   40.951819] DMAR: intel_iommu_map: enter
>>>[   40.953128] DMAR: __domain_mapping: prot & 
>>>(DMA_PTE_READ|DMA_PTE_WRITE) == 0
>>>[   40.955486] DMAR: domain_mapping: __domain_mapping failed
>>>[   40.957348] DMAR: intel_iommu_map: domain_pfn_mapping returned -22
>>>[   40.959466] DMAR: intel_iommu_map: leave
>>>[   40.959468] iommu: iommu_map: ops->map failed iova 0x0 pa 
>>>0x0000000000000000 pgsize 0x1000
>>>[   40.963511] pci 0000:00:1f.0: 
>>>iommu_group_create_direct_mappings: iommu_map failed
>>>[   40.966026] pci 0000:00:1f.0: 
>>>iommu_group_create_direct_mappings: leaving func
>>>[   40.968487] pci 0000:00:1f.0: iommu_group_add_device: calling 
>>>__iommu_attach_device
>>>[   40.971016] pci 0000:00:1f.0: Adding to iommu group 19
>>>[   40.972731] pci 0000:00:1f.0: DMAR: domain->type is dma
>>>
>>>/sys/kernel/iommu_groups/19
>>>[root@hp-dl388g8-07 19]# cat reserved_regions 0x0000000000000000 
>>>0x0000000000ffffff direct
>>>0x00000000bdf6e000 0x00000000bdf84fff direct
>>>0x00000000fee00000 0x00000000feefffff msi
>>>
>>>00:1f.0 ISA bridge: Intel Corporation C600/X79 series chipset LPC 
>>>Controller
>>
>>This seems to be another issue?
>>
>>Best regards,
>>baolu
>
>In intel_iommu_get_resv_regions this iommu_alloc_resv_region is called
>with prot set to 0:
>
>                if ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA) {
>                        reg = iommu_alloc_resv_region(0, 1UL << 24, 0,
>                                                      IOMMU_RESV_DIRECT_RELAXABLE);
>                        if (reg)
>

Looking at the older code for the ISA bridge it looks like it called
iommu_prepare_identity_map -> domain_prepare_identity_map ->
iommu_domain_identity_map -> and finally __domain_mapping with DMA_PTE_READ|DMA_PTE_WRITE?

>I wonder if this is an issue with the region starting at 0x0 and this
>bit in iommu_group_create_mappings:
>
>			phys_addr = iommu_iova_to_phys(domain, addr);
>			if (phys_addr)
>				continue;

Disregard this

>
>Off to stick in some more debugging statements.
>
>Regards,
>Jerry
>
>>_______________________________________________
>>iommu mailing list
>>iommu@lists.linux-foundation.org
>>https://lists.linuxfoundation.org/mailman/listinfo/iommu

