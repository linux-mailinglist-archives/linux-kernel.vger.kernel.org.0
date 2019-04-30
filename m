Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08512FEDB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 19:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfD3R3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 13:29:36 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:36016 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726017AbfD3R3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 13:29:36 -0400
Received: (qmail 5374 invoked by uid 2102); 30 Apr 2019 13:29:35 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Apr 2019 13:29:35 -0400
Date:   Tue, 30 Apr 2019 13:29:35 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Bin Liu <b-liu@ti.com>
cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        <gregkh@linuxfoundation.org>, <matwey.kornilov@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 6/6] usb: musb: Decrease URB starting latency in
 musb_advance_schedule()
In-Reply-To: <20190430153118.GI20993@uda0271908>
Message-ID: <Pine.LNX.4.44L0.1904301323050.1465-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Apr 2019, Bin Liu wrote:

> Hi Greg and all devs,
> 
> On Wed, Apr 03, 2019 at 09:53:10PM +0300, Matwey V. Kornilov wrote:
> > Previously, the algorithm was the following:
> > 
> >  1. giveback current URB
> >  2. if current qh is not empty
> >     then start next URB
> >  3. if current qh is empty
> >     then dispose the qh, find next qh if any, and start URB.
> > 
> > It may take a while to run urb->callback inside URB giveback which is
> > run synchronously in musb. In order to improve the latency we rearrange
> > the function behaviour for the case when qh is not empty: next URB is
> > started before URB giveback. When qh is empty then the behaviour is
> > intentionally kept in order not to break existing inter qh scheduling:
> > URB giveback could potentionally enqueue other URB to the empty qh
> > preventing it from being disposed.
> 
> This patch changes the sequence of urb giveback in musb.
> 
> 	before				after
> 	------				-----
> 1. giveback current urb			1. start next urb if qh != empty
> 2. start next urb if qh != empty	2. giveback current urb
> 
> I see there is a potential that the urb giveback could be out of order,
> for example, if urb giveback in BH and the next urb finishes before BH
> runs.
> 
> If this potential is possible, is it a problem for any class driver?

I don't know of any specific examples where this would be a problem.  
But it definitely goes against the guarantee that except for unlinks, 
URBs for each endpoint are always given back in order.

There's also a guarantee that when an URB has an error status, it
causes the endpoint queue to stop.  This is necessary so that the class
driver can cancel any outstanding URBs before they run and cause even
more trouble.  Your brief outline above doesn't mention this.

On the other hand, it shouldn't be hard to maintain the order even
here.  For example, you could have a FIFO list of URBs waiting to be
given back, and the BH could always give back the URB at the front of
the list.

Alan Stern

