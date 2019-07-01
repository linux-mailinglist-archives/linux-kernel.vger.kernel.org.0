Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1A8C51973
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 19:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732385AbfFXRYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 13:24:16 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:57468 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726941AbfFXRYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 13:24:16 -0400
Received: (qmail 6027 invoked by uid 2102); 24 Jun 2019 13:24:15 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Jun 2019 13:24:15 -0400
Date:   Mon, 24 Jun 2019 13:24:15 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Suwan Kim <suwan.kim027@gmail.com>
cc:     shuah@kernel.org, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] usbip: Implement SG support to vhci
In-Reply-To: <20190624145852.GC7547@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.1906241322140.1609-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2019, Suwan Kim wrote:

> > > +	hcd->self.sg_tablesize = ~0;
> > > +	hcd->self.no_sg_constraint = 1;
> > 
> > You probably shouldn't do this, for two reasons.  First, sg_tablesize
> > of the server's HCD may be smaller than ~0.  If the client's value is
> > larger than the server's, a transfer could be accepted on the client
> > but then fail on the server because the SG list was too big.

On the other hand, I don't know of any examples where an HCD has 
sg_tablesize set to anything other than 0 or ~0.  vhci-hcd might end up 
being the only one.

> > Also, you may want to restrict the size of SG transfers even further,
> > so that you don't have to allocate a tremendous amount of memory all at
> > once on the server.  An SG transfer can be quite large.  I don't know 
> > what a reasonable limit would be -- 16 perhaps?
> 
> Is there any reason why you think that 16 is ok? Or Can I set this
> value as the smallest value of all HC? I think that sg_tablesize
> cannot be a variable value because vhci interacts with different
> machines and all machines has different sg_tablesize value.

I didn't have any good reason for picking 16.  Using the smallest value 
of all the HCDs seems like a good idea.

Alan Stern

