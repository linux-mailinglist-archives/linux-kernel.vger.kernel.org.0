Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A34211E8C4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 09:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfEOHKs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 May 2019 03:10:48 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:54068 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfEOHKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 03:10:47 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x4F7AJQU030613
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 15 May 2019 16:10:20 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x4F7AJkx017304;
        Wed, 15 May 2019 16:10:19 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x4F7AJj5007322;
        Wed, 15 May 2019 16:10:19 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.135] [10.38.151.135]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-405354; Wed, 15 May 2019 16:09:44 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC07GP.gisp.nec.co.jp ([10.38.151.135]) with mapi id 14.03.0319.002; Wed,
 15 May 2019 16:09:44 +0900
From:   Junichi Nomura <j-nomura@ce.jp.nec.com>
To:     Borislav Petkov <bp@alien8.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     Baoquan He <bhe@redhat.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
Thread-Topic: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI
 systab and ACPI tables
Thread-Index: AQHVCt13YD4lckvUHUCIqj5Wl9aEBaZrKqmAgAADEQA=
Date:   Wed, 15 May 2019 07:09:43 +0000
Message-ID: <20190515070942.GA17154@jeru.linux.bs1.fc.nec.co.jp>
References: <20190424092944.30481-2-bhe@redhat.com>
 <20190429002318.GA25400@MiWiFi-R3L-srv> <20190429135536.GC2324@zn.tnic>
 <20190513014248.GA16774@MiWiFi-R3L-srv> <20190513070725.GA20105@zn.tnic>
 <20190513073254.GB16774@MiWiFi-R3L-srv> <20190513075006.GB20105@zn.tnic>
 <20190513080210.GC16774@MiWiFi-R3L-srv>
 <20190515051717.GA13703@jeru.linux.bs1.fc.nec.co.jp>
 <20190515065843.GA24212@zn.tnic>
In-Reply-To: <20190515065843.GA24212@zn.tnic>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <A094AF2DEB5936499C61698B73C9C0AC@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/19 3:58 PM, Borislav Petkov wrote:
> On Wed, May 15, 2019 at 05:17:19AM +0000, Junichi Nomura wrote:
>> Hi Kairui,
>>
>> On 5/13/19 5:02 PM, Baoquan He wrote:
>>> On 05/13/19 at 09:50am, Borislav Petkov wrote:
>>>> On Mon, May 13, 2019 at 03:32:54PM +0800, Baoquan He wrote:
>>>> So we're going to try it again this cycle and if there's no fallout, it
>>>> will go upstream. If not, it will have to be fixed. The usual thing.
>>>>
>>>> And I don't care if Kairui's patch fixes this one problem - judging by
>>>> the fragility of this whole thing, it should be hammered on one more
>>>> cycle on as many boxes as possible to make sure there's no other SNAFUs.
>>>>
>>>> So go test it on more machines instead. I've pushed it here:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=next-merge-window
>>>
>>> Pingfan has got a machine to reproduce the kexec breakage issue, and
>>> applying these two patches fix it. He planned to paste the test result.
>>> I will ask him to try this branch if he has time, or I can get his
>>> machine to test.
>>>
>>> Junichi, also have a try on Boris's branch in NEC's test environment?
>>
>> while the patch set works on most of the machines I'm testing around,
>> I found kexec(1) fails to load kernel on a few machines if this patch
>> is applied.  Those machines don't have IORES_DESC_ACPI_TABLES region
>> and have ACPI tables in IORES_DESC_ACPI_NV_STORAGE region instead.
> 
> Why? What kind of machines are those?

I don't know.  They are just general purpose Xeon-based servers
and not some special purpose machines.  So I guess there are other
such machines in the wild.

> Why are the ACPI tables in NV storage?
> 
> Looking at crash_setup_memmap_entries(), it already maps that type so I
> guess this is needed.
> 
> + Rafael and leaving in the rest for reference.
> 
>  
>> So I think map_acpi_tables() should try to map both regions.  I tried
>> following change in addition and it worked.
>>
>> -- 
>> Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
>>
>>
>> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
>> index 3c77bdf..3837c4a 100644
>> --- a/arch/x86/kernel/machine_kexec_64.c
>> +++ b/arch/x86/kernel/machine_kexec_64.c
>> @@ -56,12 +56,22 @@ static int mem_region_callback(struct resource *res, void *arg)
>>  {
>>  	unsigned long flags = IORESOURCE_MEM | IORESOURCE_BUSY;
>>  	struct init_pgtable_data data;
>> +	int ret;
>>  
>>  	data.info = info;
>>  	data.level4p = level4p;
>>  	flags = IORESOURCE_MEM | IORESOURCE_BUSY;
>> -	return walk_iomem_res_desc(IORES_DESC_ACPI_TABLES, flags, 0, -1,
>> -				   &data, mem_region_callback);
>> +	ret = walk_iomem_res_desc(IORES_DESC_ACPI_TABLES, flags, 0, -1,
>> +				  &data, mem_region_callback);
>> +	if (ret && ret != -EINVAL)
>> +		return ret;
>> +
>> +	ret = walk_iomem_res_desc(IORES_DESC_ACPI_NV_STORAGE, flags, 0, -1,
>> +				  &data, mem_region_callback);
>> +	if (ret && ret != -EINVAL)
>> +		return ret;
>> +
>> +	return 0;
>>  }
>>  #else
>>  static int map_acpi_tables(struct x86_mapping_info *info, pgd_t *level4p) { return 0; }

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
