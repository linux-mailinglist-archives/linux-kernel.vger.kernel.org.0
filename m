Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E99F88F25B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 19:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732432AbfHORf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 13:35:59 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45952 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfHORf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:35:59 -0400
Received: by mail-qk1-f193.google.com with SMTP id m2so2433719qki.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3I0/JtshV0JYc9v5er9Nyt2RkR0gXgFBErZRF2qt5m0=;
        b=TEE2VTSv3tx1ZS4nODo3IOEMW+jHQ+D+qi1QIiUZkTdg3tRdtrDS1Yi2Ge0OnwlQjy
         9uKji7u3GHzFOTQr/5OvgUSnhcrBXLslyqF2JAqkQ3GgIk6PLNtVym1yiMIGLCNKTOL1
         iQXtVYo5wmF7eZRIICfA54N3DHqUUMZ+9l5FqFEVzN+v0bu03kcn014mCrD0u20coYbC
         eOTlerFgdQ1Hl3pSxKkr16MDtNGjVedbFoafrOTqsODAG2Dy9iAybdLDz91AheE0jhP3
         csOgvcEu4MCFZjOLKT0QXJJsbsK8STjBB7eCxSDOzDzFeZfx8mVvw4ErfTv55+OVi7LQ
         HPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3I0/JtshV0JYc9v5er9Nyt2RkR0gXgFBErZRF2qt5m0=;
        b=tTbEERheDjAZ11g3djUUAdeq1scrEVYHnRTkMAXPzZVrUJa734W4YPUBJC92Ae3hOE
         ErgiEjdNjwtk99tAxZcogcMuIzIHG6J8LqEpGzDqWeaQtDoLMs33UaX4BdCAlXmE2GHC
         diDhYz/3voZJSOTJRuOMFueLg8XK8yKW+M8EK8dttOQZI0T+kNgsiPKUG3XDlLayDxU9
         qjRIDr2gXTQ5RSUakTkcm8MYS2Vpl408DO6pYajVvsbpoLZJgRB1n0/95+30ObmlLVUP
         BUVoEO0fgerbJ/Pawgh8zWbI7VXdhewiksx725/6g9DCDa27K1bPXPxA+/JVfT3rvBK5
         kuPQ==
X-Gm-Message-State: APjAAAXGobVnjSCqMeYjSaoBaDCMMcSN8vtpF7iQST0I83W6zYiL1jZV
        liKpFtmEqIYd02NWNWl9Y5QuyQ==
X-Google-Smtp-Source: APXvYqxCT6Z6k6qpPIV0VSEi+Ea/Upm35vjesy1M0E1G5PDQA92PUo48Y+Ame9Jik9oEIwW+jp3Waw==
X-Received: by 2002:ae9:f707:: with SMTP id s7mr5159848qkg.0.1565890558329;
        Thu, 15 Aug 2019 10:35:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id e3sm1552304qkg.91.2019.08.15.10.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Aug 2019 10:35:58 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hyJfJ-0006yS-GO; Thu, 15 Aug 2019 14:35:57 -0300
Date:   Thu, 15 Aug 2019 14:35:57 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 2/5] kernel.h: Add non_block_start/end()
Message-ID: <20190815173557.GN21596@ziepe.ca>
References: <20190814202027.18735-1-daniel.vetter@ffwll.ch>
 <20190814202027.18735-3-daniel.vetter@ffwll.ch>
 <20190814134558.fe659b1a9a169c0150c3e57c@linux-foundation.org>
 <20190815084429.GE9477@dhcp22.suse.cz>
 <20190815130415.GD21596@ziepe.ca>
 <CAKMK7uE9zdmBuvxa788ONYky=46GN=5Up34mKDmsJMkir4x7MQ@mail.gmail.com>
 <20190815143759.GG21596@ziepe.ca>
 <CAKMK7uEJQ6mPQaOWbT_6M+55T-dCVbsOxFnMC6KzLAMQNa-RGg@mail.gmail.com>
 <20190815151028.GJ21596@ziepe.ca>
 <CAKMK7uG33FFCGJrDV4-FHT2FWi+Z5SnQ7hoyBQd4hignzm1C-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uG33FFCGJrDV4-FHT2FWi+Z5SnQ7hoyBQd4hignzm1C-A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 06:25:16PM +0200, Daniel Vetter wrote:

> I'm not really well versed in the details of our userptr, but both
> amdgpu and i915 wait for the gpu to complete from
> invalidate_range_start. Jerome has at least looked a lot at the amdgpu
> one, so maybe he can explain what exactly it is we're doing ...

amdgpu is (wrongly) using hmm for something, I can't really tell what
it is trying to do. The calls to dma_fence under the
invalidate_range_start do not give me a good feeling.

However, i915 shows all the signs of trying to follow the registration
cache model, it even has a nice comment in
i915_gem_userptr_get_pages() explaining that the races it has don't
matter because it is a user space bug to change the VA mapping in the
first place. That just screams registration cache to me.

So it is fine to run HW that way, but if you do, there is no reason to
fence inside the invalidate_range end. Just orphan the DMA buffer and
clean it up & release the page pins when all DMA buffer refs go to
zero. The next access to that VA should get a new DMA buffer with the
right mapping.

In other words the invalidation should be very simple without
complicated locking, or wait_event's. Look at hfi1 for example.

Jason
