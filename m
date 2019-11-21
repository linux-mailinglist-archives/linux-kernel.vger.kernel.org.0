Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4A1F1054D7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 15:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfKUOst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 09:48:49 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46601 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726379AbfKUOss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:48:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574347727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vBwingZgYTW82TS3d0tJl0goOomstXZnkfoRxFBHZCI=;
        b=WdAFI0ORqDnlMqkMvA2jZd58zx/zDb7fhnRddLjQ2naQajGXv8UCSo+YE2bkHZkxMFDucD
        +/MsvDsJJXuC93b0K/+/6QQTXZDaN9ciaKV0DPvBC3783/9U4OBzFHpyWb2Bpio2Jez9Yi
        E4arRkUSST8wDJYV6sZH9lBvvMb49dU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-eeECgZNrMhGjSDmNcxSs8g-1; Thu, 21 Nov 2019 09:48:46 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6B111883524;
        Thu, 21 Nov 2019 14:48:43 +0000 (UTC)
Received: from suzdal.zaitcev.lan (ovpn-117-3.phx2.redhat.com [10.3.117.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B32B60BDA;
        Thu, 21 Nov 2019 14:48:42 +0000 (UTC)
Date:   Thu, 21 Nov 2019 08:48:42 -0600
From:   Pete Zaitcev <zaitcev@redhat.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+56f9673bb4cdcbeb0e92@syzkaller.appspotmail.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <jrdr.linux@gmail.com>, <keescook@chromium.org>,
        <kstewart@linuxfoundation.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>, <tglx@linutronix.de>,
        <viro@zeniv.linux.org.uk>, zaitcev@redhat.com
Subject: Re: possible deadlock in mon_bin_vma_fault
Message-ID: <20191121084842.095edf87@suzdal.zaitcev.lan>
In-Reply-To: <Pine.LNX.4.44L0.1911201343580.1498-100000@iolanthe.rowland.org>
References: <20191120111235.7d306f23@suzdal.zaitcev.lan>
        <Pine.LNX.4.44L0.1911201343580.1498-100000@iolanthe.rowland.org>
Organization: Red Hat, Inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: eeECgZNrMhGjSDmNcxSs8g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2019 13:47:00 -0500 (EST)
Alan Stern <stern@rowland.harvard.edu> wrote:

> > +               if (rp->mmap_active)
> > +                       return -EBUSY;

> Like that, yes, but the test has to be made while fetch_lock is held. =20

Certainly, thanks. I was rushing just to add a postscriptum.

> Incidentally, the comment for fetch_lock says that it protects b_read=20
> and b_out, but mon_bin_vma_fault doesn't use either of those fields.

I probably should change that comment to "protect the integrity of the
circular buffer, such as b_out".

Anyway... If you are looking at it too, what do you think about not using
any locks in mon_bin_vma_fault() at all? Isn't it valid? I think I tried
to be "safe", but it only uses things that are constants unless we're
opening and closing; a process cannot make page faults unless it has
some thing mapped; and that is only possible if device is open and stays
open. Can you find a hole in this reasoning?

-- Pete

