Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9508E15C0D2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 15:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgBMO7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 09:59:43 -0500
Received: from ms.lwn.net ([45.79.88.28]:45870 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbgBMO7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 09:59:42 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3A41877D;
        Thu, 13 Feb 2020 14:59:42 +0000 (UTC)
Date:   Thu, 13 Feb 2020 07:59:41 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] linux/pipe_fs_i.h: fix kernel-doc warnings after @wait
 was split
Message-ID: <20200213075941.72d6944e@lwn.net>
In-Reply-To: <CAHk-=wjU6YdzhdhevAJ8od96RWvvqtV+h3TWvJ3QcSNrQJbMMg@mail.gmail.com>
References: <0956ab21-9b9a-4d1e-fe43-b853d1602781@infradead.org>
        <CAHk-=wjU6YdzhdhevAJ8od96RWvvqtV+h3TWvJ3QcSNrQJbMMg@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020 11:57:39 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> I've considered adding some doc building to my basic tests, but it is
> (a) somewhat slow and (b) has always been very noisy.
> 
> And that (b) is why I really don't do it. The reason I require the
> basic build to be warning-free is that because that way any new
> warnings stand out. But that's just not the case for docs.
> 
> What do you use to notice new errors? Or is there some trick to make
> it less noisy?

I save the output and do a diff ... not the greatest workflow.

The docs-build warnings are a huge problem, which is why getting rid of
them is at the top of my priority list.  It's a fairly lonely game of
whack-a-mole at the moment, though.

Once we're there, it should be pretty easy to add a quick check that
doesn't actually build the docs and, thus, isn't so painfully slow.  But
that won't really be useful until we can get the build clean.

jon
