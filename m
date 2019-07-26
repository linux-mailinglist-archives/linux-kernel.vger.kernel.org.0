Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C36975BCA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 02:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfGZAAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 20:00:41 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57606 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfGZAAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 20:00:41 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hqney-0004fd-VN; Fri, 26 Jul 2019 00:00:33 +0000
Date:   Fri, 26 Jul 2019 01:00:32 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Cyril Hrubis <chrubis@suse.cz>,
        kernel test robot <rong.a.chen@intel.com>, LKP <lkp@01.org>,
        LKML <linux-kernel@vger.kernel.org>, ltp@lists.linux.it
Subject: Re: [LTP] 56cbb429d9: ltp.fs_fill.fail
Message-ID: <20190726000032.GK1131@ZenIV.linux.org.uk>
References: <20190725110944.GA22106@shao2-debian>
 <20190725132617.GA23135@rei.lan>
 <CAHk-=wg+yRjY_AUrjbgrN59OeGAWMF_q=-Dqf2cYtVzoY01j7Q@mail.gmail.com>
 <20190725180428.GH1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725180428.GH1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 07:04:28PM +0100, Al Viro wrote:
> On Thu, Jul 25, 2019 at 09:32:13AM -0700, Linus Torvalds wrote:
> > On Thu, Jul 25, 2019 at 6:26 AM Cyril Hrubis <chrubis@suse.cz> wrote:
> > >
> > > This looks like mkfs.vfat got EBUSY after the loop device was
> > > succesfully umounted.
> > 
> > Hmm. Smells like the RCU-delaying got triggered again.
> > 
> > We have that "synchronize_rcu_expedited()" in namespace_unlock(),
> > which is so that everything should be done by the time we return to
> > user space.
> > 
> > Al, maybe that RCU synchronization should be after the mntput()s?
> 
> There are several interesting issues in there, but synchronize_rcu()
> should be between zeroing ->mnt_ns and dropping the final refs.
> I'm digging through that crap right now; at least one bug is dealt
> with by #fixes, but there's more, unfortunately.

No, it's not synchronize_rcu().  It's a bug dealt with in vfs.git #fixes,
triggering the struct mount leak in mount_subtree(), which is used
by btrfs.  Immediately prior to vfat in their list...

(oh, and AFAICS "more" in the above had been a mismerge in -next, so
it might really be all there is to it)

Folks, see if vfs.git #fixes solves that one.
