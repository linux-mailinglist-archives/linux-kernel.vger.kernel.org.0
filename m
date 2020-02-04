Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE7C21519E1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 12:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgBDLb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 06:31:59 -0500
Received: from mga11.intel.com ([192.55.52.93]:31424 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbgBDLb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:31:58 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 03:31:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,401,1574150400"; 
   d="scan'208";a="341233043"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 04 Feb 2020 03:31:56 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iywQw-0003o7-J5; Tue, 04 Feb 2020 13:31:58 +0200
Date:   Tue, 4 Feb 2020 13:31:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v1] printk: Declare log_wait as external variable
Message-ID: <20200204113158.GA10400@smile.fi.intel.com>
References: <20200203131528.52825-1-andriy.shevchenko@linux.intel.com>
 <20200204021620.GD41358@google.com>
 <20200204090533.GM32742@smile.fi.intel.com>
 <20200204112211.GA2009@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204112211.GA2009@jagdpanzerIV.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 08:22:11PM +0900, Sergey Senozhatsky wrote:
> On (20/02/04 11:05), Andy Shevchenko wrote:
> > > > --- a/kernel/printk/printk.c
> > > > +extern wait_queue_head_t log_wait;	/* Used in fs/proc/kmsg.c */
> > > >  DECLARE_WAIT_QUEUE_HEAD(log_wait);
> > > > +#else
> > > > +static DECLARE_WAIT_QUEUE_HEAD(log_wait);
> > > > +#endif /* CONFIG_PROC_FS */
> > > 
> > > [..]
> > > 
> > > Since we are now introducing CONFIG_PROC_FS dependency to printk (and
> > > proc/kmsg already has CONFIG_PRINTK dependency),
> > 
> > I'm not sure I understood. The above does not introduce any dependencies.
> 
> kernel/printk/printk.c
>  +#ifdef CONFIG_PROC_FS
>  ..
> 
> Not exactly "dependency"... what is the correct word here.

Maybe "ifdeferry" ?

-- 
With Best Regards,
Andy Shevchenko


