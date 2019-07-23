Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12CC2716D2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 13:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389291AbfGWLSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 07:18:50 -0400
Received: from smtprelay0108.hostedemail.com ([216.40.44.108]:54048 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726709AbfGWLSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:18:49 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 8194F100E86C1;
        Tue, 23 Jul 2019 11:18:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:152:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2691:2692:2892:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4605:5007:6117:6119:7809:9010:10004:10400:10848:11232:11658:11914:12043:12296:12297:12555:12663:12681:12740:12895:12986:13019:13161:13229:13618:13894:14096:14097:14181:14659:14721:21063:21080:21451:21627:21740:30046:30054:30060:30064:30070:30075:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: rail43_69daedcfa5b08
X-Filterd-Recvd-Size: 4704
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue, 23 Jul 2019 11:18:47 +0000 (UTC)
Message-ID: <8016ee9b5ee38fae0c782420ca449f863270cca9.camel@perches.com>
Subject: Re: get_maintainers.pl subsystem output
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Duda, Sebastian" <sebastian.duda@fau.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Wolfgang Mauerer <wolfgang.mauerer@oth-regensburg.de>
Date:   Tue, 23 Jul 2019 04:18:45 -0700
In-Reply-To: <CAKXUXMwfd133rv0bMert-BBftaqxxr_93dUHpaUjEwE8RE_wwA@mail.gmail.com>
References: <2c912379f96f502080bfcc79884cdc35@fau.de>
         <5a468c6cbba8ceeed6bbeb8d19ca2d46cb749a47.camel@perches.com>
         <2835dfa18922905ffabafb11fca7e1d2@fau.de>
         <CAKXUXMwfd133rv0bMert-BBftaqxxr_93dUHpaUjEwE8RE_wwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-23 at 10:42 +0200, Lukas Bulwahn wrote:
> On Tue, Jul 23, 2019 at 9:30 AM Duda, Sebastian <sebastian.duda@fau.de> wrote:
> > when analyzing the patch
> > `<20150128012747.824898918@linuxfoundation.org>` [1] with
> > `get_maintainers.pl --subsystem --status --separator , /tmp/patch`,
> > there is the following output:
> > 
> >      Chris Mason <clm@fb.com> (maintainer:BTRFS FILE SYSTEM),Josef Bacik
> > <jbacik@fb.com> (maintainer:BTRFS FILE SYSTEM),David Sterba
> > <dsterba@suse.cz> (maintainer:BTRFS FILE SYSTEM),Alexander Viro
> > <viro@zeniv.linux.org.uk> (maintainer:FILESYSTEMS (VFS and
> > infrastructure)),"Theodore Ts'o" <tytso@mit.edu> (maintainer:EXT4 FILE
> > SYSTEM),Andreas Dilger <adilger.kernel@dilger.ca> (maintainer:EXT4 FILE
> > SYSTEM),Jaegeuk Kim <jaegeuk@kernel.org> (maintainer:F2FS FILE
> > SYSTEM),Changman Lee <cm224.lee@samsung.com> (maintainer:F2FS FILE
> > SYSTEM),Miklos Szeredi <miklos@szeredi.hu> (maintainer:FUSE: FILESYSTEM
> > IN USERSPACE),Steven Whitehouse <swhiteho@redhat.com> (supporter:GFS2
> > FILE SYSTEM),Anton Altaparmakov <anton@tuxera.com> (supporter:NTFS
> > FILESYSTEM),Hugh Dickins <hughd@google.com> (maintainer:TMPFS (SHMEM
> > FILESYSTEM)),linux-btrfs@vger.kernel.org (open list:BTRFS FILE
> > SYSTEM),linux-kernel@vger.kernel.org (open
> > list),linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
> > infrastructure)),linux-ext4@vger.kernel.org (open list:EXT4 FILE
> > SYSTEM),linux-f2fs-devel@lists.sourceforge.net (open list:F2FS FILE
> > SYSTEM),fuse-devel@lists.sourceforge.net (open list:FUSE: FILESYSTEM IN
> > USERSPACE),cluster-devel@redhat.com (open list:GFS2 FILE
> > SYSTEM),linux-ntfs-dev@lists.sourceforge.net (open list:NTFS
> > FILESYSTEM),linux-mm@kvack.org (open list:MEMORY MANAGEMENT)
> >      Maintained,Buried alive in reporters,Supported
> >      BTRFS FILE SYSTEM,THE REST,FILESYSTEMS (VFS and infrastructure),EXT4
> > FILE SYSTEM,F2FS FILE SYSTEM,FUSE: FILESYSTEM IN USERSPACE,GFS2 FILE
> > SYSTEM,NTFS FILESYSTEM,MEMORY MANAGEMENT,TMPFS (SHMEM FILESYSTEM)
> > 
> > How can I parse this output automatically? or how can I generate a
> > parsable output?
[]
> > I need the tuples of subsystems and status:
> > (THE REST, Buried alive in reporters)
> > (TMPFS, Maintained)
> > (BTRFS FILE SYSTEM, Maintained)
> > …
> > (GFS2 FILE SYSTEM, Supported)
> > 
> > I'm not aware how to reliably assign the statuses to the subsystems.

Again, run the script using the individual files
contained in a patch
instead of the entire patch.

I again suggest using gnu parallel.

> Joe, I hope this example makes more clear what and how Sebastian would
> actually like to have the information from the MAINTAINERS file
> presented for our use case. Currently, we would consider
> get_maintainer.pl to be the proper place for such a feature in the
> upstream development.

I believe I understand how you want to use
the get_maintainer script output.

> Joe, would you support and would you accept if we extend
> get_maintainer.pl to provide output of the status in such a way that
> the status output can be clearly mapped to the subsystem?

Not really, no.  I don't see much value in your
request to others.  It seems you are doing some
academic work rather than actually using it for
sending patches.

You are of course welcome to extexd the script
in whatever manner you need for your own use,
but even here, I don't believe you need to do
anything to the script but change how you use it.



