Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED1512A2F3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Dec 2019 16:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfLXPXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Dec 2019 10:23:13 -0500
Received: from netrider.rowland.org ([192.131.102.5]:53657 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726246AbfLXPXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 10:23:13 -0500
Received: (qmail 29034 invoked by uid 500); 24 Dec 2019 10:23:12 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Dec 2019 10:23:12 -0500
Date:   Tue, 24 Dec 2019 10:23:12 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     AceLan Kao <acelan.kao@canonical.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Harry Pan <harry.pan@intel.com>,
        David Heinzelmann <heinzelmann.david@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Mathieu Malaterre <malat@debian.org>,
        <linux-usb@vger.kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: hub: move resume delay at the head of all USB access
 functions
In-Reply-To: <CAFv23Qn9h=pwaHkiMB2ci-OaR54gY6fdc1Q_7ZMz5mH7wHr9+w@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1912241021580.28718-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Dec 2019, AceLan Kao wrote:

> > > you'll encounter the below errors sometime.
> > > After the issue happens, have to re-plug the USB cable to recover.
> > >
> > > [ 837.483573] hub 2-3:1.0: hub_ext_port_status failed (err = -71)
> > > [ 837.490889] hub 2-3:1.0: hub_ext_port_status failed (err = -71)
> > > [ 837.506780] usb 2-3-port4: cannot disable (err = -71)
> >
> > You need to do a better job of figuring out why these errors occur.  It
> > is not connected to the resume delay; there must be a different reason.
> > Hint: This is the sort of error you would expect to see if the kernel
> > tried to resume a device while its parent hub was still suspended.
> Once this error shows, the USB port doesn't work until re-plug the cable.
> I have no idea what else I can do to this, do you have any idea that I
> could try?
> Thanks.

Maybe you can collect a usbmon trace showing what happens when the 
error occurs.  There's probably something going on that you aren't 
aware of.

Alan Stern

