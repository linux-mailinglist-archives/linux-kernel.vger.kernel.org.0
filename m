Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00E7C108D28
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 12:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfKYLrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 06:47:12 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42187 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbfKYLrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 06:47:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id a15so17621489wrf.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 03:47:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S+EEhkHcLVWZKwT8zqSpAmLXMvzyNuJC5U+oB96yAfY=;
        b=sxevm++HvCr1/v6JRNS39UApOmnsBgTHq3bQwMLBSRMrQNGJjNuHEIkgw4q+eQlorq
         p9qWLeF7Epmm2hY3pGOQojTZ4MvOx6U3Ns5spHyy+m+za+yfYBec8WH19E3EUg7nX8wq
         dgchBjgIotRPxsi/TN4zcbCNCtJ7E2+FiCQ2yHKU4zyzceiaqT6NjibXg2DFMr2hB38J
         Cu/h9P0Y90Zwd2KZaNEyVcAR7WhUlRDXRas83Waj/l+agTl7bpJKC+akNcXQMFEunsx9
         mgnbfHLe2oa2EdhT429kY43Grsh5BmF5rWo7XCnWNi69te8M4tJZmpaB5SbB9KvwwH6d
         a0pA==
X-Gm-Message-State: APjAAAXxDMSDKA3/fAHD9dYdvobUsRHuHQBT13oPCuSInKODe8xH2c83
        y1m42abXBPRHmOdP4f0HMBE=
X-Google-Smtp-Source: APXvYqyEESAigdr6gGonQM35wfYwuKMSmcENhp8ksP9iuV8ybf2y2gcCZTJbQ0ke0h5FD6Nxi+Optw==
X-Received: by 2002:a5d:538d:: with SMTP id d13mr32994290wrv.304.1574682429742;
        Mon, 25 Nov 2019 03:47:09 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id 4sm8426509wmd.33.2019.11.25.03.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 03:47:09 -0800 (PST)
Date:   Mon, 25 Nov 2019 12:47:08 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [patch for-5.3 0/4] revert immediate fallback to remote hugepages
Message-ID: <20191125114708.GI31714@dhcp22.suse.cz>
References: <08a3f4dd-c3ce-0009-86c5-9ee51aba8557@suse.cz>
 <20191029151549.GO31513@dhcp22.suse.cz>
 <20191029143351.95f781f09a9fbf254163d728@linux-foundation.org>
 <alpine.DEB.2.21.1910291623050.9914@chino.kir.corp.google.com>
 <20191105130253.GO22672@dhcp22.suse.cz>
 <alpine.DEB.2.21.1911051659010.181254@chino.kir.corp.google.com>
 <20191106073521.GC8314@dhcp22.suse.cz>
 <alpine.DEB.2.21.1911061330030.155572@chino.kir.corp.google.com>
 <20191113112042.GG28938@suse.de>
 <alpine.DEB.2.21.1911241548340.192260@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1911241548340.192260@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 24-11-19 16:10:53, David Rientjes wrote:
[...]
> So my question would be: if we know the previous behavior that allowed 
> excessive swap and recalling into compaction was deemed harmful for the 
> local node, why do we now believe it cannot be harmful if done for all 
> system memory?

I have to say that I got lost in your explanation. I have already
pointed this out in a previous email you didn't reply to. But the main
difference to previous __GFP_THISNODE behavior is that it is used along
with __GFP_NORETRY and that reduces the overall effort of the reclaim
AFAIU. If that is not the case then please be _explicit_ why.

Having test results from Andrea would be really appreciated of course
but he seems to be too busy to do that (or maybe not interested
anymore). I do not see any real reason to hold on this patch based on
hand waving though. So either we have some good reasoning to argue
against the patch or a good testing results or we should go ahead.
As things stand right now, THP success rate went down after your last
changes for _very simple_ workloads. This needs addressing which I hope
we do agree on.
-- 
Michal Hocko
SUSE Labs
