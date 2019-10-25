Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 079D6E46D3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 11:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408741AbfJYJOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 05:14:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:37634 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408664AbfJYJOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:14:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 02:14:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="201757442"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2019 02:14:31 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iNvfy-0002j6-Lk; Fri, 25 Oct 2019 12:14:30 +0300
Date:   Fri, 25 Oct 2019 12:14:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrey Zhizhikin <andrey.z@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>, lgirdwood@gmail.com,
        broonie@kernel.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Subject: Re: [PATCH 1/2] regulator: add support for Intel Cherry Whiskey Cove
 regulator
Message-ID: <20191025091430.GJ32742@smile.fi.intel.com>
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
 <20191024142939.25920-2-andrey.zhizhikin@leica-geosystems.com>
 <20191025080129.GE32742@smile.fi.intel.com>
 <CAHtQpK7e-W9cGyCan=yxM7sSN=L_SKaFy8DSNE4vQGrc_pFdQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHtQpK7e-W9cGyCan=yxM7sSN=L_SKaFy8DSNE4vQGrc_pFdQw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 10:58:05AM +0200, Andrey Zhizhikin wrote:
> On Fri, Oct 25, 2019 at 10:01 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Thu, Oct 24, 2019 at 02:29:38PM +0000, Andrey Zhizhikin wrote:
> > > Add regulator driver for Intel Cherry Trail Whiskey Cove PMIC, which
> > > supplies various voltage rails.
> > >
> > > This initial version supports only vsdio, which is required to source
> > > vqmmc for sd card interface.
> >
> > This patch has some style issues. I will wait for Adrian and Hans to comment on
> > the approach as a whole and then we will see how to improve the rest.
> 
> Agreed, styling issues are coming from definition of CHT_WC_REGULATOR
> elements in regulators_info array, and they are mainly related to 80
> characters per line. I decided to leave it like this since it is more
> readable. But if the 80 characters rule is to be enforced here - I can
> go with something like this for every element:
> CHT_WC_REGULATOR(V3P3A,    3000, 3350, 0x00, 0x07,\
>                                      50, 0x01, 0x01, 0x0, true,  NULL),

No, I'm not talking about these. Actually I hate this 80 limit in 21st century.
But let's not discuss it right now.

> Let's wait for other people's comments here and I can then come up
> with v2 of this patch.

Exactly!

-- 
With Best Regards,
Andy Shevchenko


