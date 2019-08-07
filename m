Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D341285301
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 20:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389343AbfHGSb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 14:31:58 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:43014 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2388428AbfHGSb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 14:31:56 -0400
Received: (qmail 22511 invoked by uid 2102); 7 Aug 2019 14:31:55 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Aug 2019 14:31:55 -0400
Date:   Wed, 7 Aug 2019 14:31:55 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     syzbot <syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <oneukum@suse.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in device_release_driver_internal
In-Reply-To: <000000000000f365b6058f8b07ca@google.com>
Message-ID: <Pine.LNX.4.44L0.1908071431050.1514-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2019, syzbot wrote:

> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger  
> crash:
> 
> Reported-and-tested-by:  
> syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         6a3599ce usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git
> kernel config:  https://syzkaller.appspot.com/x/.config?x=700ca426ab83faae
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=132eec8c600000
> 
> Note: testing is done by a robot and is best-effort only.

Andrey, is there any way to get the console output from this test?

Alan Stern

