Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECB019A7AF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 10:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbgDAIsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 04:48:31 -0400
Received: from mga03.intel.com ([134.134.136.65]:27048 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgDAIsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:48:30 -0400
IronPort-SDR: USmfdhEQAj6HToTW3ouSD7TlwpSMe8SR9FOxL4MEJOOkUGfZSzNNsOAjo6/ECIgsRr6iz+HmV9
 ZEEK49KfZDqA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 01:48:30 -0700
IronPort-SDR: +kD+1LPObTnDW+tjrDY8ZK6ifmKOtSQjFurJiHpJ92L5wdLV1NklAlEmViRVCAclUsOX0wwzvy
 LRNSi/vHiihg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,331,1580803200"; 
   d="scan'208";a="295263752"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Apr 2020 01:48:27 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Minchan Kim <minchan@kernel.org>,
        "Hugh Dickins" <hughd@google.com>, Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] mm, trivial: Simplify swap related code in try_to_unmap_one()
References: <20200331084613.1258555-1-ying.huang@intel.com>
        <20200331094108.GF30449@dhcp22.suse.cz>
        <87tv24j9hq.fsf@yhuang-dev.intel.com>
        <20200401083145.GF22681@dhcp22.suse.cz>
Date:   Wed, 01 Apr 2020 16:48:27 +0800
In-Reply-To: <20200401083145.GF22681@dhcp22.suse.cz> (Michal Hocko's message
        of "Wed, 1 Apr 2020 10:31:45 +0200")
Message-ID: <87tv23h9r8.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> writes:

> On Wed 01-04-20 09:11:13, Huang, Ying wrote:
> [...]
>> Then what is the check !PageSwapBacked() && PageSwapCache() for?  To
>> prevent someone to change the definition of PageSwapCache() in the
>> future to break this?
>
> Yes this is my understading. It is essentially an assert that enforces
> the assumption about swap cache vs. swap backed being coupled.

OK.  Then we can just keep the current code.

Best Regards,
Huang, Ying
