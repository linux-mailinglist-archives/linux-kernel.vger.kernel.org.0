Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1146101577
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 06:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbfKSFob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 00:44:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730000AbfKSFo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:44:27 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B201D21939;
        Tue, 19 Nov 2019 05:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142267;
        bh=UwBJZoz9GrgalpPxw28oDcIL0daCumvlEcO2T7STbEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0FVUZTd4avgbrAMuNCS1RvWbmrPLVm430fPw6jrJTMwXh7Mhzvx3lFj6EYWkNOFV3
         EhJTOw1z7fSvtDvvHvlfRIZFvJSX94aTuKrTkuphj/KsKCdi3XXzGHTZe+tZQmrO1l
         g908XS9+zNWTs1gmM2q+w+zXmTAbmRrFZEjg2DC8=
Date:   Mon, 18 Nov 2019 21:44:25 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+787bcbef9b5fec61944b@syzkaller.appspotmail.com>
Cc:     alexander.levin@microsoft.com, davem@davemloft.net,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        paulmck@linux.ibm.com, syzkaller-bugs@googlegroups.com,
        valdis.kletnieks@vt.edu
Subject: Re: WARNING in bdev_read
Message-ID: <20191119054425.GO163020@sol.localdomain>
References: <00000000000073309e05951e2dc1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00000000000073309e05951e2dc1@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 10:02:07AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    bc88f85c kthread: make __kthread_queue_delayed_work static
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14e25608e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e0ac4d9b35046343
> dashboard link: https://syzkaller.appspot.com/bug?extid=787bcbef9b5fec61944b
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=159fd353600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e82173600000
> 
> The bug was bisected to:
> 
> commit c48c9f7ff32b8b3965a08e40eb6763682d905b5d
> Author: Valdis Klētnieks <valdis.kletnieks@vt.edu>
> Date:   Wed Aug 28 16:08:17 2019 +0000
> 
>     staging: exfat: add exfat filesystem code to staging

This bisection looks correct.

On a related topic: it seems the exfat filesystem is missing a mailing list.

- Eric
