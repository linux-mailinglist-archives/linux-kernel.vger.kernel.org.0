Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC8C1056D9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 17:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfKUQUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 11:20:21 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:43166 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726967AbfKUQUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:20:21 -0500
Received: (qmail 2054 invoked by uid 2102); 21 Nov 2019 11:20:20 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Nov 2019 11:20:20 -0500
Date:   Thu, 21 Nov 2019 11:20:20 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Pete Zaitcev <zaitcev@redhat.com>
cc:     syzbot <syzbot+56f9673bb4cdcbeb0e92@syzkaller.appspotmail.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <jrdr.linux@gmail.com>, <keescook@chromium.org>,
        <kstewart@linuxfoundation.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>, <tglx@linutronix.de>,
        <viro@zeniv.linux.org.uk>
Subject: Re: possible deadlock in mon_bin_vma_fault
In-Reply-To: <20191121084842.095edf87@suzdal.zaitcev.lan>
Message-ID: <Pine.LNX.4.44L0.1911211118450.1553-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019, Pete Zaitcev wrote:

> Anyway... If you are looking at it too, what do you think about not using
> any locks in mon_bin_vma_fault() at all? Isn't it valid? I think I tried
> to be "safe", but it only uses things that are constants unless we're
> opening and closing; a process cannot make page faults unless it has
> some thing mapped; and that is only possible if device is open and stays
> open. Can you find a hole in this reasoning?

I think you're right.  But one thing concerns me: What happens if the 
same buffer is mapped by more than one process?  Do you allow that?  I 
haven't read the code in enough detail to see.

Alan Stern

