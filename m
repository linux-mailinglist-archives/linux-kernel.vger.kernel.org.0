Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69C2A175634
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 09:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbgCBIn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 03:43:56 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42085 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgCBInz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:43:55 -0500
Received: by mail-io1-f67.google.com with SMTP id q128so2523446iof.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 00:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ka6ngPWkB4uI/pE1Q1K94PHmSULgTaZNjlFBTfefkw4=;
        b=akz1HiDkzR/7aKhVBglfubu1x0knfiykucl/aRzUbwrNlqM8z3WDiA3Iil6Z9OI56T
         ChR/IQN1e7+3dN+PzJK9dYmO7ShfXhI/evyAyzUN1+AqipbTrdEURd4rjQfSGax9hS5M
         TdtlzKpbJ9nHP2YuSvOD/07ec4ijpwDRMIsNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ka6ngPWkB4uI/pE1Q1K94PHmSULgTaZNjlFBTfefkw4=;
        b=nkuHDuVTywI2qhuQnbuDFM5CahGzxoUOfWG/l1jrb09sIpKy5Hyy0xgl/qn04tMWv5
         +rMx5liO1MamlzgC1ZXNDo/8nJSUTsKTHvgqrYbHdrkN/q2fYCNNnlL6lvOIXDyYhrBE
         ecJIRO5ekWL60+0le3Va/kZYRISRP2SdtmISGw/24RQXBUHYJ+ihEMwQ8lj7kjX4jzti
         /eEt5Ja1+FXccXKMKAO9jLD4E1AMVpZ0p+FMb6dmiS9+C98OUm0rU5ZX/ud9sCEhPU5I
         VfsHoP2AEv31osRtigqhAv/6Aymw1uoaP2TEoTX9UGiBRyZ3//GACCsjf9SG9vZH8jnP
         zqJg==
X-Gm-Message-State: APjAAAUHuw2Pm2+WwTk//zMcKgRL/RKfdEdRoqWjsK15JW5ITYQvteox
        BgwZjl2AgPKUvXB+tkwH8CoQ2vb/RsHDXIxmZYxRbg==
X-Google-Smtp-Source: APXvYqw1ZD3GqI+wwXF1yHR/xgqidz3T6IX49RJ/ZKk0JVp+iUAGPsw+BghGio8C/Q5imdQEykUPaa6oLyfcghCbfaU=
X-Received: by 2002:a02:5b8a:: with SMTP id g132mr12738776jab.78.1583138634949;
 Mon, 02 Mar 2020 00:43:54 -0800 (PST)
MIME-Version: 1.0
References: <CAOssrKfaxnHswrKejedFzmYTbYivJ++cPes4c91+BJDfgH4xJA@mail.gmail.com>
 <1c8db4e2b707f958316941d8edd2073ee7e7b22c.camel@themaw.net>
 <CAJfpegtRoXnPm5_sMYPL2L6FCZU52Tn8wk7NcW-dm4_2x=dD3Q@mail.gmail.com>
 <3e656465c427487e4ea14151b77d391d52cd6bad.camel@themaw.net>
 <CAJfpegu5xLcR=QbAOnUrL49QTem6X6ok7nPU+kLFnNHdPXSh1A@mail.gmail.com>
 <20200227151421.3u74ijhqt6ekbiss@ws.net.home> <ba2b44cc1382c62be3ac896a5476c8e1dc7c0230.camel@themaw.net>
 <CAJfpeguXPmw+PfZJFOscGLm0oe7dUQY4CYXazx9=x020Fbe86A@mail.gmail.com>
 <20200228122712.GA3013026@kroah.com> <CAJfpegsGgjnyZiB+ionfnnk+_e+5oaC-5nmGq+mLxWs1RcwsPw@mail.gmail.com>
 <20200228171504.GK23230@ZenIV.linux.org.uk>
In-Reply-To: <20200228171504.GK23230@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 2 Mar 2020 09:43:43 +0100
Message-ID: <CAJfpegviKdx9LWRQ_nLc7q67CvYxbpAFct6ukt6QHyiNY0faYw@mail.gmail.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Kent <raven@themaw.net>, Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Lennart Poettering <lennart@poettering.net>,
        =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>,
        util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 6:15 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Feb 28, 2020 at 05:24:23PM +0100, Miklos Szeredi wrote:
> > On Fri, Feb 28, 2020 at 1:27 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >
> > > > Superblocks and mounts could get enumerated by a unique identifier.
> > > > mnt_id seems to be good for mounts, s_dev may or may not be good for
> > > > superblock, but  s_id (as introduced in this patchset) could be used
> > > > instead.
> > >
> > > So what would the sysfs tree look like with this?
> >
> > For a start something like this:
> >
> > mounts/$MOUNT_ID/
> >   parent -> ../$PARENT_ID
> >   super -> ../../supers/$SUPER_ID
> >   root: path from mount root to fs root (could be optional as usually
> > they are the same)
> >   mountpoint -> $MOUNTPOINT
> >   flags: mount flags
> >   propagation: mount propagation
> >   children/$CHILD_ID -> ../../$CHILD_ID
> >
> >  supers/$SUPER_ID/
> >    type: fstype
> >    source: mount source (devname)
> >    options: csv of mount options
>
> Oh, wonderful.  So let me see if I got it right - any namespace operation
> can create/destroy/move around an arbitrary amount of sysfs objects.

Parent/children symlinks may be excessive...

> Better yet, we suddenly have to express the lifetime rules for struct mount
> and struct superblock in terms of struct device garbage.

How so?   struct mount and struct superblock would hold a ref on
struct device, not the other way round.

In any case, I'm not insistent on the use of sysfs device classes for
this; struct device (488B) does seem too heavy for struct mount
(328B).

What I'm pretty sure about is that a read(2) based interface would be
way more useful than the syscall multiplexer that the current proposal
is.

Thanks,
Miklos
