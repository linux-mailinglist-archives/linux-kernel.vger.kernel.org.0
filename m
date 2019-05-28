Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B59AB2C8AC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 16:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfE1OZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 10:25:15 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:38318 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727192AbfE1OZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 10:25:13 -0400
Received: (qmail 1867 invoked by uid 2102); 28 May 2019 10:25:12 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 May 2019 10:25:12 -0400
Date:   Tue, 28 May 2019 10:25:12 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Oliver Neukum <oneukum@suse.com>
cc:     Jaewon Kim <jaewon31.kim@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, <linux-mm@kvack.org>,
        <gregkh@linuxfoundation.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>,
        <m.szyprowski@samsung.com>, <ytk.lee@samsung.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: Re: [RFC PATCH] usb: host: xhci: allow __GFP_FS in dma allocation
In-Reply-To: <1559046886.13873.2.camel@suse.com>
Message-ID: <Pine.LNX.4.44L0.1905281021120.1564-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 May 2019, Oliver Neukum wrote:

> Am Donnerstag, den 23.05.2019, 10:01 -0400 schrieb Alan Stern:
> > On Wed, 22 May 2019, Oliver Neukum wrote:
> > 
> > > On Mi, 2019-05-22 at 10:56 -0400, Alan Stern wrote:
> > > > On Wed, 22 May 2019, Oliver Neukum wrote:
> > > > 
> > > > > I agree with the problem, but I fail to see why this issue would be
> > > > > specific to USB. Shouldn't this be done in the device core layer?
> > > > 
> > > > Only for drivers that are on the block-device writeback path.  The 
> > > > device core doesn't know which drivers these are.
> > > 
> > > Neither does USB know. It is very hard to predict or even tell which
> > > devices are block device drivers. I think we must assume that
> > > any device may be affected.
> > 
> > All right.  Would you like to submit a patch?
> 
> Do you like this one?

Hmmm.  I might be inclined to move the start of the I/O-protected
region a little earlier.  For example, the first
blocking_notifier_call_chain() might result in some memory allocations.

The end is okay; once bus_remove_device() has returned the driver will 
be completely unbound, so there shouldn't be any pending I/O through 
the device.

Alan Stern

