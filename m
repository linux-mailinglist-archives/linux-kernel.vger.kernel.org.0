Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16BE2D5E10
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 11:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbfJNJCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 05:02:13 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39483 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730432AbfJNJCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 05:02:13 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191014090211euoutp020aa3e0d59fa40f9029a8d8b9f4f00aaa~Nd-NB_7TZ1063410634euoutp02p
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 09:02:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191014090211euoutp020aa3e0d59fa40f9029a8d8b9f4f00aaa~Nd-NB_7TZ1063410634euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1571043731;
        bh=cO+wLtuW1/Yo97buZEw+qgmmgFL/YbKANib/7pQpOmk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=MRcwLPOZ4CwbsFJY2pkiZbJJTNB/Bsv35makNpKxSS38wLVmQ3/x3EGwZ6i7hJquE
         X2eKDeQFzKAni4+jeHe8SNt4dVQ4BIKzFd0Zv+OWVfOdcHCq5ToH91HTx4F+UtOjNJ
         vm2M+oBS/qvvPQ9/rSHNV2DDG+PoheJc+aSqqr5g=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191014090211eucas1p166d9145f016049559c4df5671968af66~Nd-M1JP0M3102231022eucas1p1v;
        Mon, 14 Oct 2019 09:02:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 96.DF.04374.39934AD5; Mon, 14
        Oct 2019 10:02:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191014090211eucas1p23a0c6b43599efdeea47d13be210b5260~Nd-MiuFha1565215652eucas1p2D;
        Mon, 14 Oct 2019 09:02:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191014090211eusmtrp11ab717af595719f005ad7f60d49aee58~Nd-MiFovP1207812078eusmtrp1d;
        Mon, 14 Oct 2019 09:02:11 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-f1-5da439933587
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 23.8B.04117.39934AD5; Mon, 14
        Oct 2019 10:02:11 +0100 (BST)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191014090210eusmtip2699cbc2afc4ae9976adb5f73eeca5d5c~Nd-MIj21U2719827198eusmtip2i;
        Mon, 14 Oct 2019 09:02:10 +0000 (GMT)
Subject: Re: ARM Juno r1 + CONFIG_PROVE_LOCKING=y => boot failure
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <7ef07169-4335-0a73-8bce-229433ef96f5@samsung.com>
Date:   Mon, 14 Oct 2019 11:02:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191011144233.GA2438@bogus>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsWy7djP87qTLZfEGtw8KW3xflkPo8X9fcuZ
        LDY9vsZqcXnXHDaLA0vbWSze/H7BbrH81A4Wi5Y7pg4cHmvmrWH02LSqk81j85J6j8+b5AJY
        orhsUlJzMstSi/TtErgy1h67wVwwT6RizsHNzA2MJwW6GDk5JARMJDYc/sDSxcjFISSwglHi
        0umJrBDOF0aJ18feMkM4nxkl7t7tZodpufb1GhOILSSwnFGi4V0oRNFbRombdyESwgKOEg3T
        bzGD2CIC6hJLzm5hBLGZBSYxSUz+JAZiswkYSnS97WIDsXkF7CQevGgAW8AioCrxduJxMFtU
        IFbi3o/jzBA1ghInZz5hAbE5BbQk/m89BTVTXmL72znMELa4xK0n85lADpIQ2MQuse0mRJGE
        gIvEu8+HWCFsYYlXx7dAfSMjcXpyDwtEQzOjxMNza9khnB5GictNM6C6rSUOH78I1M0BtEJT
        Yv0ufYiwo8TcgyeYQMISAnwSN94KQhzBJzFp23RmiDCvREebEES1msSs4+vg1h68cIl5AqPS
        LCSvzULyziwk78xC2LuAkWUVo3hqaXFuemqxcV5quV5xYm5xaV66XnJ+7iZGYAI6/e/41x2M
        +/4kHWIU4GBU4uE9kbw4Vog1say4MvcQowQHs5IIL8OEBbFCvCmJlVWpRfnxRaU5qcWHGKU5
        WJTEeasZHkQLCaQnlqRmp6YWpBbBZJk4OKUaGA8vvLGczfxnuNxGTv7eayU72V96sa60d330
        XWn5jaCNR3T2bL5kdr6NL2bZenadr0pfZ4S0aOQ8TbPtVQw7XvWCa4LYU2abnXXvcq1bJ5dv
        rbzIPU9bZFIFg4m85UfDa7Y9kwNvfzH7YZqd8jeQ7d/k+bcm/eiPe33JqC7CmztVm1t3zryZ
        R5VYijMSDbWYi4oTAT5Akq88AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsVy+t/xe7qTLZfEGhw8xWHxflkPo8X9fcuZ
        LDY9vsZqcXnXHDaLA0vbWSze/H7BbrH81A4Wi5Y7pg4cHmvmrWH02LSqk81j85J6j8+b5AJY
        ovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQy1h67
        wVwwT6RizsHNzA2MJwW6GDk5JARMJK59vcYEYgsJLGWU2NSdARGXkTg5rYEVwhaW+HOti62L
        kQuo5jWjxIfOb2wgCWEBR4mG6beYQWwRAXWJJWe3MIIUMQtMYZI4Nn8uO8TU1cwSU7aUg9hs
        AoYSXW+7wJp5BewkHrxoAKthEVCVeDvxOJDNwSEqECuxaa8ZRImgxMmZT1hAbE4BLYn/W08x
        gtjMAmYS8zY/ZIaw5SW2v50DZYtL3Hoyn2kCo9AsJO2zkLTMQtIyC0nLAkaWVYwiqaXFuem5
        xUZ6xYm5xaV56XrJ+bmbGIHxtu3Yzy07GLveBR9iFOBgVOLhVUhbHCvEmlhWXJl7iFGCg1lJ
        hJdhwoJYId6UxMqq1KL8+KLSnNTiQ4ymQL9NZJYSTc4HpoK8knhDU0NzC0tDc2NzYzMLJXHe
        DoGDMUIC6YklqdmpqQWpRTB9TBycUg2M1rOCclXkt1gxxG/5nJ2WvzBPUOUp29Zf4ZNqjm+o
        u79lUvKy4i81UaVhW2zLF//Ve2QU3makpDiz4GDYz5/aC5x+zAvqWu0bKqqy8vSWkpnHzrOE
        nK/95bw2KUdcwNf+w6sEb72nZZlrfix2fpp4fOanA5H8d4wXTE/dbZoX8MHp1kbDtoCVSizF
        GYmGWsxFxYkAiZF5iM0CAAA=
