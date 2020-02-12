Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05ECF15A858
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 12:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgBLLyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 06:54:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:64718 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgBLLyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 06:54:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 03:54:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="251888571"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 12 Feb 2020 03:54:41 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j1qbK-000vnD-9n; Wed, 12 Feb 2020 13:54:42 +0200
Date:   Wed, 12 Feb 2020 13:54:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/18] platform/x86: intel_scu_ipc: Log more
 information if SCU IPC command fails
Message-ID: <20200212115442.GS10400@smile.fi.intel.com>
References: <20200211132603.73509-1-mika.westerberg@linux.intel.com>
 <20200211132603.73509-3-mika.westerberg@linux.intel.com>
 <20200211154138.GE10400@smile.fi.intel.com>
 <20200212113649.GV2667@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212113649.GV2667@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 01:36:49PM +0200, Mika Westerberg wrote:
> On Tue, Feb 11, 2020 at 05:41:38PM +0200, Andy Shevchenko wrote:
> > On Tue, Feb 11, 2020 at 04:25:47PM +0300, Mika Westerberg wrote:

...

> > >  	mutex_lock(&ipclock);
> > 
> > > +	cmdval = (inlen << 16) | (sub << 12) | cmd;
> > > +	ipc_command(scu, cmdval);
> > >  	err = intel_scu_ipc_check_status(scu);
> > > -
> > > -	if (!err) {
> > > +	if (err) {
> > > +		dev_err(&scu->dev, "IPC command %#x failed with %d\n", cmdval,
> > > +			err);
> > > +	} else {
> > >  		for (i = 0; i < outlen; i++)
> > >  			*out++ = ipc_data_readl(scu, 4 * i);
> > >  	}
> > 
> > It's not visible in this context but it looks like above applies here as well.
> 
> You mean move outside of the lock? This one calls ipc_data_readl()
> which should be under the lock.

I meant to move dev_err() out of the lock. The rest of course requires to stay
under it.

-- 
With Best Regards,
Andy Shevchenko


