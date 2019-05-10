Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCECE19AD8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 11:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfEJJk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 05:40:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:58688 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727136AbfEJJk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 05:40:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2D185ADD2;
        Fri, 10 May 2019 09:40:26 +0000 (UTC)
Date:   Fri, 10 May 2019 11:40:25 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kobject_init_and_add() confusion
Message-ID: <20190510094025.wiw37baomizk6bip@pathway.suse.cz>
References: <20190430233803.GB10777@eros.localdomain>
 <CAJZ5v0g34RZmugeBm63UT3XRvUmdJtvCAjcowdwDffrRorrscQ@mail.gmail.com>
 <20190510023538.GA10356@eros.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510023538.GA10356@eros.localdomain>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-05-10 12:35:38, Tobin C. Harding wrote:
> On Wed, May 01, 2019 at 09:54:16AM +0200, Rafael J. Wysocki wrote:
> > On Wed, May 1, 2019 at 1:38 AM Tobin C. Harding <me@tobin.cc> wrote:
> > > TODO
> > > ----
> > >
> > > - Fix all the callsites to kobject_init_and_add()
> > > - Further clarify the function docstring for kobject_init_and_add() [perhaps]
> > > - Add a section to Documentation/kobject.txt [optional]
> > > - Add a sample usage file under samples/kobject [optional]
> > 
> > The plan sounds good to me, but there is one thing to note IMO:
> > kobject_cleanup() invokes the ->release() callback for the ktype, so
> > these callbacks need to be able to cope with kobjects after a failing
> > kobject_add() which may not be entirely obvious to developers
> > introducing them ATM.
> 
> It has taken a while for this to soak in.  This is actually quite an
> insidious issue.  If I give an example and perhaps we can come to a
> solution.  This example is based on the code (and assumptions) in
> mm/slub.c
> 
> If a developer has an object that they wish to add to sysfs they go
> ahead and embed a kobject in it.  Correctly set up a ktype including
> release function that just frees the object (using container of).  Now
> assume that the object is already set up and in use when we go to set up
> the sysfs entry.

It would say that this is a bad design. I see the creation of the sysfs
entry as part of the initialization. The object should not be made
usable before it is fully initialized.


> If kobject_init_and_add() fails and we correctly call
> kobject_put() the containing object will be free'd.  Yet the calling
> code may not be done with the object, more to the point just because
> sysfs setup fails the object is now unusable.  Besides the interesting
> theoretical discussion this means we cannot just go and willy-nilly add
> calls to kobject_put() in the error path of kobject_init_and_add() if
> the original code was not written under the assumption that the release
> method could be called during the error path (I have found 2 places at
> least where behaviour of calling the release method is non-trivial to
> ascertain).

kobject usage is complicated and it is easy to make it wrong. I think
that this is motivation to improve the documentation and adding
good examples.

> I guess, as Greg said, its just a matter that reference counting within
> the kernel is a hard problem.  So we fix the easy ones and then look a
> bit harder at the hard ones ...

The people working on the affected subsystem should be able to help.
They might have misunderstood kobjects. But they should be more
familiar with the other dependencies.

Thanks for working on it.

Best Regards,
Petr
