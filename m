Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1288143DD9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 14:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgAUNUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 08:20:52 -0500
Received: from mga18.intel.com ([134.134.136.126]:7017 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgAUNUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 08:20:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 05:20:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,346,1574150400"; 
   d="scan'208";a="399661878"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 21 Jan 2020 05:20:49 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ittSc-0006R7-VA; Tue, 21 Jan 2020 15:20:50 +0200
Date:   Tue, 21 Jan 2020 15:20:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yury Norov <yury.norov@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        "Tobin C. Harding" <tobin@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/bitmap: remove expect_eq_u32_array
Message-ID: <20200121132050.GT32742@smile.fi.intel.com>
References: <1579595625-250942-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579595625-250942-1-git-send-email-alex.shi@linux.alibaba.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 04:33:45PM +0800, Alex Shi wrote:
> expect_eq_u32_array isn't used from commit 3aa56885e516 ("bitmap:
> replace bitmap_{from,to}_u32array").
> And EXP2_IN_BITS are never used. so better to remove them.

I think better "fix" will be to add test cases.
See the commit message in the

commit 3aa56885e51683a19c8aa71739fd279b3f501cd7
Author: Yury Norov <ynorov@caviumnetworks.com>
Date:   Tue Feb 6 15:38:06 2018 -0800

    bitmap: replace bitmap_{from,to}_u32array

-- 
With Best Regards,
Andy Shevchenko


