Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2DFC144061
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 16:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgAUPVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 10:21:00 -0500
Received: from mga05.intel.com ([192.55.52.43]:16101 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbgAUPVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 10:21:00 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 07:20:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,346,1574150400"; 
   d="scan'208";a="227364523"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 21 Jan 2020 07:20:58 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1itvKt-0007VP-Dm; Tue, 21 Jan 2020 17:20:59 +0200
Date:   Tue, 21 Jan 2020 17:20:59 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan McDowell <noodles@earth.li>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/9] x86/quirks: Convert DMI matching to use a table
Message-ID: <20200121152059.GV32742@smile.fi.intel.com>
References: <20200120160801.53089-6-andriy.shevchenko@linux.intel.com>
 <20200121115124.GA16758@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121115124.GA16758@earth.li>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 11:51:25AM +0000, Jonathan McDowell wrote:
> In article <20200120160801.53089-6-andriy.shevchenko@linux.intel.com> you wrote:
> > In order to extend the DMI based quirks, convert them to a table.

> > +static void __init early_platfrom_detect_quirk(void)
> 
> "platform"

> > +	early_platfrom_detect_quirk();
> 
> As above.

Thanks! Will fix in v3.

-- 
With Best Regards,
Andy Shevchenko


