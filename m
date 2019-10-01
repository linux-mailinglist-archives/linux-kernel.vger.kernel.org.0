Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B30B4C33EF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 14:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387641AbfJAMNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 08:13:25 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:58383 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfJAMNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:13:25 -0400
X-Originating-IP: 86.207.98.53
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 77129FF808;
        Tue,  1 Oct 2019 12:13:22 +0000 (UTC)
Date:   Tue, 1 Oct 2019 14:13:21 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1 1/4] lib/vsprintf: Print time64_t in human readable
 format
Message-ID: <20191001121321.GB4106@piout.net>
References: <20190104193009.30907-1-andriy.shevchenko@linux.intel.com>
 <20190108152528.utr3a5huran52gsf@pathway.suse.cz>
 <20190110215858.GG2362@piout.net>
 <20190726132037.GX9224@smile.fi.intel.com>
 <20190930200809.GK3913@piout.net>
 <20191001113655.GI32742@smile.fi.intel.com>
 <20191001114816.GA4106@piout.net>
 <20191001121154.GL32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001121154.GL32742@smile.fi.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2019 15:11:54+0300, Andy Shevchenko wrote:
> On Tue, Oct 01, 2019 at 01:48:16PM +0200, Alexandre Belloni wrote:
> > On 01/10/2019 14:36:55+0300, Andy Shevchenko wrote:
> > > On Mon, Sep 30, 2019 at 10:08:09PM +0200, Alexandre Belloni wrote:
> > > > > > Maybe be rtc_str should take a struct tm instead of an rtc_time so
> > > > > > time64_to_rtc_time always uses time64_to_tm.
> > > > > 
> > > > > Because this one, while sounding plausible, maybe too invasive on current
> > > > > state of affairs.
> > > > 
> > > > Well, if the kernel struct tm had an int tm_year instead of long
> > > > tm_year, then you could simply cast a struct rtc_time to a struct tm.
> > > 
> > > I don't think so. It will be error prone from endianess prospective on
> > > 64-bit platforms.
> > > 
> > 
> > I don't get why, as long as the first members of both structs are the
> > same, this should work.
> 
> On BE 64-bit we will always get tm_year == 0, won't we?
> 

Not if you have int tm_year in struct tm. I guess we can change the
kernel struct tm because it is not part of the ABI.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
