Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A029318958
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 13:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfEIL4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 07:56:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfEIL4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 07:56:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E09EC2089E;
        Thu,  9 May 2019 11:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557402994;
        bh=l84tvoRtTOo6xxBJp+XZy4HfEDG3Iwma6GjVprRvsck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ia6sACNwAQkeTFaSEDuCcnHBO0z2PRGuz+rHzWPvF0NEzU4vHKHVqJK2KLiBXbXzr
         STfXZx5ubInSpGDBkjWuFtcVXg7n54oMyGa7PM8cwm57bziWwyqtO9JDiLc4k1h7OH
         73xE4erhit9psiRlojWnkZg0JstfgxFZDR8zO9Q8=
Date:   Thu, 9 May 2019 13:56:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     syzbot <syzbot+c1b25598aa60dcd47e78@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: WARNING: ath10k USB support is incomplete, don't expect anything
 to work!
Message-ID: <20190509115631.GB18400@kroah.com>
References: <000000000000a3ca70058872de7c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a3ca70058872de7c@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 04:37:06AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    43151d6c usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=178c8394a00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4183eeef650d1234
> dashboard link: https://syzkaller.appspot.com/bug?extid=c1b25598aa60dcd47e78
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c22222a00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ddce02a00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c1b25598aa60dcd47e78@syzkaller.appspotmail.com
> 
> usb 1-1: new low-speed USB device number 2 using dummy_hcd
> usb 1-1: config 0 has an invalid interface number: 93 but max is 0
> usb 1-1: config 0 has no interface number 0
> usb 1-1: New USB device found, idVendor=13b1, idProduct=0042,
> bcdDevice=f9.d4
> usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> usb 1-1: config 0 descriptor??
> usb 1-1: WARNING: ath10k USB support is incomplete, don't expect anything to
> work!

Looks like we just need to change the printk message string here.
