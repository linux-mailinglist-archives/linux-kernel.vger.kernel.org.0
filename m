Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD5C0108677
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 03:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKYCMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Nov 2019 21:12:15 -0500
Received: from netrider.rowland.org ([192.131.102.5]:34017 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726855AbfKYCMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 21:12:14 -0500
Received: (qmail 14102 invoked by uid 500); 24 Nov 2019 21:12:13 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Nov 2019 21:12:13 -0500
Date:   Sun, 24 Nov 2019 21:12:13 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Pete Zaitcev <zaitcev@redhat.com>
cc:     andreyknvl@google.com, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <jrdr.linux@gmail.com>,
        <keescook@chromium.org>, <kstewart@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <tglx@linutronix.de>, <viro@zeniv.linux.org.uk>
Subject: Re: possible deadlock in mon_bin_vma_fault
In-Reply-To: <20191124181047.7cb9e8fb@suzdal.zaitcev.lan>
Message-ID: <Pine.LNX.4.44L0.1911242110160.14008-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Nov 2019, Pete Zaitcev wrote:

> On Sun, 24 Nov 2019 15:24:00 -0800
> syzbot <syzbot+56f9673bb4cdcbeb0e92@syzkaller.appspotmail.com> wrote:
> 
> > syzbot has tested the proposed patch and the reproducer did not trigger  
> > crash:
> 
> Okay. Alan, what is the most appropriate tree for me to submit now?
> Does Greg have one?
> 
> Do you want Reviewed-by or something?

Send it to Greg.  Be sure to add a Fixes: line referencing the commit 
that syzbot found, and add a CC: <stable@vger.kernel.org> line.  You 
can also add:

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern

