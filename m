Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 305C98A0A4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 16:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfHLOVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 10:21:17 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:46964 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726354AbfHLOVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:21:15 -0400
Received: (qmail 2945 invoked by uid 2102); 12 Aug 2019 10:21:14 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Aug 2019 10:21:14 -0400
Date:   Mon, 12 Aug 2019 10:21:14 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrey Konovalov <andreyknvl@google.com>
cc:     Greg KH <greg@kroah.com>,
        syzbot <syzbot+30cf45ebfe0b0c4847a1@syzkaller.appspotmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, <kirr@nexedi.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, <lkundrak@v3.sk>,
        <logang@deltatee.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in ld_usb_release
In-Reply-To: <CAAeHK+xZgjD+gP=pCkk0uKVkuPG+XZ26mgNQCGzw2ea5mqFTJg@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1908121020180.1659-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2019, Andrey Konovalov wrote:

> Alan, could you submit this patch (if you haven't already)? Looks like
> it fixes this bug (and might fix some others).

I will.  I was waiting to see if Greg KH had any comments.

Alan Stern


> >  drivers/usb/core/file.c |   10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > Index: usb-devel/drivers/usb/core/file.c
> > ===================================================================
> > --- usb-devel.orig/drivers/usb/core/file.c
> > +++ usb-devel/drivers/usb/core/file.c
> > @@ -193,9 +193,10 @@ int usb_register_dev(struct usb_interfac
> >                 intf->minor = minor;
> >                 break;
> >         }
> > -       up_write(&minor_rwsem);
> > -       if (intf->minor < 0)
> > +       if (intf->minor < 0) {
> > +               up_write(&minor_rwsem);
> >                 return -EXFULL;
> > +       }
> >
> >         /* create a usb class device for this usb interface */
> >         snprintf(name, sizeof(name), class_driver->name, minor - minor_base);
> > @@ -203,12 +204,11 @@ int usb_register_dev(struct usb_interfac
> >                                       MKDEV(USB_MAJOR, minor), class_driver,
> >                                       "%s", kbasename(name));
> >         if (IS_ERR(intf->usb_dev)) {
> > -               down_write(&minor_rwsem);
> >                 usb_minors[minor] = NULL;
> >                 intf->minor = -1;
> > -               up_write(&minor_rwsem);
> >                 retval = PTR_ERR(intf->usb_dev);
> >         }
> > +       up_write(&minor_rwsem);
> >         return retval;
> >  }
> >  EXPORT_SYMBOL_GPL(usb_register_dev);
> > @@ -234,12 +234,12 @@ void usb_deregister_dev(struct usb_inter
> >                 return;
> >
> >         dev_dbg(&intf->dev, "removing %d minor\n", intf->minor);
> > +       device_destroy(usb_class->class, MKDEV(USB_MAJOR, intf->minor));
> >
> >         down_write(&minor_rwsem);
> >         usb_minors[intf->minor] = NULL;
> >         up_write(&minor_rwsem);
> >
> > -       device_destroy(usb_class->class, MKDEV(USB_MAJOR, intf->minor));
> >         intf->usb_dev = NULL;
> >         intf->minor = -1;
> >         destroy_usb_class();

