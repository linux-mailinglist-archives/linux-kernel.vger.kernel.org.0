Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41879F9684
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 18:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfKLRE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 12:04:59 -0500
Received: from ms.lwn.net ([45.79.88.28]:42024 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfKLRE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:04:58 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BFF415A0;
        Tue, 12 Nov 2019 17:04:56 +0000 (UTC)
Date:   Tue, 12 Nov 2019 10:04:54 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jaskaran Singh <jaskaransingh7654321@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        christian@brauner.io, neilb@suse.com, willy@infradead.org,
        tobin@kernel.org, stefanha@redhat.com, hofrat@osadl.org,
        gregkh@linuxfoundation.org, jeffrey.t.kirsher@intel.com,
        linux-doc@vger.kernel.org, skhan@linuxfoundation.org,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Subject: Re: [PATCH][RESEND] docs: filesystems: sysfs: convert sysfs.txt to
 reST
Message-ID: <20191112100454.3b41f3af@lwn.net>
In-Reply-To: <cd9dbb3704d0a39a161c3e4df8fcd9f84bbc5b03.camel@gmail.com>
References: <20191105071846.GA28727@localhost.localdomain>
        <20191107120455.29a4c155@lwn.net>
        <cd9dbb3704d0a39a161c3e4df8fcd9f84bbc5b03.camel@gmail.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Nov 2019 18:36:16 +0530
Jaskaran Singh <jaskaransingh7654321@gmail.com> wrote:

> > At a bare minimum, an effort like this needs to put a big flashing
> > warning
> > at the top of the file.  But it would be soooooo much better to
> > actually
> > update the content as well.
> > 
> > The best way to do that would be to annotate the source with proper
> > kerneldoc comments, then pull them into the documentation rather than
> > repeating the information here.  Is there any chance you might be up
> > for
> > taking on a task like this?
> >   
> 
> 
> Sure! I'll send the documentation patch(es) followed by a v2 for this
> patch.

Great.  As an alternative, if you like, redo the current patch with the
other suggested fixes and a "this is obsolete" warning at the top.  Then,
after the subsequent improvements land, that warning can eventually be
removed again.

Thanks,

jon
