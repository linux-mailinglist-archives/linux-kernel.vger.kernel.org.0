Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76AA9156335
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Feb 2020 07:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgBHGaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Feb 2020 01:30:05 -0500
Received: from mga02.intel.com ([134.134.136.20]:43989 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbgBHGaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 01:30:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 22:30:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,416,1574150400"; 
   d="scan'208";a="226704240"
Received: from zhiyuanh-mobl.ccr.corp.intel.com (HELO [10.254.211.219]) ([10.254.211.219])
  by fmsmga008.fm.intel.com with ESMTP; 07 Feb 2020 22:29:59 -0800
Subject: Re: [PATCH] iommu/intel-iommu: set as DUMMY_DEVICE_DOMAIN_INFO if no
 IOMMU
To:     Jian-Hong Pan <jian-hong@endlessm.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
References: <20200203091009.196658-1-jian-hong@endlessm.com>
 <aab0948d-c6a3-baa1-7343-f18c936d662d@linux.intel.com>
 <CAPpJ_edkkWm0DYHB3U8nQPv=z_o-aV4V7RDMuLTXL5N1H6ZYrA@mail.gmail.com>
 <948da337-128f-22ae-7b2e-730b4b8da446@linux.intel.com>
 <CAPpJ_ecM0oCUjYLbG+uTprRk0=OTUBTxZc-d2BGBRDSYWk4uSQ@mail.gmail.com>
 <c8d89c4f-1347-8b9d-0486-a29dd081f26c@linux.intel.com>
 <CAPpJ_ec6H9fqSLA9L8QXir=FBjJqV7xcXp4ea+6XJ8MotDWVyg@mail.gmail.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b36c252b-943b-3b13-1f25-a8f23e431f39@linux.intel.com>
Date:   Sat, 8 Feb 2020 14:29:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAPpJ_ec6H9fqSLA9L8QXir=FBjJqV7xcXp4ea+6XJ8MotDWVyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020/2/7 15:32, Jian-Hong Pan wrote:
> Lu Baolu <baolu.lu@linux.intel.com> 於 2020年2月6日 週四 下午6:49寫道：
>>
>> Hi,
>>
>> On 2020/2/5 18:06, Jian-Hong Pan wrote:
>>> Lu Baolu <baolu.lu@linux.intel.com> 於 2020年2月5日 週三 上午9:28寫道：
>>>>
>>>> Hi,
>>>>
>>>> On 2020/2/4 17:25, Jian-Hong Pan wrote:
>>>>> Lu Baolu <baolu.lu@linux.intel.com> 於 2020年2月4日 週二 下午2:11寫道：
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On 2020/2/3 17:10, Jian-Hong Pan wrote:
>>>>>>> If the device has no IOMMU, it still invokes iommu_need_mapping during
>>>>>>> intel_alloc_coherent. However, iommu_need_mapping can only check the
>>>>>>> device is DUMMY_DEVICE_DOMAIN_INFO or not. This patch marks the device
>>>>>>> is a DUMMY_DEVICE_DOMAIN_INFO if the device has no IOMMU.
>>>>>>>
>>>>>>> Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
>>>>>>> ---
>>>>>>>      drivers/iommu/intel-iommu.c | 4 +++-
>>>>>>>      1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>>>>>>> index 35a4a3abedc6..878bc986a015 100644
>>>>>>> --- a/drivers/iommu/intel-iommu.c
>>>>>>> +++ b/drivers/iommu/intel-iommu.c
>>>>>>> @@ -5612,8 +5612,10 @@ static int intel_iommu_add_device(struct device *dev)
>>>>>>>          int ret;
>>>>>>>
>>>>>>>          iommu = device_to_iommu(dev, &bus, &devfn);
>>>>>>> -     if (!iommu)
>>>>>>> +     if (!iommu) {
>>>>>>> +             dev->archdata.iommu = DUMMY_DEVICE_DOMAIN_INFO;
>>>>>>
>>>>>> Is this a DMA capable device?
>>>>>
>>>>> Do you mean is the device in DMA Remapping table?
>>>>> Dump DMAR from ACPI table.  The device is not in the table.
>>>>> So, it does not support DMAR, Intel IOMMU.
>>>>>
>>>>> Or, should device_to_iommu be invoked in iommu_need_mapping to check
>>>>> IOMMU feature again?
>>>>>
>>>>
>>>> Normally intel_iommu_add_device() should only be called for PCI devices
>>>> and APCI name space devices (reported in ACPI/DMAR table). In both
>>>> cases, device_to_iommu() should always return a corresponding iommu. I
>>>> just tried to understand why it failed for your case.
>>>
>>> We found all of the DMAR featured devices's PCI Segment Number is *0000*.
>>> But the devices locating under segment/domain *0001* hit the issue,
>>> until the patch is applied.
>>>
>>> Because of different segment numbers, none of iommu will be matched by
>>> for_each_active_iommu(iommu, drhd) loop in function device_to_iommu()
>>> and it will return NULL.  So, intel_iommu_add_device() returns no
>>> device.
>>>
>>> I can share the DMAR:
>>> /*
>>>    * Intel ACPI Component Architecture
>>>    * AML/ASL+ Disassembler version 20200110 (64-bit version)
>>>    * Copyright (c) 2000 - 2020 Intel Corporation
>>>    *
>>>    * Disassembly of dmar.dat, Wed Jan 22 11:41:50 2020
>>>    *
>>>    * ACPI Data Table [DMAR]
>>>    *
>>>    * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
>>>    */
>>>
>>> [000h 0000   4]                    Signature : "DMAR"    [DMA Remapping table]
>>> [004h 0004   4]                 Table Length : 000000A8
>>> [008h 0008   1]                     Revision : 01
>>> [009h 0009   1]                     Checksum : 5E
>>> [00Ah 0010   6]                       Oem ID : "INTEL "
>>> [010h 0016   8]                 Oem Table ID : "EDK2    "
>>> [018h 0024   4]                 Oem Revision : 00000002
>>> [01Ch 0028   4]              Asl Compiler ID : "    "
>>> [020h 0032   4]        Asl Compiler Revision : 01000013
>>>
>>> [024h 0036   1]           Host Address Width : 26
>>> [025h 0037   1]                        Flags : 05
>>> [026h 0038  10]                     Reserved : 00 00 00 00 00 00 00 00 00 00
>>>
>>> [030h 0048   2]                Subtable Type : 0000 [Hardware Unit Definition]
>>> [032h 0050   2]                       Length : 0018
>>>
>>> [034h 0052   1]                        Flags : 00
>>> [035h 0053   1]                     Reserved : 00
>>> [036h 0054   2]           PCI Segment Number : 0000
>>> [038h 0056   8]        Register Base Address : 00000000FED90000
>>>
>>> [040h 0064   1]            Device Scope Type : 01 [PCI Endpoint Device]
>>> [041h 0065   1]                 Entry Length : 08
>>> [042h 0066   2]                     Reserved : 0000
>>> [044h 0068   1]               Enumeration ID : 00
>>> [045h 0069   1]               PCI Bus Number : 00
>>>
>>> [046h 0070   2]                     PCI Path : 02,00
>>>
>>>
>>> [048h 0072   2]                Subtable Type : 0000 [Hardware Unit Definition]
>>> [04Ah 0074   2]                       Length : 0020
>>>
>>> [04Ch 0076   1]                        Flags : 01
>>> [04Dh 0077   1]                     Reserved : 00
>>> [04Eh 0078   2]           PCI Segment Number : 0000
>>> [050h 0080   8]        Register Base Address : 00000000FED91000
>>>
>>> [058h 0088   1]            Device Scope Type : 03 [IOAPIC Device]
>>> [059h 0089   1]                 Entry Length : 08
>>> [05Ah 0090   2]                     Reserved : 0000
>>> [05Ch 0092   1]               Enumeration ID : 02
>>> [05Dh 0093   1]               PCI Bus Number : 00
>>>
>>> [05Eh 0094   2]                     PCI Path : 1E,07
>>>
>>>
>>> [060h 0096   1]            Device Scope Type : 04 [Message-capable HPET Device]
>>> [061h 0097   1]                 Entry Length : 08
>>> [062h 0098   2]                     Reserved : 0000
>>> [064h 0100   1]               Enumeration ID : 00
>>> [065h 0101   1]               PCI Bus Number : 00
>>>
>>> [066h 0102   2]                     PCI Path : 1E,06
>>>
>>>
>>> [068h 0104   2]                Subtable Type : 0001 [Reserved Memory Region]
>>> [06Ah 0106   2]                       Length : 0020
>>>
>>> [06Ch 0108   2]                     Reserved : 0000
>>> [06Eh 0110   2]           PCI Segment Number : 0000
>>> [070h 0112   8]                 Base Address : 000000006F58B000
>>> [078h 0120   8]          End Address (limit) : 000000006F7D4FFF
>>>
>>> [080h 0128   1]            Device Scope Type : 01 [PCI Endpoint Device]
>>> [081h 0129   1]                 Entry Length : 08
>>> [082h 0130   2]                     Reserved : 0000
>>> [084h 0132   1]               Enumeration ID : 00
>>> [085h 0133   1]               PCI Bus Number : 00
>>>
>>> [086h 0134   2]                     PCI Path : 14,00
>>>
>>>
>>> [088h 0136   2]                Subtable Type : 0001 [Reserved Memory Region]
>>> [08Ah 0138   2]                       Length : 0020
>>>
>>> [08Ch 0140   2]                     Reserved : 0000
>>> [08Eh 0142   2]           PCI Segment Number : 0000
>>> [090h 0144   8]                 Base Address : 0000000079800000
>>> [098h 0152   8]          End Address (limit) : 000000007DFFFFFF
>>>
>>> [0A0h 0160   1]            Device Scope Type : 01 [PCI Endpoint Device]
>>> [0A1h 0161   1]                 Entry Length : 08
>>> [0A2h 0162   2]                     Reserved : 0000
>>> [0A4h 0164   1]               Enumeration ID : 00
>>> [0A5h 0165   1]               PCI Bus Number : 00
>>>
>>> [0A6h 0166   2]                     PCI Path : 02,00
>>>
>>>
>>> Raw Table Data: Length 168 (0xA8)
>>>
>>>       0000: 44 4D 41 52 A8 00 00 00 01 5E 49 4E 54 45 4C 20  // DMAR.....^INTEL
>>>       0010: 45 44 4B 32 20 20 20 20 02 00 00 00 20 20 20 20  // EDK2    ....
>>>       0020: 13 00 00 01 26 05 00 00 00 00 00 00 00 00 00 00  // ....&...........
>>>       0030: 00 00 18 00 00 00 00 00 00 00 D9 FE 00 00 00 00  // ................
>>>       0040: 01 08 00 00 00 00 02 00 00 00 20 00 01 00 00 00  // .......... .....
>>>       0050: 00 10 D9 FE 00 00 00 00 03 08 00 00 02 00 1E 07  // ................
>>>       0060: 04 08 00 00 00 00 1E 06 01 00 20 00 00 00 00 00  // .......... .....
>>>       0070: 00 B0 58 6F 00 00 00 00 FF 4F 7D 6F 00 00 00 00  // ..Xo.....O}o....
>>>       0080: 01 08 00 00 00 00 14 00 01 00 20 00 00 00 00 00  // .......... .....
>>>       0090: 00 00 80 79 00 00 00 00 FF FF FF 7D 00 00 00 00  // ...y.......}....
>>>       00A0: 01 08 00 00 00 00 02 00                          // ........
>>>
>>> Here is the lspci:
>>> 0000:00:00.0 Host bridge: Intel Corporation Device 9b61 (rev 0c)
>>> 0000:00:02.0 VGA compatible controller: Intel Corporation Device 9b41 (rev 02)
>>> 0000:00:04.0 Signal processing controller: Intel Corporation Skylake
>>> Processor Thermal Subsystem (rev 0c)
>>> 0000:00:08.0 System peripheral: Intel Corporation Skylake Gaussian Mixture Model
>>> 0000:00:12.0 Signal processing controller: Intel Corporation Device 02f9
>>> 0000:00:13.0 Serial controller: Intel Corporation Device 02fc
>>> 0000:00:14.0 USB controller: Intel Corporation Device 02ed
>>> 0000:00:14.2 RAM memory: Intel Corporation Device 02ef
>>> 0000:00:14.3 Network controller: Intel Corporation Device 02f0
>>> 0000:00:15.0 Serial bus controller [0c80]: Intel Corporation Device 02e8
>>> 0000:00:15.1 Serial bus controller [0c80]: Intel Corporation Device 02e9
>>> 0000:00:15.2 Serial bus controller [0c80]: Intel Corporation Device 02ea
>>> 0000:00:16.0 Communication controller: Intel Corporation Device 02e0
>>> 0000:00:17.0 RAID bus controller: Intel Corporation Device 02d7
>>> 0000:00:1c.0 PCI bridge: Intel Corporation Device 02b8 (rev f0)
>>> 0000:00:1e.0 Communication controller: Intel Corporation Device 02a8
>>> 0000:00:1e.2 Serial bus controller [0c80]: Intel Corporation Device 02aa
>>> 0000:00:1f.0 ISA bridge: Intel Corporation Device 0284
>>> 0000:00:1f.3 Audio device: Intel Corporation Device 02c8
>>> 0000:00:1f.4 SMBus: Intel Corporation Device 02a3
>>> 0000:00:1f.5 Serial bus controller [0c80]: Intel Corporation Device 02a4
>>> 0000:00:1f.6 Ethernet controller: Intel Corporation Device 0d4f
>>> 0000:01:00.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3
>>> Bridge [Titan Ridge 4C 2018] (rev 06)
>>> 0000:02:00.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3
>>> Bridge [Titan Ridge 4C 2018] (rev 06)
>>> 0000:02:01.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3
>>> Bridge [Titan Ridge 4C 2018] (rev 06)
>>> 0000:02:02.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3
>>> Bridge [Titan Ridge 4C 2018] (rev 06)
>>> 0000:02:04.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3
>>> Bridge [Titan Ridge 4C 2018] (rev 06)
>>> 0000:03:00.0 System peripheral: Intel Corporation JHL7540 Thunderbolt
>>> 3 NHI [Titan Ridge 4C 2018] (rev 06)
>>> 0000:37:00.0 USB controller: Intel Corporation JHL7540 Thunderbolt 3
>>> USB Controller [Titan Ridge 4C 2018] (rev 06)
>>> 0001:00:00.0 SATA controller: Intel Corporation Device 02d7
>>> 0001:00:01.0 Non-Volatile memory controller: Intel Corporation Device 0000
>>> 0001:00:02.0 Non-Volatile memory controller: Intel Corporation Device 0000
>>>
>>
>> So devices are sitting in PCI segment 1, while ACPI/DMAR only reports
>> IOMMU units for PCI segment 0. Do I understand it right?
> 
> Yes.
> 
>> Is it possible that hardware supports DMAR for both PCI segment 0 and 1,
>> but the firmware doesn't reports those for PCI segement 1?
> 
> Good question!  I have not think the change of DMAR for segment 0 and
> 1.  But, I guess the answer is not.  The hardware vendor will say
> Windows works fine ...
> 
> The devices under segment 1 are fake devices produced by
> intel-nvme-remap mentioned here https://lkml.org/lkml/2020/2/5/139
> 

Has this series been accepted?

> We are also curios about why VMD (drivers/pci/controller/vmd.c) works
> fine here.  It also produces fake devices, but can use iommu
> correctly.  Due to no VMD related machines on hand, it is hard to
> trace the flow.  Could you please give us some clues?

Will this help here? https://www.spinics.net/lists/iommu/msg41300.html

Best regards,
baolu