X-CMS-MailID: 20191014090211eucas1p23a0c6b43599efdeea47d13be210b5260
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191011092604eucas1p1ca11ab9c4c7508776914b0eb4f35e69b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191011092604eucas1p1ca11ab9c4c7508776914b0eb4f35e69b
References: <CGME20191011092604eucas1p1ca11ab9c4c7508776914b0eb4f35e69b@eucas1p1.samsung.com>
        <33a83dce-e9f0-7814-923b-763d33e70257@samsung.com>
        <20191011100521.GA5122@bogus> <7655fb41-cd13-0bc4-e656-040e0875bab8@arm.com>
        <2bf88cd2-9c4f-11dc-4b70-f717de891cff@samsung.com>
        <20191011131058.GA26061@bogus>
        <0b02b15f-38be-7a63-14cc-eabd288782eb@samsung.com>
        <20191011134354.GA31516@bogus> <20191011144233.GA2438@bogus>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On 11.10.2019 16:42, Sudeep Holla wrote:
> On Fri, Oct 11, 2019 at 02:43:54PM +0100, Sudeep Holla wrote:
>> On Fri, Oct 11, 2019 at 03:15:32PM +0200, Marek Szyprowski wrote:
>>> Hi Sudeep
>>>
>>> On 11.10.2019 15:10, Sudeep Holla wrote:
>>>> On Fri, Oct 11, 2019 at 03:02:42PM +0200, Marek Szyprowski wrote:
>>>>> Hi James,
>>>>>
>>>>> On 11.10.2019 12:38, James Morse wrote:
>>>>>> Hi guys,
>>>>>>
>>>>>> On 11/10/2019 11:05, Sudeep Holla wrote:
>>>>>>> On Fri, Oct 11, 2019 at 11:26:04AM +0200, Marek Szyprowski wrote:
>>>>>>>> Recently I've got access to ARM Juno R1 board and did some tests with
>>>>>>>> current mainline kernel on it. I'm a bit surprised that enabling
>>>>>>>> CONFIG_PROVE_LOCKING causes a boot failure on this board. After enabling
>>>>>>>> this Kconfig option, I get no single message from the kernel, although I
>>>>>>>> have earlycon enabled.
>>>>>>> I don't have Juno R1 but I tried defconfig + CONFIG_PROVE_LOCKING and
>>>>>>> it boots fine.
>>>>>> I just tried this on my r1, v5.4-rc1 with this configuration worked just fine.
>>>>>>
>>>>>> My cmdline is:
>>>>>> | root=/dev/sda6 loglevel=9 earlycon=pl011,0x7ff80000 hugepagesz=2M hugepages=512
>>>>>> | crashkernel=1G console=ttyAMA0 resume=/dev/sda2 no_console_suspend efi=debug
>>>>>>
>>>>> That is a bit strange. Here is a boot log from v5.4-rc1 with pure
>>>>> defconfig: https://paste.debian.net/1105851/
>>>>>
>>>> I see from the boot log that both Image.gz and dtb being loaded at the
>>>> same address 0x82000000, will u-boot uncompress it elsewhere after loading
>>>> it ? Just for my understanding.
>>> tftp downloads Image.gz to 0x82000000, then decompress it to
>>> $kernel_addr to save transfer time
>>>
>>> my bootcmd is:
>>>
>>> tftp ${fdt_addr} juno/Image.gz; unzip ${fdt_addr} ${kernel_addr}; tftp
>>> ${fdt_addr} juno/juno-r1.dtb; booti ${kernel_addr} - ${fdt_addr};
>>>
> If your ${kernel_addr}=0x80000000 or within first 32MB, then it will override
> DTB with the image size I had(35MB). Even if kernel fits 32MB, there is a
> chance that .bss lies beyond 32MB and it will be cleared during boot resulting
> in DTB corruption(Andre P reminded me this)
>
> Can you try setting $${fdt_addr} to 0x84000000 to begin with ?

Right, my fault. Changing fdt_addr to something higher than the default 
0x82000000 fixed the boot issue. I wonder how I missed that, as I was 
convinced that there is enough space for the kernel image. Sorry for the 
noise...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

