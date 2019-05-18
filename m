Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6D6223D0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2019 17:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbfERPUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 May 2019 11:20:48 -0400
Received: from netrider.rowland.org ([192.131.102.5]:38683 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728516AbfERPUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 11:20:48 -0400
Received: (qmail 8577 invoked by uid 500); 18 May 2019 11:20:47 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 May 2019 11:20:47 -0400
Date:   Sat, 18 May 2019 11:20:47 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     "Eric W. Biederman" <ebiederm@xmission.com>
cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] signal/usb: Replace kill_pid_info_as_cred with
 kill_pid_usb_asyncio
In-Reply-To: <87y334v8x1.fsf@xmission.com>
Message-ID: <Pine.LNX.4.44L0.1905181116330.7855-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2019, Eric W. Biederman wrote:

> Wow I got a little distracted but now I am back to this.
> 
> Using your test program I was able to test the basics of this.
> 
> I found one bug in my patch where I was missing a memset.  So I have
> corrected that, and reorganized the patch a little bit.
> 
> I have not figured out how to trigger a usb disconnect so I have not
> tested that.

Heh.  Assuming the device file you tell the test program to use 
corresponds to an actual USB device, you can trigger a disconnect by 
literally unplugging the USB cable.  (Add a 10-second delay to the 
program to give yourself enough time.)

> The big thing I have not been able to test is running a 64bit big-endian
> kernel with a 32bit user space.  My modified version of your test
> program should report "Bad" without my patch, and should report "Good"
> with it.
> 
> Is there any chance you can test that configuration?  I could not figure
> out how to get a 64bit big-endian system running in qemu, and I don't
> have the necessary hardware so I was not able to test that at all.  As
> that is the actual bug I am still hoping someone can test it.

Unfortunately, I don't have any big-endian systems either.

Alan Stern

