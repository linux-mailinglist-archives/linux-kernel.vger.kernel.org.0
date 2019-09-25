Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E03CBDFAD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 16:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407075AbfIYOKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 10:10:15 -0400
Received: from netrider.rowland.org ([192.131.102.5]:44881 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730549AbfIYOKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 10:10:15 -0400
Received: (qmail 15033 invoked by uid 500); 25 Sep 2019 10:10:14 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Sep 2019 10:10:14 -0400
Date:   Wed, 25 Sep 2019 10:10:14 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     syzbot <syzbot+e74a998ca8f1df9cc332@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <rafael@kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in pvr2_i2c_core_done
In-Reply-To: <000000000000c2ee6a059360376e@google.com>
Message-ID: <Pine.LNX.4.44L0.1909251006040.14432-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2019, syzbot wrote:

> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    d9e63adc usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=16b5fcd5600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f4fa60e981ee8e6a
> dashboard link: https://syzkaller.appspot.com/bug?extid=e74a998ca8f1df9cc332
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ec07b1600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ff0871600000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+e74a998ca8f1df9cc332@syzkaller.appspotmail.com
> 
> pvrusb2: Device being rendered inoperable
> cx25840 0-0044: Unable to detect h/w, assuming cx23887
> cx25840 0-0044: cx23887 A/V decoder found @ 0x88 (pvrusb2_a)
> pvrusb2: Attached sub-driver cx25840
> pvrusb2: ***WARNING*** pvrusb2 device hardware appears to be jammed and I  
> can't clear it.
> pvrusb2: You might need to power cycle the pvrusb2 device in order to  
> recover.
> ------------[ cut here ]------------
> sysfs group 'power' not found for kobject 'i2c-0'
> WARNING: CPU: 0 PID: 102 at fs/sysfs/group.c:278 sysfs_remove_group  
> fs/sysfs/group.c:278 [inline]
> WARNING: CPU: 0 PID: 102 at fs/sysfs/group.c:278  
> sysfs_remove_group+0x155/0x1b0 fs/sysfs/group.c:269

I have seen a lot of error messages like this one (i.e., "group 'power'
not found for kobject"), in runs that involved fuzzing a completely
different USB driver.  Initial testing failed to find a cause.

This leads me to wonder whether the problem might lie somewhere else 
entirely.  A bug in some core kernel code?  Memory corruption?

Alan Stern

