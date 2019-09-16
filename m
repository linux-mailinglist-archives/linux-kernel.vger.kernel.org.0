Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 388AFB4155
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 21:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388598AbfIPTsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 15:48:24 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:51922 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727920AbfIPTsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 15:48:24 -0400
Received: (qmail 6952 invoked by uid 2102); 16 Sep 2019 15:48:23 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Sep 2019 15:48:23 -0400
Date:   Mon, 16 Sep 2019 15:48:23 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Andrey Konovalov <andreyknvl@google.com>,
        syzbot <syzbot+b24d736f18a1541ad550@syzkaller.appspotmail.com>,
        Felipe Balbi <balbi@kernel.org>, <chunfeng.yun@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: INFO: rcu detected stall in dummy_timer
In-Reply-To: <20190916185933.GA1814003@kroah.com>
Message-ID: <Pine.LNX.4.44L0.1909161525340.1489-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2019, Greg Kroah-Hartman wrote:

> On Mon, Sep 16, 2019 at 12:32:52PM -0400, Alan Stern wrote:

> > Retry-limiting is not the sort of thing we want to add to each
> > individual USB class driver.  Maybe it can be handled in the USB core;  
> > I'll try to write some code for it.  Under normal circumstances the
> > issue just doesn't arise, because normal devices aren't malicious.
> 
> I think this issue came up years ago when people realized they could
> "abuse" this through usbfs, but maybe I am mistaken.
> 
> The "do we retry or not" is an old discussion, and one I think we just
> said, "if it errors out, we will not retry as something is wrong with
> the device".

Really?  I bet there are plenty of drivers whose interrupt-URB (or
whatever) completion handlers just log an error message and blindly
resubmit when they get an unexpected kind of error.

>  Corrupted packets don't seem to be something that is even
> noticable in the "real world".  When lots of noise happens on a system
> that might cause this, usually the hub just disconnects the device and
> resets it.

I recall hearing from someone (many years ago -- the technology has
certainly improved since then) about a device that would start getting
errors whenever a noisy fluorescent light near the computer was
switched on.  :-)  But yes, this sort of thing is very uncommon.

So do you recommend editing drivers to prevent them from resubmitting
URBs whenever they get an unrecognized error, such as -EPROTO, -EILSEQ,
or -ETIME?  Then the driver would most likely stop working when one 
of these errors happens.

Alternatively, the USB core could keep track of these three kinds of
bus errors for all endpoints and fail submissions when the error count
gets too high.  That would end up having the same effect -- drivers
would stop working -- but it might be a little more robust against
noise and it wouldn't require editing lots of drivers.

Alan Stern

