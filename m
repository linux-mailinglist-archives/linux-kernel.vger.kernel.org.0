Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 812DA14EBB2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 12:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgAaL1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 06:27:25 -0500
Received: from mga05.intel.com ([192.55.52.43]:31358 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728374AbgAaL1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 06:27:24 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2020 03:27:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,385,1574150400"; 
   d="scan'208";a="428685092"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 31 Jan 2020 03:27:22 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ixUSK-00032f-D7; Fri, 31 Jan 2020 13:27:24 +0200
Date:   Fri, 31 Jan 2020 13:27:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] console: Introduce ->exit() callback
Message-ID: <20200131112724.GM32742@smile.fi.intel.com>
References: <20200130152558.51839-1-andriy.shevchenko@linux.intel.com>
 <20200130152558.51839-5-andriy.shevchenko@linux.intel.com>
 <20200131013154.GH115889@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131013154.GH115889@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 10:31:54AM +0900, Sergey Senozhatsky wrote:
> On (20/01/30 17:25), Andy Shevchenko wrote:
> [..]
> > diff --git a/include/linux/console.h b/include/linux/console.h
> > index f33016b3a401..54759ad0c36b 100644
> > --- a/include/linux/console.h
> > +++ b/include/linux/console.h
> > @@ -148,6 +148,7 @@ struct console {
> >  	struct tty_driver *(*device)(struct console *, int *);
> >  	void	(*unblank)(void);
> >  	int	(*setup)(struct console *, char *);
> > +	void	(*exit)(struct console *);
> 

> Should console ->exit() be able to return an error code?

Let's do it!

> >  	int	(*match)(struct console *, char *name, int idx, char *options);
> >  	short	flags;
> >  	short	index;
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 932345e6cd71..0117d4d92a8e 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2850,6 +2850,10 @@ int unregister_console(struct console *console)
> >  	console->flags &= ~CON_ENABLED;
> >  	console_unlock();
> >  	console_sysfs_notify();
> > +
> > +	if (!res && console->exit)
> > +		console->exit(console);
> > +
> >  	return res;
> >  }
> 
> I would probably push it a bit further (I posted this snippet in another
> thread). If console is not on the list then there is nothing for us to do
> and sysfs notify is pointless.

I didn't see post in the other thread, but I suppose that this snipped is
for patch 4 in the series, correct?

> 
> ---
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 0117d4d92a8e..7116e421210b 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2837,7 +2837,13 @@ int unregister_console(struct console *console)
>  		}
>  	}
>  
> -	if (!res && (console->flags & CON_EXTENDED))
> +	if (res) {
> +		console->flags &= ~CON_ENABLED;
> +		console_unlock();
> +		return res;
> +	}
> +
> +	if (console->flags & CON_EXTENDED)
>  		nr_ext_console_drivers--;
>  
>  	/*
> @@ -2851,7 +2857,7 @@ int unregister_console(struct console *console)
>  	console_unlock();
>  	console_sysfs_notify();
>  
> -	if (!res && console->exit)
> +	if (console->exit)

>  		console->exit(console);
>  
>  	return res;

...then something like

		return console->exit(console);

	return 0;

...or...

		res = console->exit(console);

Which one is preferable?

-- 
With Best Regards,
Andy Shevchenko


