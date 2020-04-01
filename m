Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB6B19A32B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 03:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbgDABLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 21:11:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:52963 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731509AbgDABLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 21:11:16 -0400
IronPort-SDR: Waj2ww+gzAWw2kUpbkGphjX3KXrHc5h8aZmY6ipKJfKj9ctXiOnJxvrMuRrYObYjBdL10ds9Py
 6hiy/eQkACPg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 18:11:16 -0700
IronPort-SDR: gVHqeaoV5DJbZvb07/8/RB7XQ093VpOpw0AdRMNQZPAYpo2I1y2KFXuAf7DRcKt0p2lUe1u+O8
 Ru6U8Ow1BCYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,329,1580803200"; 
   d="scan'208";a="448891586"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by fmsmga005.fm.intel.com with ESMTP; 31 Mar 2020 18:11:14 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Minchan Kim <minchan@kernel.org>,
        "Hugh Dickins" <hughd@google.com>, Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] mm, trivial: Simplify swap related code in try_to_unmap_one()
References: <20200331084613.1258555-1-ying.huang@intel.com>
        <20200331094108.GF30449@dhcp22.suse.cz>
Date:   Wed, 01 Apr 2020 09:11:13 +0800
In-Reply-To: <20200331094108.GF30449@dhcp22.suse.cz> (Michal Hocko's message
        of "Tue, 31 Mar 2020 11:41:08 +0200")
Message-ID: <87tv24j9hq.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> writes:

> On Tue 31-03-20 16:46:13, Huang, Ying wrote:
>> From: Huang Ying <ying.huang@intel.com>
>> 
>> Because PageSwapCache() will always return false if PageSwapBacked() returns
>> false, and PageSwapBacked() will be check for MADV_FREE pages in
>> try_to_unmap_one().  The swap related code in try_to_unmap_one() can be
>> simplified to improve the readability.
>
> My understanding is that this is a sanity check to let us know if
> something breaks. Do we really want to get rid of it? Maybe it is not
> really useful but if that is the case then the changelog should reflect
> this fact.

Now the definition of PageSwapCache() is,

static __always_inline int PageSwapCache(struct page *page)
{
#ifdef CONFIG_THP_SWAP
	page = compound_head(page);
#endif
	return PageSwapBacked(page) && test_bit(PG_swapcache, &page->flags);
}

So, if PageSwapBacked() returns false, PageSwapCache() will always
return false.  The original checking,

-			if (unlikely(PageSwapBacked(page) != PageSwapCache(page))) {

is equivalent to

-			if (unlikely(PageSwapBacked(page) && !PageSwapCache(page))) {

Then what is the check !PageSwapBacked() && PageSwapCache() for?  To
prevent someone to change the definition of PageSwapCache() in the
future to break this?

Best Regards,
Huang, Ying
