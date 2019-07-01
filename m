Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECBB51D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 23:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfFXVan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 17:30:43 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41504 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfFXVan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:30:43 -0400
Received: by mail-qt1-f194.google.com with SMTP id d17so16113099qtj.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 14:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IdPYB32R1Ky5udWdlDMBAJnCn+Bo2KtPbU6CqfZba4M=;
        b=YtNTjUwedsLsfc7DrryL4Gz7SHsyOwurki3ZAuLGi5jv3uoV1XDzNuVshE2rgNJNk7
         7B4h1/7Ftgrcz4FUW9IG5jLOzQmp+3MiTHbK1xzrjDwrPmaEvaaCsHhik+IX27Rxptfy
         hCbmTnibUCjBBtgsebBw1Yu7PyaULyPUdqE0uikoDJe1LStMwO3JfI7lG38VrHZ8Vlsf
         C8N0Y39Vin7o/umAsyJo603Fl/rEM30epk4k/3BDRXauVyd49VRXp2mTLfwCaSwo+ryL
         CCfu6apCDfSUOfIcf6TMIT6ubmfzCP3IGRY2YjyczjnEeDrzIjdliMcKaAMpp/KNc8aa
         IOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IdPYB32R1Ky5udWdlDMBAJnCn+Bo2KtPbU6CqfZba4M=;
        b=reCpU1xQ64q8FvSYU5YCkkqZy4jgrtASftpKf4PTL9aAH6aLY9ANPLhFQtMnTKaBVf
         mTkSevnAiBj4xOCm5Zit89IgOw3Hi8UFn8iHaj+RQSfUqZIuZtK8WK03QiPa7oadLSed
         emcYaNO5y3NHQ2zLaMd54058he9zLvgAjSfcyc8gOsFX2W+peIPbCFLEpvFO0GBBKZzr
         V2rxa66nTQL0Izja3PrPnpnAc18mJAIJiZekVzXWbz5zPmXP5tR61HJLc62dEHtOCypV
         VSax57eTNOlYwoI8QclvrztHPgnGhzCdm1Ifxe7WoodPI7aMSl4bkgdH4RCY+h5m6dQ1
         O8vg==
X-Gm-Message-State: APjAAAXTey0CNieyLIUYHePlwxX2mTCmu8I7Ii59ZxY+3SheX1dh7Ie5
        A+CNRL5EO9duYVktL6qCBeP6Lw==
X-Google-Smtp-Source: APXvYqyS6XZTOn9QKS3QHPK7KdIUEBDmjNO9cZeXeZ9E/jUJ7+RGxN37MlErmlyPXHlBJErk3AADkg==
X-Received: by 2002:ac8:1946:: with SMTP id g6mr44679856qtk.225.1561411841994;
        Mon, 24 Jun 2019 14:30:41 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id s23sm7340370qtk.31.2019.06.24.14.30.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 14:30:41 -0700 (PDT)
Message-ID: <1561411839.5154.60.camel@lca.pw>
Subject: Re: LTP hugemmap05 test case failure on arm64 with linux-next
 (next-20190613)
From:   Qian Cai <cai@lca.pw>
To:     Will Deacon <will@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mike Kravetz <mike.kravetz@oracle.com>
Date:   Mon, 24 Jun 2019 17:30:39 -0400
In-Reply-To: <1561381129.5154.55.camel@lca.pw>
References: <1560461641.5154.19.camel@lca.pw>
         <20190614102017.GC10659@fuggles.cambridge.arm.com>
         <1560514539.5154.20.camel@lca.pw>
         <054b6532-a867-ec7c-0a72-6a58d4b2723e@arm.com>
         <EC704BC3-62FF-4DCE-8127-40279ED50D65@lca.pw>
         <20190624093507.6m2quduiacuot3ne@willie-the-truck>
         <1561381129.5154.55.camel@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So the problem is that ipcget_public() has held the semaphore "ids->rwsem" for
too long seems unnecessarily and then goes to sleep sometimes due to direct
reclaim (other times LTP hugemmap05 [1] has hugetlb_file_setup() returns
-ENOMEM),

[  788.765739][ T1315] INFO: task hugemmap05:5001 can't die for more than 122
seconds.
[  788.773512][ T1315] hugemmap05      R  running task    25600  5001      1
0x0000000d
[  788.781348][ T1315] Call trace:
[  788.784536][ T1315]  __switch_to+0x2e0/0x37c
[  788.788848][ T1315]  try_to_free_pages+0x614/0x934
[  788.793679][ T1315]  __alloc_pages_nodemask+0xe88/0x1d60
[  788.799030][ T1315]  alloc_fresh_huge_page+0x16c/0x588
[  788.804206][ T1315]  alloc_surplus_huge_page+0x9c/0x278
[  788.809468][ T1315]  hugetlb_acct_memory+0x114/0x5c4
[  788.814469][ T1315]  hugetlb_reserve_pages+0x170/0x2b0
[  788.819662][ T1315]  hugetlb_file_setup+0x26c/0x3a8
[  788.824600][ T1315]  newseg+0x220/0x63c
[  788.828490][ T1315]  ipcget+0x570/0x674
[  788.832377][ T1315]  ksys_shmget+0x90/0xc4
[  788.836525][ T1315]  __arm64_sys_shmget+0x54/0x88
[  788.841282][ T1315]  el0_svc_handler+0x19c/0x26c
[  788.845952][ T1315]  el0_svc+0x8/0xc

and then all other processes are waiting on the semaphore causes lock
contentions,

[  788.849583][ T1315] INFO: task hugemmap05:5027 blocked for more than 122
seconds.
[  788.857119][ T1315]       Tainted: G        W         5.2.0-rc6-next-20190624 
#2
[  788.864566][ T1315] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  788.873139][ T1315] hugemmap05      D26960  5027   5026 0x00000000
[  788.879395][ T1315] Call trace:
[  788.882576][ T1315]  __switch_to+0x2e0/0x37c
[  788.886901][ T1315]  __schedule+0xb74/0xf0c
[  788.891136][ T1315]  schedule+0x60/0x168
[  788.895097][ T1315]  rwsem_down_write_slowpath+0x5a0/0x8c8
[  788.900653][ T1315]  down_write+0xc0/0xc4
[  788.904715][ T1315]  ipcget+0x74/0x674
[  788.908516][ T1315]  ksys_shmget+0x90/0xc4
[  788.912664][ T1315]  __arm64_sys_shmget+0x54/0x88
[  788.917420][ T1315]  el0_svc_handler+0x19c/0x26c
[  788.922088][ T1315]  el0_svc+0x8/0xc

Ideally, it seems only ipc_findkey() and newseg() in this path needs to hold the
semaphore to protect concurrency access, so it could just be converted to a
spinlock instead.

[1] ./hugemmap05 -s -m

https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/huget
lb/hugemmap/hugemmap05.c
