Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1924DF6F58
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 09:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfKKICE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Nov 2019 03:02:04 -0500
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:35478 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfKKICE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 03:02:04 -0500
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id xAB81YtL004733
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 11 Nov 2019 17:01:34 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id xAB81XoH029777;
        Mon, 11 Nov 2019 17:01:33 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id xAB7xwjS001591;
        Mon, 11 Nov 2019 17:01:33 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.152] [10.38.151.152]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-641210; Mon, 11 Nov 2019 17:00:13 +0900
Received: from BPXM20GP.gisp.nec.co.jp ([10.38.151.212]) by
 BPXC24GP.gisp.nec.co.jp ([10.38.151.152]) with mapi id 14.03.0439.000; Mon,
 11 Nov 2019 17:00:13 +0900
From:   Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
To:     Michal Hocko <mhocko@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "hch@lst.de" <hch@lst.de>,
        "longman@redhat.com" <longman@redhat.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "mst@redhat.com" <mst@redhat.com>, "cai@lca.pw" <cai@lca.pw>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: Re: [PATCH 0/3] make pfn walker support ZONE_DEVICE
Thread-Topic: [PATCH 0/3] make pfn walker support ZONE_DEVICE
Thread-Index: AQHVlciWlfuQn46br0aHiPqwVpeT66eAaKCAgAShS4A=
Date:   Mon, 11 Nov 2019 08:00:12 +0000
Message-ID: <5fc7da0c-bd79-9f3b-e5d9-8688648cf032@vx.jp.nec.com>
References: <20191108000855.25209-1-t-fukasawa@vx.jp.nec.com>
 <20191108091851.GB15658@dhcp22.suse.cz>
In-Reply-To: <20191108091851.GB15658@dhcp22.suse.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.135]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <08075FF5519BA149B29FF17900429CC7@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/11/08 18:18, Michal Hocko wrote:
> On Fri 08-11-19 00:08:03, Toshiki Fukasawa wrote:
>> This patch set tries to make pfn walker support ZONE_DEVICE.
>> This idea is from the TODO in below patch:
>>
>>    commit aad5f69bc161af489dbb5934868bd347282f0764
>>    Author: David Hildenbrand <david@redhat.com>
>>    Date:   Fri Oct 18 20:19:20 2019 -0700
>>
>> 	fs/proc/page.c: don't access uninitialized memmaps in fs/proc/page.c
>>
>> pfn walker's ZONE_DEVICE support requires capability to identify
>> that a memmap has been initialized. The uninitialized cases are
>> as follows:
>>
>> 	a) pages reserved for ZONE_DEVICE driver
>> 	b) pages currently initializing
>>
>> This patch set solves both of them.
> 
> Why do we want this? What is the usecase?

We are writing a test program for hwpoison, which is a use case.
Without this patch, we can't see the HWPOISON flag on the
ZONE_DEVICE page.

Thanks,
Toshiki Fukasawa
