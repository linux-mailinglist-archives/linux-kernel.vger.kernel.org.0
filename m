Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8B4030857
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 08:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfEaGKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 02:10:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:57264 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726275AbfEaGKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 02:10:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 44BBFAF8E;
        Fri, 31 May 2019 06:10:49 +0000 (UTC)
Date:   Fri, 31 May 2019 08:10:47 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH -mm] mm, swap: Fix bad swap file entry warning
Message-ID: <20190531061047.GB6896@dhcp22.suse.cz>
References: <20190531024102.21723-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531024102.21723-1-ying.huang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 31-05-19 10:41:02, Huang, Ying wrote:
> From: Huang Ying <ying.huang@intel.com>
> 
> Mike reported the following warning messages
> 
>   get_swap_device: Bad swap file entry 1400000000000001
> 
> This is produced by
> 
> - total_swapcache_pages()
>   - get_swap_device()
> 
> Where get_swap_device() is used to check whether the swap device is
> valid and prevent it from being swapoff if so.  But get_swap_device()
> may produce warning message as above for some invalid swap devices.
> This is fixed via calling swp_swap_info() before get_swap_device() to
> filter out the swap devices that may cause warning messages.
> 
> Fixes: 6a946753dbe6 ("mm/swap_state.c: simplify total_swapcache_pages() with get_swap_device()")

I suspect this is referring to a mmotm patch right? There doesn't seem
to be any sha like this in Linus' tree AFAICS. If that is the case then
please note that mmotm patch showing up in linux-next do not have a
stable sha1 and therefore you shouldn't reference them in the commit
message. Instead please refer to the specific mmotm patch file so that
Andrew knows it should be folded in to it.

Thanks!
-- 
Michal Hocko
SUSE Labs
