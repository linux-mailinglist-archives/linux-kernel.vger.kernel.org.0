Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1D88E132
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 01:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfHNXWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 19:22:41 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44421 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbfHNXWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 19:22:40 -0400
Received: by mail-qk1-f193.google.com with SMTP id d79so459941qke.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 16:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+oq/5hVDOEPmfOLGRxP/LWMzZW9hvok8H3hUDypMEVM=;
        b=CeW4A6s9kz9AiVYMqcDI06mk+8c43yhH15wi/FMEFEpQYj8SoEDj5igZ++T61nyJEF
         J7bz0bCMDreJWQK3+sSkHZZElkuyAADVchuhvjtrodJFxPZC3y/SlYmVyZDBspE6JQMx
         QBl4yI3FTbCPsBXJIEej0rRovg1r1eAJISK6dGTgM2wlBFQ9LmobWpzLw4t831OfYRb3
         /nDARP5ragOjl1a4cBnMFDGnjBCOaSWZPg4MgvhREoOAQZk/AElEi+uxFPxrJ0nhHZo2
         mDgtCgwDUIpQdxdHxzFJsk3H7GsWbWO3a1pFsGNrwr6UFL1DCAwb0wYESMq+D/n6TN/i
         qPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+oq/5hVDOEPmfOLGRxP/LWMzZW9hvok8H3hUDypMEVM=;
        b=RCEK2kpcQmicYgQFhHU/nh0THqz7SXn4tc+37nDJ8n2ccrKQ9YnfzPxxGYl0UI2ebT
         ODCSZBbqOOiC1I0QEHgUHjrdOTx0P+dzZOWBzSh14UGr9OpNxW26wjv33GNMmCiIUDD/
         pL57PodCGnF5+tDozkpCx7M+Zko/ZYV2Z6jhv7izueZRbVEEXmyYi3hx8b7+hCNUqc+b
         Rvl4Q58gqiX8+T9p5/AqFXwHNfL3PknLqJuwtK8bVsqdtYk5MJizkx+2TfQU/WwielCe
         EWnEyZ7j4IKUxL+F1jx7XfpjVPh+VFgKtzSIt3asCmX+cQ5RhTx0KTDzhvumi9RoCjoC
         rAjQ==
X-Gm-Message-State: APjAAAXmYgzxrYBP4sp0scvfZdK3WfVJ3yi3BmN7z56/Zj9D6ySEF0Qj
        u9ArQ88UOw1sAt4vspXahsXRlA==
X-Google-Smtp-Source: APXvYqwEds8jlvcwtlYKmEv2OldLu3N2F0isLZlZaympLBGufKl1MnMG6bankd4uSkDCSEjrCOszig==
X-Received: by 2002:a05:620a:15f4:: with SMTP id p20mr1484735qkm.303.1565824959470;
        Wed, 14 Aug 2019 16:22:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id x5sm529189qtr.54.2019.08.14.16.22.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Aug 2019 16:22:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hy2bG-00035M-Gd; Wed, 14 Aug 2019 20:22:38 -0300
Date:   Wed, 14 Aug 2019 20:22:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Michal Hocko <mhocko@suse.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        David Rientjes <rientjes@google.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 1/5] mm: Check if mmu notifier callbacks are allowed to
 fail
Message-ID: <20190814232238.GA11200@ziepe.ca>
References: <20190814202027.18735-1-daniel.vetter@ffwll.ch>
 <20190814202027.18735-2-daniel.vetter@ffwll.ch>
 <20190814151447.e9ab74f4c7ed4297e39321d1@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814151447.e9ab74f4c7ed4297e39321d1@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 03:14:47PM -0700, Andrew Morton wrote:
> On Wed, 14 Aug 2019 22:20:23 +0200 Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> 
> > Just a bit of paranoia, since if we start pushing this deep into
> > callchains it's hard to spot all places where an mmu notifier
> > implementation might fail when it's not allowed to.
> > 
> > Inspired by some confusion we had discussing i915 mmu notifiers and
> > whether we could use the newly-introduced return value to handle some
> > corner cases. Until we realized that these are only for when a task
> > has been killed by the oom reaper.
> > 
> > An alternative approach would be to split the callback into two
> > versions, one with the int return value, and the other with void
> > return value like in older kernels. But that's a lot more churn for
> > fairly little gain I think.
> > 
> > Summary from the m-l discussion on why we want something at warning
> > level: This allows automated tooling in CI to catch bugs without
> > humans having to look at everything. If we just upgrade the existing
> > pr_info to a pr_warn, then we'll have false positives. And as-is, no
> > one will ever spot the problem since it's lost in the massive amounts
> > of overall dmesg noise.
> > 
> > ...
> >
> > +++ b/mm/mmu_notifier.c
> > @@ -179,6 +179,8 @@ int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
> >  				pr_info("%pS callback failed with %d in %sblockable context.\n",
> >  					mn->ops->invalidate_range_start, _ret,
> >  					!mmu_notifier_range_blockable(range) ? "non-" : "");
> > +				WARN_ON(mmu_notifier_range_blockable(range) ||
> > +					ret != -EAGAIN);
> >  				ret = _ret;
> >  			}
> >  		}
> 
> A problem with WARN_ON(a || b) is that if it triggers, we don't know
> whether it was because of a or because of b.  Or both.  So I'd suggest
> 
> 	WARN_ON(a);
> 	WARN_ON(b);
> 

Well, we did just make a pr_info right above with the value of
blockable, that seems enough to tell the cases apart?

But you are generally right, the full logic:

    if (_ret) {
      if (WARN_ON(mmu_notifier_range_blockable(range)))
            continue;
      WARN_ON(_ret != -EAGAIN);
      ret = -EAGAIN;
      break;
    }

would force correct API contract up the call chain once we detect a
broken driver..

But at some point it does feel like a bit much debugging logic to have
in a production code path, as this should never happen and is just to
discourage wrong driver behaviors during driver development.

If we like this version then:

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Also - I have a bunch of other patches to mmu notifiers for hmm.git,
so when everyone agrees I can grab this to avoid conflicts.

Thanks,
Jason
