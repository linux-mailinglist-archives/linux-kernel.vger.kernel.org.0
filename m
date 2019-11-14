Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12568FCA57
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 16:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfKNP4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 10:56:09 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:55450 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726516AbfKNP4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:56:09 -0500
Received: (qmail 1820 invoked by uid 2102); 14 Nov 2019 10:56:07 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Nov 2019 10:56:07 -0500
Date:   Thu, 14 Nov 2019 10:56:07 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrey Konovalov <andreyknvl@google.com>
cc:     USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Felipe Balbi <balbi@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH 0/1] usb: gadget: add raw-gadget interface
In-Reply-To: <CAAeHK+zPh1zkALKNgnJb0_rGWYfTJGU2H+fsbe5XkSD9HLWumA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1911141053490.1622-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2019, Andrey Konovalov wrote:

> > > As a general rule, gadget drivers don't go directly in
> > > drivers/usb/gadget.  raw.c counts as a legacy driver (because it's not
> > > written to use the composite gadget framework), so it belongs in
> > > drivers/usb/gadget/legacy.  That's where the gadgetfs driver lives, for
> > > example.
> >
> > Hi Alan! Sure, I'll move it to legacy/ in v2. Thanks!
> 
> Hi Alan,
> 
> Should I move CONFIG_USB_RAW_GADGET into legacy/Kconfig as well? AFAIU
> this makes it impossible to turn on e.g. both GadgetFS and Raw Gadget
> at the same time, since they both become options of the same choice.

We can probably live with that.  Not many people will want to build the 
Raw Gadget driver, and even fewer will want it together with gadgetfs.

But if you want to keep the Kconfig option in the higher-level
directory, that's probably okay.

Alan Stern

