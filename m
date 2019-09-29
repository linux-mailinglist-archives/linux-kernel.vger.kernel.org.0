Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60339C137E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2019 07:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfI2FZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Sep 2019 01:25:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726838AbfI2FZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 01:25:51 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 884C385538
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 05:25:50 +0000 (UTC)
Received: by mail-pf1-f199.google.com with SMTP id s137so5129281pfs.18
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 22:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U2Fqhrhhc3c5hT+09GB0Tz123AzZHSVYeE1k74C2N8Q=;
        b=c5DIQ/gP0+ZlLYu8cl1CSA8mYrhBNJhuV53/OaslCM2G84KvTW+TAWS4AMti3ijHwy
         9yt8cJLTNaqBddcFeuk+K69kRXF7FLI9BMITHnElxpUb3D9ISzvMMNb+WleqrckJ7JKu
         g0q/Cnux3XoDhJDwmRc+8CaetgLRmajIeuCldfVo7kX/LcvvSNXq6m5I+JO8WZjnvWS1
         Tp3bNKZyB4WAmvTNJjpW1pH4lk8lF8JNlOl0jo17USFnvdDV9d9nVhIhw6SUjsUlE7d0
         sJhZO4aTjMESKGS4z6gthZhQCx1w65Pg08GlZTMSnFJ0+Mse5MbutaB9JsbNyw0epYxq
         cFeA==
X-Gm-Message-State: APjAAAXAZt0fE/PJKYHNYplm6M3stRH2X+WP1y6l6rEBRaJdGBDf0uva
        OQ1GRCy170w6jqlMsOSv8sq0ePiSCA4zw/DK05PQDEZGX6GqhUZEDt/w/MtYiHEN39Ol6q5GiJX
        jbZDUhcOCnRXZj+rdCRsUQ6q+
X-Received: by 2002:a65:6111:: with SMTP id z17mr17809434pgu.415.1569734749962;
        Sat, 28 Sep 2019 22:25:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxSwESBBqWbUZ8IYCB+ndAeHAFp/knXskQIwKbF6UdAPwArDrPxhK0qMIyDkQyFVFJVbYrxHA==
X-Received: by 2002:a65:6111:: with SMTP id z17mr17809411pgu.415.1569734749539;
        Sat, 28 Sep 2019 22:25:49 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y6sm7985721pfp.82.2019.09.28.22.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2019 22:25:47 -0700 (PDT)
Date:   Sun, 29 Sep 2019 13:25:32 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        kevin.tian@intel.com, Yi Sun <yi.y.sun@linux.intel.com>,
        ashok.raj@intel.com, kvm@vger.kernel.org, sanjay.k.kumar@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        yi.y.sun@intel.com
Subject: Re: [RFC PATCH 2/4] iommu/vt-d: Add first level page table interfaces
Message-ID: <20190929052532.GA12953@xz-x1>
References: <20190923122454.9888-1-baolu.lu@linux.intel.com>
 <20190923122454.9888-3-baolu.lu@linux.intel.com>
 <20190925052157.GL28074@xz-x1>
 <c9792e0b-bf42-1dbb-f060-0b1a43125f47@linux.intel.com>
 <20190926034905.GW28074@xz-x1>
 <52778812-129b-0fa7-985d-5814e9d84047@linux.intel.com>
 <20190927053449.GA9412@xz-x1>
 <66823e27-aa33-5968-b5fd-e5221fb1fffe@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <66823e27-aa33-5968-b5fd-e5221fb1fffe@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2019 at 04:23:16PM +0800, Lu Baolu wrote:
> Hi Peter,
> 
> On 9/27/19 1:34 PM, Peter Xu wrote:
> > Hi, Baolu,
> > 
> > On Fri, Sep 27, 2019 at 10:27:24AM +0800, Lu Baolu wrote:
> > > > > > > +	spin_lock(&(domain)->page_table_lock);				\
> > > > > > 
> > > > > > Is this intended to lock here instead of taking the lock during the
> > > > > > whole page table walk?  Is it safe?
> > > > > > 
> > > > > > Taking the example where nm==PTE: when we reach here how do we
> > > > > > guarantee that the PMD page that has this PTE is still valid?
> > > > > 
> > > > > We will always keep the non-leaf pages in the table,
> > > > 
> > > > I see.  Though, could I ask why?  It seems to me that the existing 2nd
> > > > level page table does not keep these when unmap, and it's not even use
> > > > locking at all by leveraging cmpxchg()?
> > > 
> > > I still need some time to understand how cmpxchg() solves the race issue
> > > when reclaims pages. For example.
> > > 
> > > Thread A				Thread B
> > > -A1: check all PTE's empty		-B1: up-level PDE valid
> > > -A2: clear the up-level PDE
> > > -A3: reclaim the page			-B2: populate the PTEs
> > > 
> > > Both (A1,A2) and (B1,B2) should be atomic. Otherwise, race could happen.
> > 
> > I'm not sure of this, but IMHO it is similarly because we need to
> > allocate the iova ranges from iova allocator first, so thread A (who's
> > going to unmap pages) and thread B (who's going to map new pages)
> > should never have collapsed regions if happening concurrently.  I'm
> 
> Although they don't collapse, they might share a same pmd entry. If A
> cleared the pmd entry and B goes ahead with populating the pte's. It
> will crash.

My understanding is that if A was not owning all the pages on that PMD
entry then it will never free the page that was backing that PMD
entry.  Please refer to the code in dma_pte_clear_level() where it
has:

        /* If range covers entire pagetable, free it */
        if (start_pfn <= level_pfn &&
                last_pfn >= level_pfn + level_size(level) - 1) {
                ...
        } else {
                ...
        }

Note that when going into the else block, the PMD won't be freed but
only the PTEs that upon the PMD will be cleared.

In the case you mentioned above, IMHO it should go into that else
block.  Say, thread A must not contain the whole range of that PMD
otherwise thread B won't get allocated with pages within that range
covered by the same PMD.

Thanks,

-- 
Peter Xu
