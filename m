Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38A1814B1F4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 10:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgA1JoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 04:44:19 -0500
Received: from mga14.intel.com ([192.55.52.115]:49545 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgA1JoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 04:44:19 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2020 01:44:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,373,1574150400"; 
   d="scan'208";a="217568281"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 28 Jan 2020 01:44:16 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iwNPu-0007Jz-3K; Tue, 28 Jan 2020 11:44:18 +0200
Date:   Tue, 28 Jan 2020 11:44:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] console: Introduce ->exit() callback
Message-ID: <20200128094418.GY32742@smile.fi.intel.com>
References: <20200127114719.69114-1-andriy.shevchenko@linux.intel.com>
 <20200127114719.69114-5-andriy.shevchenko@linux.intel.com>
 <20200128051711.GB115889@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128051711.GB115889@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 02:17:11PM +0900, Sergey Senozhatsky wrote:
> On (20/01/27 13:47), Andy Shevchenko wrote:

...

> > @@ -2853,6 +2853,10 @@ int unregister_console(struct console *console)
> >  	console->flags &= ~CON_ENABLED;
> >  	console_unlock();
> >  	console_sysfs_notify();
> > +
> > +	if (console->exit)
> > +		console->exit(console);
> > +
> 
> If the console was not registered (hence not enabled) is it still required
> to call ->exit()? Is there a requirement that ->exit() should handle such
> cases?

This is a good point. The ->exit() purpose is to keep balance for whatever
happened at ->setup().

But ->setup() is being called either when we have has_preferred == false or
when we got no matching we call it for all such consoles, till it returns an
error (can you elaborate the logic behind it?).

In both cases we will get the console to have CON_ENABLED flag set.

-- 
With Best Regards,
Andy Shevchenko


