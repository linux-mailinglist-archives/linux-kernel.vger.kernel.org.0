Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECE4B14A10D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 10:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgA0Jog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 04:44:36 -0500
Received: from mga06.intel.com ([134.134.136.31]:21727 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729308AbgA0Jog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 04:44:36 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 01:42:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,369,1574150400"; 
   d="scan'208";a="231376760"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 27 Jan 2020 01:42:34 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iw0uh-0001t3-NU; Mon, 27 Jan 2020 11:42:35 +0200
Date:   Mon, 27 Jan 2020 11:42:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] console: Introduce ->exit() callback
Message-ID: <20200127094235.GS32742@smile.fi.intel.com>
References: <20200124155733.54799-1-andriy.shevchenko@linux.intel.com>
 <20200124155733.54799-5-andriy.shevchenko@linux.intel.com>
 <20200127022220.GB100275@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127022220.GB100275@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 11:22:20AM +0900, Sergey Senozhatsky wrote:
> On (20/01/24 17:57), Andy Shevchenko wrote:
> [..]
> > +++ b/include/linux/console.h
> > @@ -148,6 +148,7 @@ struct console {
> >  	struct tty_driver *(*device)(struct console *, int *);
> >  	void	(*unblank)(void);
> >  	int	(*setup)(struct console *, char *);
> > +	void	(*exit)(struct console *);
> >  	int	(*match)(struct console *, char *name, int idx, char *options);
> >  	short	flags;
> >  	short	index;
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index da6a9bdf76b6..0319bb698d05 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2850,6 +2850,9 @@ int unregister_console(struct console *console)
> >  	if (console_drivers != NULL && console->flags & CON_CONSDEV)
> >  		console_drivers->flags |= CON_CONSDEV;
> >
> > +	if (console->exit)
> > +		console->exit(console);
> > +
> >  	console->flags &= ~CON_ENABLED;
> >  	console_unlock();
> >  	console_sysfs_notify();
> 
> Do you need to call ->exit() under console_lock?

I think we don't need that lock to be held.


-- 
With Best Regards,
Andy Shevchenko


