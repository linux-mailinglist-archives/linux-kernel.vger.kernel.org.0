Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1FA7172F45
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 04:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbgB1DYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 22:24:05 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:50713 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730593AbgB1DYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 22:24:05 -0500
Received: by mail-pj1-f65.google.com with SMTP id r67so680337pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 19:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a9nEUllzxHgQivoEnVes++ZQ5+L/PmGLNBg3PycDmbs=;
        b=ouyX+glbrllw53UHl2jQIX1XPWV61crrmaMjGaEQg/n6nR4f0NrTWodvis3DglmxtH
         5lz6Pyh7FA7jHwSSyazBf9ycVDSkX/nGDPZA+Pv4G+LoJ2ocDwPXHZ2Z3vE1a9osdHqI
         +41KD41QrsR8MZEOe1qOs9Bjsks0lgMlgs8D1nexF9gF0/iwaIKCJ1ZVlk4Z2uD8cnBy
         AYZcwz7wpveCvAwNC1RHJl6HdvLZlmXE8FpOo9Rn0C5rvRkOgO+ESOoPabI1mLxBqkRZ
         qYdgS6zVRjDYwfxEbyh74RwD84eskBHp7D7Z92sE2qdOIFlCgYJ99QaxvxVu2vmclZvz
         ACtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a9nEUllzxHgQivoEnVes++ZQ5+L/PmGLNBg3PycDmbs=;
        b=ljnXlylBXjuQZS2CAZ0W05AoEcU9vg824MLLI9p7TAQgu87RYtr+tgj0ufuAR5BALl
         kCZ8fUHLJI3dScYub7VWpoU44z3mGt31rmPcK+SRjzwPpzYOc5DgdTHVGr7KwzODkV+G
         +dqaGZgoYDiNKRmVz9GdMzRSQQvg25UW7Ata3OjPqrBr8/G6/nYy0lQ9lKKjzjPQdg9A
         je4Gev+yPB2Bc9QCDrH8cmFXTi9lhgvzCys2c6J2p2HeiGAcUC3XKQurCZaTcng6wXor
         4vMUREA3Etswl21o+oa1O4EGzwdbe1dtaNsSQ6G4IM61mzt6z9Y4Y7z0hLmr7wXHZIpg
         N+JQ==
X-Gm-Message-State: APjAAAVnQg673f9nUWsgkCQesuwS66Nn4eifUC9Od1oAgSuh5mi+QTJ7
        AJ9wUn+tORczKIfLRGgceNA=
X-Google-Smtp-Source: APXvYqzWe0u/8sWu+JpDmVlwry1OCubKLm5mj/oiTguGpNWrgCRXvx/h4xfwBg/RgsA5MqRTznd6cQ==
X-Received: by 2002:a17:90a:a88d:: with SMTP id h13mr2376100pjq.48.1582860244168;
        Thu, 27 Feb 2020 19:24:04 -0800 (PST)
Received: from ziqianlu-desktop.localdomain ([47.89.83.64])
        by smtp.gmail.com with ESMTPSA id k63sm123797pjb.10.2020.02.27.19.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 19:24:03 -0800 (PST)
Date:   Fri, 28 Feb 2020 11:23:58 +0800
From:   Aaron Lu <aaron.lwe@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, js1304@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v2 0/9] workingset protection/detection on the anonymous
 LRU list
Message-ID: <20200228032358.GB634650@ziqianlu-desktop.localdomain>
References: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
 <20200226193942.30049da9c090b466bdc5ec23@linux-foundation.org>
 <20200227134806.GC39625@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227134806.GC39625@cmpxchg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 08:48:06AM -0500, Johannes Weiner wrote:
> On Wed, Feb 26, 2020 at 07:39:42PM -0800, Andrew Morton wrote:
> > It sounds like the above simple aging changes provide most of the
> > improvement, and that the workingset changes are less beneficial and a
> > bit more risky/speculative?
> > 
> > If so, would it be best for us to concentrate on the aging changes
> > first, let that settle in and spread out and then turn attention to the
> > workingset changes?
> 
> Those two patches work well for some workloads (like the benchmark),
> but not for others. The full patchset makes sure both types work well.
> 
> Specifically, the existing aging strategy for anon assumes that most
> anon pages allocated are hot. That's why they all start active and we
> then do second-chance with the small inactive LRU to filter out the
> few cold ones to swap out. This is true for many common workloads.
> 
> The benchmark creates a larger-than-memory set of anon pages with a
> flat access profile - to the VM a flood of one-off pages. Joonsoo's

test: swap-w-rand-mt, which is a multi thread swap write intensive
workload so there will be swap out and swap ins.

> first two patches allow the VM to usher those pages in and out of

Weird part is, the robot says the performance gain comes from the 1st
patch only, which adjust the ratio, not including the 2nd patch which
makes anon page starting from inactive list.

I find the performance gain hard to explain...

> memory very quickly, which explains the throughput boost. But it comes
> at the cost of reducing space available to hot anon pages, which will
> regress others.
> 
