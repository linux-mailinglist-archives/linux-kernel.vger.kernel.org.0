Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 046D8107C9D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2019 04:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfKWDNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 22:13:49 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:46616 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfKWDNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 22:13:48 -0500
Received: by mail-il1-f193.google.com with SMTP id q1so9086476ile.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 19:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Qdi4xJuJjta2u9BrlQQY9FpGcN9H5nfrgZO9QjBGHhk=;
        b=aqNVL7xVNyuMCGR0fX2PLBMKf2jeELkaON/ndcZFsGUF+jI7+VKi/S1FP3MFvVBPHD
         oTgap/KMM07d9IdlSVF54qH7OxrSRXqxynmzFns5iePgt2kS2gQwaqnqmXSdE+JNncQB
         pZe/9aDETflvjjsHP6xHIQGcJzPqyKXAUgiG2xsQBHt3vxJUIBf2WSUp5epBGDqUbYUJ
         pvm6ccpqLMUz4Nwqnak0d80xlHMrt/S2NdQhEG1OAdFVzBJbam+gJb8LPqmVSFXSr8Dv
         9xvDq45I9HtFq4kT3eebp7TY9GTXGii6CXfcSaR7+g59X28giS/IakHFPFhXB5a3u1OR
         wdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Qdi4xJuJjta2u9BrlQQY9FpGcN9H5nfrgZO9QjBGHhk=;
        b=Sm8CgICdpYr4VRgWvtT3Ev0RQhWYRbU5HZLQvimnz2hptrht/XBa4MfqpTPpkybRWz
         TDds52+LqdjWeKAF0HYpdn4VXVglw+sAD/mo/gaV+37SOVNqlvwp+T1a/2PCL4E3NGcy
         QxvaCTpsM9D4t4uC47eT/F7ZS6COXrj4hBngqfKSc6/5hTNu1vghEwlvfEeg20ThFzAo
         IlnAzxdYxf1ZqsgQ5DoZOzV5i0Zzb+MSrBWI9XXYO94q3Kv19HiPQ7frlbyss1G4PUDd
         tnQmC8T/KAB/gE7eouosPgKUIe4EMZBiVgdQNRNr4UkxjLvJoFQi+PpPBK5/19PiCsg/
         K3nA==
X-Gm-Message-State: APjAAAWz+jktTeIr5tZG9HjE/BSaDXqNtlCuOBUTkpo7REhZXnQCR9n8
        234pTMYQkufk3ZUd94BhwkksQErcNZM=
X-Google-Smtp-Source: APXvYqwLehW6jT9h73wjWDikxsJDU3y94CGY9KVHlLXmuBEF+b78ooLizwVHu0RmqsPNgCJOLq+t1w==
X-Received: by 2002:a05:6638:91:: with SMTP id v17mr12217947jao.97.1574478827962;
        Fri, 22 Nov 2019 19:13:47 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id t6sm3468008ilq.53.2019.11.22.19.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 19:13:47 -0800 (PST)
Date:   Fri, 22 Nov 2019 19:13:45 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Palmer Dabbelt <palmerdabbelt@google.com>
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] riscv: defconfigs: enable debugging options 
In-Reply-To: <mhng-a92b32ea-0365-407c-9569-1ebce2d3b37f@palmerdabbelt.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.9999.1911221912390.490@viisi.sifive.com>
References: <mhng-a92b32ea-0365-407c-9569-1ebce2d3b37f@palmerdabbelt.mtv.corp.google.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019, Palmer Dabbelt wrote:

> Does it make sense to turn on some CONFIG_*_SELFTEST entries as well?  I know
> I've found RISC-V bugs with ATOMIC64_SELFTEST before, but they do take a while
> to run.  I just turned on 
> 
>     diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
>     index 420a0dbef386..90001c3746cd 100644
>     --- a/arch/riscv/configs/defconfig
>     +++ b/arch/riscv/configs/defconfig
>     @@ -100,4 +100,18 @@ CONFIG_9P_FS=y
>      CONFIG_CRYPTO_USER_API_HASH=y
>      CONFIG_CRYPTO_DEV_VIRTIO=y
>      CONFIG_PRINTK_TIME=y
>     +CONFIG_DEBUG_RT_MUTEXES=y
>     +CONFIG_DEBUG_SPINLOCK=y
>     +CONFIG_DEBUG_MUTEXES=y
>     +CONFIG_DEBUG_RWSEMS=y
>     +CONFIG_DEBUG_ATOMIC_SLEEP=y
>     +CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
>     +CONFIG_LOCK_TORTURE_TEST=y
>     +CONFIG_WW_MUTEX_SELFTEST=y
>     +CONFIG_RCU_PERF_TEST=y
>     +CONFIG_RCU_TORTURE_TEST=y
>      # CONFIG_RCU_TRACE is not set
>     +CONFIG_PERCPU_TEST=m
>     +CONFIG_ATOMIC64_SELFTEST=y
>     +CONFIG_TEST_LKM=m
>     +CONFIG_TEST_USER_COPY=m
> 
> as an experiment and OE looks like it's still functional, but it looks like the
> lock torture stuff keeps running and the RCU torture can't run at the same
> time.

Thanks - that's a good idea.

Will take a look to see what tests can be enabled that don't take too much 
time (and don't conflict) and will put together another patch.  If anyone 
has any feedback or suggestions here, they would be welcome.


- Paul
