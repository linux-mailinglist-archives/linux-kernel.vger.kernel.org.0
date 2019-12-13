Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D05FB11EB42
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 20:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfLMTvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 14:51:35 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:60486 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728696AbfLMTve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 14:51:34 -0500
Received: (qmail 4151 invoked by uid 2102); 13 Dec 2019 14:51:33 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Dec 2019 14:51:33 -0500
Date:   Fri, 13 Dec 2019 14:51:33 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrey Konovalov <andreyknvl@google.com>
cc:     syzbot <syzbot+7fa38a608b1075dfd634@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>, <mans@mansr.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: Re: general protection fault in usb_set_interface
In-Reply-To: <CAAeHK+xSWEFUA7DQyhm90uiwggx60gYa8q7QqzOWp7DX_xWSWg@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1912131448080.1332-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2019, Andrey Konovalov wrote:

> > > Let's retry here:
> >
> > > #syz test: https://github.com/google/kasan.git f0df5c1b
> >
> > This bug is already marked as fixed. No point in testing.
> >
> 
> Hm, that explains some of the weirdness. It doesn't explain though
> neither why the patch was actually tested when Alan requested it nor
> why syzbot sent no reply.

In the meantime, is there any way to get syzbot to test the new patch
with the old reproducer?  Perhaps tell it to re-open this bug?

Alan Stern

