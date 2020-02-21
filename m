Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0543167DD1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 13:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgBUM7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 07:59:17 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57956 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgBUM7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 07:59:17 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 726AC29617A;
        Fri, 21 Feb 2020 12:59:14 +0000 (GMT)
Date:   Fri, 21 Feb 2020 13:59:11 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Vitor Soares <Vitor.Soares@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "wsa@the-dreams.de" <wsa@the-dreams.de>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>
Subject: Re: [PATCH v3 3/5] i3c: master: add i3c_for_each_dev helper
Message-ID: <20200221135911.1300170b@collabora.com>
In-Reply-To: <20200221115229.GA116368@kroah.com>
References: <cover.1582069402.git.vitor.soares@synopsys.com>
        <868e5b37fd817b65e6953ed7279f5063e5fc06c5.1582069402.git.vitor.soares@synopsys.com>
        <20200219073548.GA2728338@kroah.com>
        <CH2PR12MB4216D5141E562974634430B8AE120@CH2PR12MB4216.namprd12.prod.outlook.com>
        <20200221115229.GA116368@kroah.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020 12:52:29 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, Feb 21, 2020 at 11:47:22AM +0000, Vitor Soares wrote:
> > Hi Greg,
> > 
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Date: Wed, Feb 19, 2020 at 07:35:48
> >   
> > > On Wed, Feb 19, 2020 at 01:20:41AM +0100, Vitor Soares wrote:  
> > > > Introduce i3c_for_each_dev(), an i3c device iterator for use by i3cdev.
> > > > 
> > > > Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> > > > ---
> > > >  drivers/i3c/internals.h |  1 +
> > > >  drivers/i3c/master.c    | 12 ++++++++++++
> > > >  2 files changed, 13 insertions(+)
> > > > 
> > > > diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
> > > > index bc062e8..a6deedf 100644
> > > > --- a/drivers/i3c/internals.h
> > > > +++ b/drivers/i3c/internals.h
> > > > @@ -24,4 +24,5 @@ int i3c_dev_enable_ibi_locked(struct i3c_dev_desc *dev);
> > > >  int i3c_dev_request_ibi_locked(struct i3c_dev_desc *dev,
> > > >  			       const struct i3c_ibi_setup *req);
> > > >  void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev);
> > > > +int i3c_for_each_dev(void *data, int (*fn)(struct device *, void *));
> > > >  #endif /* I3C_INTERNAL_H */
> > > > diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> > > > index 21c4372..8e22da2 100644
> > > > --- a/drivers/i3c/master.c
> > > > +++ b/drivers/i3c/master.c
> > > > @@ -2640,6 +2640,18 @@ void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev)
> > > >  	dev->ibi = NULL;
> > > >  }
> > > >  
> > > > +int i3c_for_each_dev(void *data, int (*fn)(struct device *, void *))
> > > > +{
> > > > +	int res;
> > > > +
> > > > +	mutex_lock(&i3c_core_lock);
> > > > +	res = bus_for_each_dev(&i3c_bus_type, NULL, data, fn);
> > > > +	mutex_unlock(&i3c_core_lock);  
> > > 
> > > Ick, why the lock?  Are you _sure_ you need that?  The core should
> > > handle any list locking issues here, right?  
> > 
> > I want to make sure that no new devices (eg: Hot-Join capable device) are 
> > added during this iteration and after this call, each new device will 
> > release a bus notification.
> >   
> > > 
> > > I don't see bus-specific-locks around other subsystem functions that do
> > > this (like usb_for_each_dev).  
> > 
> > I based in I2C use case.  
> 
> Check to see if this is really needed, for some reason I doubt it...

Can we please try the spidev approach before fixing those problems. None
of that would be needed if we declare the i3cdev driver as a regular
i3c_device_driver and let user space bind devices it wants to expose
through the sysfs interface. As I said earlier, we even have all the
pieces we need to automate that using a udev rule, and the resulting
patchset would be 'less invasive'/simpler for pretty much the same
result.
