Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2A367AEA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2019 17:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfGMPXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jul 2019 11:23:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbfGMPXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 11:23:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC6B120838;
        Sat, 13 Jul 2019 15:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563031411;
        bh=3yUUiXWyEH3+u7g2EzA96kovIvW9lH64zCa2zJ1DuwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RICAk2OC01mAfI1oKPWZ2ELtKibQfP00fYE6gye1Ni3N8yTpzUeqCc/GrkVr37OEg
         T4qoYBI2/mHgEC2F5KGBcIw+6R/TQgAK6vGHV9yFqgI3BGXwfPogNbUeBg2D+Z2zvR
         zuAadUd3VZObKMpODfZLvFwDnz+KytECD610xLMw=
Date:   Sat, 13 Jul 2019 17:23:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT PULL] Driver core patches for 5.3-rc1
Message-ID: <20190713152328.GC10284@kroah.com>
References: <20190712073623.GA16253@kroah.com>
 <20190712074023.GD16253@kroah.com>
 <20190712210922.GA102096@archlinux-threadripper>
 <CAHk-=wh0XHkcLYh+pMPJrf8WmD6zOgXfq7HuLi7gmzb8aPEOvQ@mail.gmail.com>
 <CAHk-=wimmESHGRKNnZV0TfNStqNrruxzXaT_S=8g6K4G84p54w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wimmESHGRKNnZV0TfNStqNrruxzXaT_S=8g6K4G84p54w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 02:43:28PM -0700, Linus Torvalds wrote:
> On Fri, Jul 12, 2019 at 2:37 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > My bad. Will apply the fix properly.
> 
> Ok, _now_ your fix is finally in my tree. D'oh.

Thanks for fixing this up, sorry for the pain, this was a tough merge
for some reason...

greg k-h
