Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F60B9982B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 17:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732725AbfHVP3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 11:29:38 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34558 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731590AbfHVP3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:29:38 -0400
Received: by mail-ed1-f65.google.com with SMTP id s49so8542673edb.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 08:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NShzkeO57gNIcWY3UBsv9gWvkJ1EYfgAU04oEVEy9/s=;
        b=UpOFvSYz72qKeDSOGQRUU63EGi1U21Ik9Iqh/03c6eP/ExSyaN4GgMUxOS8VmvJUKs
         fo8hnGb9qOSjLpETa8Ka09nOa3YjYuk4Dbvw0eix0/R4AdGXRBP/rZROj1Ax0sufL0VR
         hEcjlETyL0ko7tvjax3qQZrgw19IKGh1tslqzSWY5C2e7kve3DaD53ccZeyBMVwS+7Ng
         FNcuq0q75WvzhMzqXREpbEwHALCxd9Cqj22Y7SEWqqjxiyEuYtclYfdNxQWCu9EEFIf7
         yqByc/b45MRoWloWXzTl/h7yXHYAkFD2W0ryl10iqFtaE4vEJ5AUmYv80A9z9wir/IOg
         GAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NShzkeO57gNIcWY3UBsv9gWvkJ1EYfgAU04oEVEy9/s=;
        b=hKoKAi4AWTE1EaaecYqgq/VgCokvwH3txO7baXd4vXl+ACDKkoRCbEBvB5vHFj1DY4
         DovmaDJLu9ELqrr8vXCVDsXvE5Wu479SyGvathUZX6wl0DBy4CFF1mO/KY1wwRsjGTVO
         /Sfkv9c1L42Qb6xZYHrdGjo3fCalX1jJv34YRbb4XSbb31FucdYtDOofEhZBzWrWMIeP
         n9iokzXguuN0Qflhgnc5fmBrB948rvTyRUgiML8IMRPQIaYuaSNVvqHaiY+fvvuRG199
         gDyyeuJlv1ggtYHnytTfZJd10pUyNxtOAeFP+cNbOD6AqbaQ3Qf1E7ysLk1a0NihFS6h
         xXqA==
X-Gm-Message-State: APjAAAWkpVtZF38ASO4lkZ/oqm05lxp2Wvg064H+gzA9Q9URUx/YqAd4
        iBrMdgWARrzoqDvSImeHrSPKEw==
X-Google-Smtp-Source: APXvYqw2vW+HEhYm8/UtfLOz0JmneNpCs95sraOI9vYvuULNaq674xTnSf8NYAKYSeprMFcnDgqeVQ==
X-Received: by 2002:a50:9eab:: with SMTP id a40mr42932247edf.20.1566487776294;
        Thu, 22 Aug 2019 08:29:36 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id k15sm3470816ejk.46.2019.08.22.08.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 08:29:35 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 57814100853; Thu, 22 Aug 2019 18:29:34 +0300 (+03)
Date:   Thu, 22 Aug 2019 18:29:34 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Michal Hocko <mhocko@kernel.org>, kirill.shutemov@linux.intel.com,
        Yang Shi <yang.shi@linux.alibaba.com>, hannes@cmpxchg.org,
        rientjes@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH -mm] mm: account deferred split THPs into MemAvailable
Message-ID: <20190822152934.w6ztolutdix6kbvc@box>
References: <1566410125-66011-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190822080434.GF12785@dhcp22.suse.cz>
 <ee048bbf-3563-d695-ea58-5f1504aee35c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee048bbf-3563-d695-ea58-5f1504aee35c@suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 02:56:56PM +0200, Vlastimil Babka wrote:
> On 8/22/19 10:04 AM, Michal Hocko wrote:
> > On Thu 22-08-19 01:55:25, Yang Shi wrote:
> >> Available memory is one of the most important metrics for memory
> >> pressure.
> > 
> > I would disagree with this statement. It is a rough estimate that tells
> > how much memory you can allocate before going into a more expensive
> > reclaim (mostly swapping). Allocating that amount still might result in
> > direct reclaim induced stalls. I do realize that this is simple metric
> > that is attractive to use and works in many cases though.
> > 
> >> Currently, the deferred split THPs are not accounted into
> >> available memory, but they are reclaimable actually, like reclaimable
> >> slabs.
> >> 
> >> And, they seems very common with the common workloads when THP is
> >> enabled.  A simple run with MariaDB test of mmtest with THP enabled as
> >> always shows it could generate over fifteen thousand deferred split THPs
> >> (accumulated around 30G in one hour run, 75% of 40G memory for my VM).
> >> It looks worth accounting in MemAvailable.
> > 
> > OK, this makes sense. But your above numbers are really worrying.
> > Accumulating such a large amount of pages that are likely not going to
> > be used is really bad. They are essentially blocking any higher order
> > allocations and also push the system towards more memory pressure.
> > 
> > IIUC deferred splitting is mostly a workaround for nasty locking issues
> > during splitting, right? This is not really an optimization to cache
> > THPs for reuse or something like that. What is the reason this is not
> > done from a worker context? At least THPs which would be freed
> > completely sound like a good candidate for kworker tear down, no?
> 
> Agreed that it's a good question. For Kirill :) Maybe with kworker approach we
> also wouldn't need the cgroup awareness?

I don't remember a particular locking issue, but I cannot say there's
none :P

It's artifact from decoupling PMD split from compound page split: the same
page can be mapped multiple times with combination of PMDs and PTEs. Split
of one PMD doesn't need to trigger split of all PMDs and underlying
compound page.

Other consideration is the fact that page split can fail and we need to
have fallback for this case.

Also in most cases THP split would be just waste of time if we would do
them at the spot. If you don't have memory pressure it's better to wait
until process termination: less pages on LRU is still beneficial.

Main source of partly mapped THPs comes from exit path. When PMD mapping
of THP got split across multiple VMAs (for instance due to mprotect()),
in exit path we unmap PTEs belonging to one VMA just before unmapping the
rest of the page. It would be total waste of time to split the page in
this scenario.

The whole deferred split thing still looks as a reasonable compromise
to me.

We may have some kind of watermark and try to keep the number of deferred
split THP under it. But it comes with own set of problems: what if all
these pages are pinned for really long time and effectively not available
for split.

-- 
 Kirill A. Shutemov
