Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 099FC27EF9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 16:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbfEWOBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 10:01:55 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:33916 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730323AbfEWOBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 10:01:55 -0400
Received: (qmail 1600 invoked by uid 2102); 23 May 2019 10:01:54 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 May 2019 10:01:54 -0400
Date:   Thu, 23 May 2019 10:01:54 -0400 (EDT)
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
In-Reply-To: <1558558075.2470.2.camel@suse.com>
Message-ID: <Pine.LNX.4.44L0.1905231001100.1553-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019, Oliver Neukum wrote:

> On Mi, 2019-05-22 at 10:56 -0400, Alan Stern wrote:
> > On Wed, 22 May 2019, Oliver Neukum wrote:
> > 
> > > I agree with the problem, but I fail to see why this issue would be
> > > specific to USB. Shouldn't this be done in the device core layer?
> > 
> > Only for drivers that are on the block-device writeback path.  The 
> > device core doesn't know which drivers these are.
> 
> Neither does USB know. It is very hard to predict or even tell which
> devices are block device drivers. I think we must assume that
> any device may be affected.

All right.  Would you like to submit a patch?

Alan Stern

