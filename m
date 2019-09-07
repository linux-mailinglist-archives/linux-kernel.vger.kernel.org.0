Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0040FAC7FA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2019 19:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395086AbfIGRMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Sep 2019 13:12:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:50196 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731167AbfIGRMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 13:12:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2019 10:12:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,478,1559545200"; 
   d="scan'208";a="199750399"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 07 Sep 2019 10:12:52 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i6eGZ-00008r-D3; Sat, 07 Sep 2019 20:12:51 +0300
Date:   Sat, 7 Sep 2019 20:12:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 1/3] software node: implement reference properties
Message-ID: <20190907171251.GL2680@smile.fi.intel.com>
References: <20190906222611.223532-1-dmitry.torokhov@gmail.com>
 <20190907160819.GH2680@smile.fi.intel.com>
 <20190907163240.GA27112@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190907163240.GA27112@dtor-ws>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 07, 2019 at 09:32:40AM -0700, Dmitry Torokhov wrote:
> On Sat, Sep 07, 2019 at 07:08:19PM +0300, Andy Shevchenko wrote:
> > On Fri, Sep 06, 2019 at 03:26:09PM -0700, Dmitry Torokhov wrote:

> > > +	} else if (src->type == DEV_PROP_REF) {
> > > +		/* All reference properties must be arrays */
> > > +		return -EINVAL;
> > 
> > Hmm... What about to duplicate pointer under value union and use is_array to
> > distinguish which one to use? Because...
> 
> Then we have to special-case copying this entry, similar to the pains we
> are going with the strings.

I can't see it as a pain. Simple do the same kmemdup() for the case when
is_array = false and DEV_TYPE_REF?

By the way, don't we need to update property_entry_{get,set}_pointer()?

> > > +	.is_array = true,						\
> > 
> > I really don't like this "cheating".
> 
> This is not cheating. Any single value can be represented as an array of
> one element. Actually, the only reason we have this "is_array" business
> is because for scalar values and short strings it is much cheaper to
> store single value in-line instead of out of line + pointer, especially
> on 64 bit arches.

Yes, and this is a lot of benefit!

> If you want we can change is_array into is_inline.

Nope, is_array is exactly what it tells us about the content. Its functional
load is to distinguish which union (value vs. pointer) we are using.

-- 
With Best Regards,
Andy Shevchenko


