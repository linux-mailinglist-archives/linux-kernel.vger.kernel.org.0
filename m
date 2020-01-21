Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17E75143DCD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 14:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgAUNSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 08:18:03 -0500
Received: from mga04.intel.com ([192.55.52.120]:35186 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728852AbgAUNSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 08:18:03 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 05:18:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,346,1574150400"; 
   d="scan'208";a="250254775"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jan 2020 05:18:01 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ittPu-0006Pk-O5; Tue, 21 Jan 2020 15:18:02 +0200
Date:   Tue, 21 Jan 2020 15:18:02 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/bitmap: remove unused macro BASEDEC
Message-ID: <20200121131802.GS32742@smile.fi.intel.com>
References: <1579595641-251181-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579595641-251181-1-git-send-email-alex.shi@linux.alibaba.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 04:34:01PM +0800, Alex Shi wrote:
> This macro isn't used after commit 4b060420a596 ("bitmap, irq: add
> smp_affinity_list interface to /proc/irq"). better to remove it.

Isn't it already done in linux-next?

commit c2c67926dda7c0fd85faa81cd08976a583218b7d
Author: Yury Norov <yury.norov@gmail.com>
Date:   Wed Jan 15 14:36:23 2020 +1100

    lib: rework bitmap_parse()

-- 
With Best Regards,
Andy Shevchenko


