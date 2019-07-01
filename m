Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1DB1E7CD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 07:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfEOFGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 01:06:35 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45056 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfEOFGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 01:06:35 -0400
Received: by mail-pl1-f195.google.com with SMTP id a5so699281pls.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 22:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+qom0Qn6LwXg8UJkqiMrz8BQabBvoo+xpSl9SHnkWOY=;
        b=ljd68WCoxWVJmJD0JXxV19e8UA91eoaQNKOzgb7oyhLicTb0os8tq/RvEYJZMS4ffg
         /mBwhfR50qZ+1+F12A7yuQ42UWR1HKNZqBJ1HWbpLjH80kd7TGVR5lrsm2mee09uS31W
         HgxyGqpiBODbvbTwdwL0TrqC1RO1g6OSxnzakd8lx7Oj889O0ma/RHla8oyT9aczAtQy
         HYMr73WiHRZeGwfIMafqbWs383PmLw/QlkpcDELV4GKbJV/8L+533OLS2YPqqj9pjPTw
         Yjhw0Yxdh8P0FYxXc8SJsydtX8SVfA/KveK0T5+1RuPHD4a7LtcEHao53bVVy9vR0Ere
         Pz/w==
X-Gm-Message-State: APjAAAXAsFKE4QPayvS7/7h/7xSetmhKYKDixTH4hwCi3ngbDrjCu9dG
        QYnXDOUvE+LD6XC2IWSm5c1X/Q==
X-Google-Smtp-Source: APXvYqydcRf68wup3tmXCJXop6KI1ZxTGUxdyH6wtMYn4HOqUMhx5MO0r5tKJnQQFTgrfoAnruhVow==
X-Received: by 2002:a17:902:2e83:: with SMTP id r3mr26825633plb.139.1557896794167;
        Tue, 14 May 2019 22:06:34 -0700 (PDT)
Received: from localhost.localdomain ([106.215.121.117])
        by smtp.gmail.com with ESMTPSA id v81sm1354825pfa.16.2019.05.14.22.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 22:06:32 -0700 (PDT)
Subject: Re: [PATCH 0/4] support reserving crashkernel above 4G on arm64 kdump
To:     Chen Zhou <chenzhou10@huawei.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, akpm@linux-foundation.org,
        ard.biesheuvel@linaro.org, rppt@linux.ibm.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, ebiederm@xmission.com
Cc:     wangkefeng.wang@huawei.com, linux-mm@kvack.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        takahiro.akashi@linaro.org, horms@verge.net.au,
        linux-arm-kernel@lists.infradead.org,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>
References: <20190507035058.63992-1-chenzhou10@huawei.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <a9d017d0-82d3-3e5f-4af2-4c611393106d@redhat.com>
Date:   Wed, 15 May 2019 10:36:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190507035058.63992-1-chenzhou10@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc kexec-list.

Hi Chen,

I think we are still in the quiet period of the merge cycle, but this is 
a change which will be useful for systems like HPE Apollo where we are 
looking at reserving crashkernel across a larger range.

Some comments inline and in respective patch threads..

On 05/07/2019 09:20 AM, Chen Zhou wrote:
> This patch series enable reserving crashkernel on high memory in arm64.

Please fix the patch subject, it should be v5.
Also please Cc the kexec-list (kexec@lists.infradead.org) for future 
versions to allow wider review of the patchset.

> We use crashkernel=X to reserve crashkernel below 4G, which will fail
> when there is no enough memory. Currently, crashkernel=Y@X can be used
> to reserve crashkernel above 4G, in this case, if swiotlb or DMA buffers
> are requierd, capture kernel will boot failure because of no low memory.

... ^^ required

s/capture kernel will boot failure because of no low memory./capture 
kernel boot will fail because there is no low memory available for 
allocation.

> When crashkernel is reserved above 4G in memory, kernel should reserve
> some amount of low memory for swiotlb and some DMA buffers. So there may
> be two crash kernel regions, one is below 4G, the other is above 4G. Then
> Crash dump kernel reads more than one crash kernel regions via a dtb
> property under node /chosen,
> linux,usable-memory-range = <BASE1 SIZE1 [BASE2 SIZE2]>.

Please use consistent naming for the second kernel, better to use crash 
dump kernel.

I have tested this on my HPE Apollo machine and with 
crashkernel=886M,high syntax, I can get the board to reserve a larger 
memory range for the crashkernel (i.e. 886M):

# dmesg | grep -i crash
[    0.000000] kexec_core: Reserving 256MB of low memory at 3560MB for 
crashkernel (System low RAM: 2029MB)
[    0.000000] crashkernel reserved: 0x0000000bc5a00000 - 
0x0000000bfd000000 (886 MB)

kexec/kdump can also work also work fine on the board.

So, with the changes suggested in this cover letter and individual 
patches, please feel free to add:

Reviewed-and-Tested-by: Bhupesh Sharma <bhsharma@redhat.com>

Thanks,
Bhupesh

> Besides, we need to modify kexec-tools:
>    arm64: support more than one crash kernel regions(see [1])
> 
> I post this patch series about one month ago. The previous changes and
> discussions can be retrived from:
> 
> Changes since [v4]
> - reimplement memblock_cap_memory_ranges for multiple ranges by Mike.
> 
> Changes since [v3]
> - Add memblock_cap_memory_ranges back for multiple ranges.
> - Fix some compiling warnings.
> 
> Changes since [v2]
> - Split patch "arm64: kdump: support reserving crashkernel above 4G" as
>    two. Put "move reserve_crashkernel_low() into kexec_core.c" in a separate
>    patch.
> 
> Changes since [v1]:
> - Move common reserve_crashkernel_low() code into kernel/kexec_core.c.
> - Remove memblock_cap_memory_ranges() i added in v1 and implement that
>    in fdt_enforce_memory_region().
>    There are at most two crash kernel regions, for two crash kernel regions
>    case, we cap the memory range [min(regs[*].start), max(regs[*].end)]
>    and then remove the memory range in the middle.
> 
> [1]: http://lists.infradead.org/pipermail/kexec/2019-April/022792.html
> [v1]: https://lkml.org/lkml/2019/4/2/1174
> [v2]: https://lkml.org/lkml/2019/4/9/86
> [v3]: https://lkml.org/lkml/2019/4/9/306
> [v4]: https://lkml.org/lkml/2019/4/15/273
> 
> Chen Zhou (3):
>    x86: kdump: move reserve_crashkernel_low() into kexec_core.c
>    arm64: kdump: support reserving crashkernel above 4G
>    kdump: update Documentation about crashkernel on arm64
> 
> Mike Rapoport (1):
>    memblock: extend memblock_cap_memory_range to multiple ranges
> 
>   Documentation/admin-guide/kernel-parameters.txt |  6 +--
>   arch/arm64/include/asm/kexec.h                  |  3 ++
>   arch/arm64/kernel/setup.c                       |  3 ++
>   arch/arm64/mm/init.c                            | 72 +++++++++++++++++++------
>   arch/x86/include/asm/kexec.h                    |  3 ++
>   arch/x86/kernel/setup.c                         | 66 +++--------------------
>   include/linux/kexec.h                           |  5 ++
>   include/linux/memblock.h                        |  2 +-
>   kernel/kexec_core.c                             | 56 +++++++++++++++++++
>   mm/memblock.c                                   | 44 +++++++--------
>   10 files changed, 157 insertions(+), 103 deletions(-)
> 

