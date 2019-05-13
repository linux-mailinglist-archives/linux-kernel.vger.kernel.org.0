Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5EFC1BF35
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 23:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfEMVpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 17:45:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:47880 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726174AbfEMVpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 17:45:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A9351AC94;
        Mon, 13 May 2019 21:45:04 +0000 (UTC)
Date:   Mon, 13 May 2019 23:45:03 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     ying.huang@intel.com, hannes@cmpxchg.org,
        mgorman@techsingularity.net, kirill.shutemov@linux.intel.com,
        hughd@google.com, shakeelb@google.com,
        william.kucharski@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] mm: vmscan: correct nr_reclaimed for THP
Message-ID: <20190513214503.GB25356@dhcp22.suse.cz>
References: <1557505420-21809-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190513080929.GC24036@dhcp22.suse.cz>
 <c3c26c7a-748c-6090-67f4-3014bedea2e6@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3c26c7a-748c-6090-67f4-3014bedea2e6@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 13-05-19 14:09:59, Yang Shi wrote:
[...]
> I think we can just account 512 base pages for nr_scanned for
> isolate_lru_pages() to make the counters sane since PGSCAN_KSWAPD/DIRECT
> just use it.
> 
> And, sc->nr_scanned should be accounted as 512 base pages too otherwise we
> may have nr_scanned < nr_to_reclaim all the time to result in false-negative
> for priority raise and something else wrong (e.g. wrong vmpressure).

Be careful. nr_scanned is used as a pressure indicator to slab shrinking
AFAIR. Maybe this is ok but it really begs for much more explaining
than "it should be fine". This should have happened when THP swap out
was implemented...

-- 
Michal Hocko
SUSE Labs
