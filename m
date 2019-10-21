Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51810DE565
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 09:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfJUHjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 03:39:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:2089 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbfJUHjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 03:39:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 00:39:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,322,1566889200"; 
   d="scan'208";a="196036842"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga008.fm.intel.com with ESMTP; 21 Oct 2019 00:39:11 -0700
Cc:     baolu.lu@linux.intel.com
Subject: Re: [PATCH] iommu/vt-d: Fix panic after kexec -p for kdump
To:     John Donnelly <john.p.donnelly@oracle.com>,
        linux-kernel@vger.kernel.org
References: <4E962E33-4B15-4407-9FF0-3705229D8881@oracle.com>
 <f30dcef0-4a6f-db89-fde8-048c309a1d9d@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <c8d239c7-61a1-e3a3-50b4-d4856cd759ff@linux.intel.com>
Date:   Mon, 21 Oct 2019 15:36:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f30dcef0-4a6f-db89-fde8-048c309a1d9d@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By the way, Joerg Roedel <joro@8bytes.org> is the IOMMU subsystem
maintainer. If you have a v2, please add his email in the "To" list.

You can always use scripts/get_maintainer.pl to check who should the
patch be sent to. :-)

Best regards,
Baolu

On 10/21/19 3:27 PM, Lu Baolu wrote:
> Hi John,
> 
> On 10/18/19 10:17 PM, John Donnelly wrote:
>> This cures a panic on restart after a kexec -p  operation on 5.3 and 
>> 5.4 kernels.
>>
>> The underlying state of the iommu registers (iommu->flags &
>> VTD_FLAG_TRANS_PRE_ENABLED) on a restart results in a domain being 
>> marked as
>> "DEFER_DEVICE_DOMAIN_INFO" that produces an Oops in identity_mapping().
>>
>> [   43.654737] BUG: kernel NULL pointer dereference, address:
>> 0000000000000056
>> [   43.655720] #PF: supervisor read access in kernel mode
>> [   43.655720] #PF: error_code(0x0000) - not-present page
>> [   43.655720] PGD 0 P4D 0
>> [   43.655720] Oops: 0000 [#1] SMP PTI
>> [   43.655720] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
>> 5.3.2-1940.el8uek.x86_64 #1
>> [   43.655720] Hardware name: Oracle Corporation ORACLE SERVER
>> X5-2/ASM,MOTHERBOARD,1U, BIOS 30140300 09/20/2018
>> [   43.655720] RIP: 0010:iommu_need_mapping+0x29/0xd0
>> [   43.655720] Code: 00 0f 1f 44 00 00 48 8b 97 70 02 00 00 48 83 fa ff
>> 74 53 48 8d 4a ff b8 01 00 00 00 48 83 f9 fd 76 01 c3 48 8b 35 7f 58 e0
>> 01 <48> 39 72 58 75 f2 55 48 89 e5 41 54 53 48 8b 87 28 02 00 00 4c 8b
>> [   43.655720] RSP: 0018:ffffc9000001b9b0 EFLAGS: 00010246
>> [   43.655720] RAX: 0000000000000001 RBX: 0000000000001000 RCX:
>> fffffffffffffffd
>> [   43.655720] RDX: fffffffffffffffe RSI: ffff8880719b8000 RDI:
>> ffff8880477460b0
>> [   43.655720] RBP: ffffc9000001b9e8 R08: 0000000000000000 R09:
>> ffff888047c01700
>> [   43.655720] R10: 00002194036fc692 R11: 0000000000000000 R12:
>> 0000000000000000
>> [   43.655720] R13: ffff8880477460b0 R14: 0000000000000cc0 R15:
>> ffff888072d2b558
>> [   43.655720] FS:  0000000000000000(0000) GS:ffff888071c00000(0000)
>> knlGS:0000000000000000
>> [   43.655720] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   43.655720] CR2: 0000000000000056 CR3: 000000007440a002 CR4:
>> 00000000001606b0
>> [   43.655720] Call Trace:
>> [   43.655720]  ? intel_alloc_coherent+0x2a/0x180
>> [   43.655720]  ? __schedule+0x2c2/0x650
>> [   43.655720]  dma_alloc_attrs+0x8c/0xd0
>> [   43.655720]  dma_pool_alloc+0xdf/0x200
>> [   43.655720]  ehci_qh_alloc+0x58/0x130
>> [   43.655720]  ehci_setup+0x287/0x7ba
>> [   43.655720]  ? _dev_info+0x6c/0x83
>> [   43.655720]  ehci_pci_setup+0x91/0x436
>> [   43.655720]  usb_add_hcd.cold.48+0x1d4/0x754
>> [   43.655720]  usb_hcd_pci_probe+0x2bc/0x3f0
>> [   43.655720]  ehci_pci_probe+0x39/0x40
>> [   43.655720]  local_pci_probe+0x47/0x80
>> [   43.655720]  pci_device_probe+0xff/0x1b0
>> [   43.655720]  really_probe+0xf5/0x3a0
>> [   43.655720]  driver_probe_device+0xbb/0x100
>> [   43.655720]  device_driver_attach+0x58/0x60
>> [   43.655720]  __driver_attach+0x8f/0x150
>> [   43.655720]  ? device_driver_attach+0x60/0x60
>> [   43.655720]  bus_for_each_dev+0x74/0xb0
>> [   43.655720]  driver_attach+0x1e/0x20
>> [   43.655720]  bus_add_driver+0x151/0x1f0
>> [   43.655720]  ? ehci_hcd_init+0xb2/0xb2
>> [   43.655720]  ? do_early_param+0x95/0x95
>> [   43.655720]  driver_register+0x70/0xc0
>> [   43.655720]  ? ehci_hcd_init+0xb2/0xb2
>> [   43.655720]  __pci_register_driver+0x57/0x60
>> [   43.655720]  ehci_pci_init+0x6a/0x6c
>> [   43.655720]  do_one_initcall+0x4a/0x1fa
>> [   43.655720]  ? do_early_param+0x95/0x95
>> [   43.655720]  kernel_init_freeable+0x1bd/0x262
>> [   43.655720]  ? rest_init+0xb0/0xb0
>> [   43.655720]  kernel_init+0xe/0x110
>> [   43.655720]  ret_from_fork+0x24/0x50
>>
> 
> Good catch. Can you please add:
> 
> Fixes: 8af46c784ecfe ("iommu/vt-d: Implement is_attach_deferred iommu 
> ops entry")
> Cc: stable@vger.kernel.org # v5.3+
> 
> With above:
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Best regards,
> Baolu
> 
>> Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
>> ---
>> drivers/iommu/intel-iommu.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index c4e0e4a9ee9e..f83a9a302f8e 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -2783,7 +2783,7 @@ static int identity_mapping(struct device *dev)
>>     struct device_domain_info *info;
>>
>>     info = dev->archdata.iommu;
>> -    if (info && info != DUMMY_DEVICE_DOMAIN_INFO)
>> +    if (info && info != DUMMY_DEVICE_DOMAIN_INFO && info != 
>> DEFER_DEVICE_DOMAIN_INFO)
>>         return (info->domain == si_domain);
>>
>>     return 0;
>>
> 
