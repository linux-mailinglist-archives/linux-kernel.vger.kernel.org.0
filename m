Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3026B03A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 22:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388355AbfGPUHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 16:07:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:58420 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726213AbfGPUHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 16:07:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AF0E5ABE3;
        Tue, 16 Jul 2019 20:07:16 +0000 (UTC)
Date:   Tue, 16 Jul 2019 22:07:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, catalin.marinas@arm.com,
        dvyukov@google.com, rientjes@google.com, willy@infradead.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "kmemleak: allow to coexist with fault injection"
Message-ID: <20190716200715.GA14663@dhcp22.suse.cz>
References: <1563299431-111710-1-git-send-email-yang.shi@linux.alibaba.com>
 <1563301410.4610.8.camel@lca.pw>
 <a198d00d-d1f4-0d73-8eb8-6667c0bdac04@linux.alibaba.com>
 <1563304877.4610.10.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563304877.4610.10.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 16-07-19 15:21:17, Qian Cai wrote:
[...]
> Thanks to this commit, there are allocation with __GFP_DIRECT_RECLAIM that
> succeeded would keep trying with __GFP_NOFAIL for kmemleak tracking object
> allocations.

Well, not really. Because low order allocations with
__GFP_DIRECT_RECLAIM basically never fail (they keep retrying) even
without GFP_NOFAIL because that flag is actually to guarantee no
failure. And for high order allocations the nofail mode is actively
harmful. It completely changes the behavior of a system. A light costly
order workload could put the system on knees and completely change the
behavior. I am not really convinced this is a good behavior of a
debugging feature TBH.

> Otherwise, one kmemleak object allocation failure would kill the
> whole kmemleak.

Which is not great but quite likely a better than an unpredictable MM
behavior caused by NOFAIL storms. Really, this NOFAIL patch is a
completely broken behavior. There shouldn't be much discussion about
reverting it. I would even argue it shouldn't have been merged in the
first place. It doesn't have any acks nor reviewed-bys while it abuses
__GFP_NOFAIL which is generally discouraged to be used.

Thanks!
-- 
Michal Hocko
SUSE Labs
