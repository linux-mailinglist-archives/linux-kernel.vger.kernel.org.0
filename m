Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF1A5C975
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 08:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfGBGmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 02:42:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46457 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfGBGmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 02:42:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id 81so7741370pfy.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 23:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=87XbSGKa5QHQCeUtgWcK1lHAubdPYIITDtUYO85ViuI=;
        b=rqVQAYL03KWvM3yxtAzULV9ROj+5qv4RNm51K8dCwptmKyKYqkznX13vIUUrtbtd7X
         6i10foW4JDXh3XDnOmEpSSpVWxS7vQI3opSg3vJMYbD2t2aBKXwDpM843lvsWW3sYDOR
         4PZJCddPZUysCuNNRugCHitmMheStFtavdtokHk0u1nOMaXV0/75dyg1QJxscd0UsGQA
         36CzpCLMA7v1ZPa2LFdKZa0GvuOtoSHAsnNMLCbWGaXNCGhtqm7qdZ2MPqHFDV4CqS6S
         r06dYUammP+ccOXWNgAzrJZzTRv5OEoJtBXV3tekmbBI5tBjmC31rih/CQxkQ79CmhWj
         75QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=87XbSGKa5QHQCeUtgWcK1lHAubdPYIITDtUYO85ViuI=;
        b=HOC1LBjC6CNowFvzVni2iHCgE3UbY/QpELaRuVfTFG1Y31875EtAKn2C2khFUh0Lqw
         0oK/c/4uQmRrXStZLlFAnj9fU1bqB3ubmgEtedeMcATPBGsVCTI2AYdwA0fF3dtEqfkL
         ngCmxZ3fohXKw9nsFZmNqRLhVH48FUADn00lPYWzS6qc6O/3d4PW2Bhn0uLUxQ0PIYqR
         8BthBCFxaEihBHQwy8n3aU1fUdOmS6FQAkqI+GWNVc21JkPl8GyU1RkGG7rgmuXTcj5m
         bz9zgGAJNpGw+gzHZY0p/GvXeoRpdJq7puABxd+JIuKI0+KqVYdhl2iOxjST4W0kWOmr
         vAbA==
X-Gm-Message-State: APjAAAVvkRwt+tFOik22jDpDFFt+l224wYFamgANBsGVMa4WSPRI9Gzd
        G8zKvkiWahdEg4IgTbWgjn4=
X-Google-Smtp-Source: APXvYqx5opPoUVZnjJcNKkQE1Fn7/SKTQBxHrlZeRIrzSEiR5Nhjg0pGDvNnHaiwpg4kRbNXgzTrIg==
X-Received: by 2002:a17:90a:bc0c:: with SMTP id w12mr3530135pjr.111.1562049761805;
        Mon, 01 Jul 2019 23:42:41 -0700 (PDT)
Received: from rashmica.ozlabs.ibm.com ([122.99.82.10])
        by smtp.googlemail.com with ESMTPSA id w65sm12975112pfw.168.2019.07.01.23.42.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 23:42:41 -0700 (PDT)
Message-ID: <9143f64391d11aa0f1988e78be9de7ff56e4b30b.camel@gmail.com>
Subject: Re: [PATCH v2 0/5] Allocate memmap from hotadded memory
From:   Rashmica Gupta <rashmica.g@gmail.com>
To:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, pasha.tatashin@soleen.com,
        Jonathan.Cameron@huawei.com, anshuman.khandual@arm.com,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Tue, 02 Jul 2019 16:42:34 +1000
In-Reply-To: <887b902e-063d-a857-d472-f6f69d954378@redhat.com>
References: <20190625075227.15193-1-osalvador@suse.de>
         <2ebfbd36-11bd-9576-e373-2964c458185b@redhat.com>
         <20190626080249.GA30863@linux>
         <2750c11a-524d-b248-060c-49e6b3eb8975@redhat.com>
         <20190626081516.GC30863@linux>
         <887b902e-063d-a857-d472-f6f69d954378@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Sorry for the late reply.

On Wed, 2019-06-26 at 10:28 +0200, David Hildenbrand wrote:
> On 26.06.19 10:15, Oscar Salvador wrote:
> > On Wed, Jun 26, 2019 at 10:11:06AM +0200, David Hildenbrand wrote:
> > > Back then, I already mentioned that we might have some users that
> > > remove_memory() they never added in a granularity it wasn't
> > > added. My
> > > concerns back then were never fully sorted out.
> > > 
> > > arch/powerpc/platforms/powernv/memtrace.c
> > > 
> > > - Will remove memory in memory block size chunks it never added
> > > - What if that memory resides on a DIMM added via
> > > MHP_MEMMAP_DEVICE?
> > > 
> > > Will it at least bail out? Or simply break?
> > > 
> > > IOW: I am not yet 100% convinced that MHP_MEMMAP_DEVICE is save
> > > to be
> > > introduced.
> > 
> > Uhm, I will take a closer look and see if I can clear your
> > concerns.
> > TBH, I did not try to use arch/powerpc/platforms/powernv/memtrace.c
> > yet.
> > 
> > I will get back to you once I tried it out.
> > 
> 
> BTW, I consider the code in arch/powerpc/platforms/powernv/memtrace.c
> very ugly and dangerous.

Yes it would be nice to clean this up.

> We should never allow to manually
> offline/online pages / hack into memory block states.
> 
> What I would want to see here is rather:
> 
> 1. User space offlines the blocks to be used
> 2. memtrace installs a hotplug notifier and hinders the blocks it
> wants
> to use from getting onlined.
> 3. memory is not added/removed/onlined/offlined in memtrace code.
>

I remember looking into doing it a similar way. I can't recall the
details but my issue was probably 'how does userspace indicate to
the kernel that this memory being offlined should be removed'?

I don't know the mm code nor how the notifiers work very well so I
can't quite see how the above would work. I'm assuming memtrace would
register a hotplug notifier and when memory is offlined from userspace,
the callback func in memtrace would be called if the priority was high
enough? But how do we know that the memory being offlined is intended
for usto touch? Is there a way to offline memory from userspace not
using sysfs or have I missed something in the sysfs interface?

On a second read, perhaps you are assuming that memtrace is used after
adding new memory at runtime? If so, that is not the case. If not, then
would you be able to clarify what I'm not seeing?

Thanks.

> CCing the DEVs.
> 

