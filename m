Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A66FF171434
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 10:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgB0Jgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 04:36:50 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41227 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728624AbgB0Jgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 04:36:49 -0500
Received: by mail-io1-f66.google.com with SMTP id m25so2439967ioo.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 01:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TSFAYumXnIb4mNx6pb9jSCJtikoAu1fiU5AFDR41HiM=;
        b=nMST/l5yp4EsOlkQkjz+oyXVo6tR4nbd5GbUbI5x84hWOMcXm3M7y8DV6kt66nn7b7
         GIlsjbkbx3vQijL/6+LHbt8H5ZHfFqOOXohYBjwIMdjJnBLoeC35oZ4Yl225QYdACe5/
         kVd9f5v/M5gtnQTRoS4CTQDPAYtlf8yBp6HVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TSFAYumXnIb4mNx6pb9jSCJtikoAu1fiU5AFDR41HiM=;
        b=tZX76oCxLJ0hyo4fB8W3XT7n/6yKAhfkPeByl6QAxHJw2XEczrLsss7nPJOfKu8SC+
         UAklbX0AIw22WV5DHGbfsYqlGNDDq/UnON0axU0IzQuvR8nC41STdT17XBqZu+YPwaSX
         VcGSA26sbyVReiPnwOtLEbifj+zBixzATb0QByv6rRwc9xZSpZfIy+Zirh1VeK9YCOcP
         T0HGcAn4Mp6S8uXmKfr5cGHMfko25in+wa4/TnsQn875axlarAHwuvyXRekO6trBgDxQ
         hSj2ULkgN9d2e577ZjPFGznBrBG6a2v5mSaQkYknDn4Nh6+klerkMbfu3xHgtxfcDJGc
         ek/g==
X-Gm-Message-State: APjAAAXy5D5NqQ61xOkTB5N1ozNbFkrRJMhgimYtiYNEISsccMrBGTff
        767EpWSovio+EbE3MbXaSsIZhbmYLZDLwzUcjo7bag==
X-Google-Smtp-Source: APXvYqw5v6WxqDR1yb3LDbMMK6C7QWK8wr5eU3zXIVtb+M97KWiW/29yrC6ghVKgpIwZqN9mr5PMGU2nHAVDTWUTGO8=
X-Received: by 2002:a05:6602:382:: with SMTP id f2mr3597157iov.174.1582796209051;
 Thu, 27 Feb 2020 01:36:49 -0800 (PST)
MIME-Version: 1.0
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
 <1582316494.3376.45.camel@HansenPartnership.com> <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com>
 <1582556135.3384.4.camel@HansenPartnership.com> <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
 <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com> <1582644535.3361.8.camel@HansenPartnership.com>
 <CAOssrKfaxnHswrKejedFzmYTbYivJ++cPes4c91+BJDfgH4xJA@mail.gmail.com> <1c8db4e2b707f958316941d8edd2073ee7e7b22c.camel@themaw.net>
In-Reply-To: <1c8db4e2b707f958316941d8edd2073ee7e7b22c.camel@themaw.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 27 Feb 2020 10:36:38 +0100
Message-ID: <CAJfpegtRoXnPm5_sMYPL2L6FCZU52Tn8wk7NcW-dm4_2x=dD3Q@mail.gmail.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
To:     Ian Kent <raven@themaw.net>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        David Howells <dhowells@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 6:06 AM Ian Kent <raven@themaw.net> wrote:

> At the least the question of "do we need a highly efficient way
> to query the superblock parameters all at once" needs to be
> extended to include mount table enumeration as well as getting
> the info.
>
> But this is just me thinking about mount table handling and the
> quite significant problem we now have with user space scanning
> the proc mount tables to get this information.

Right.

So the problem is that currently autofs needs to rescan the proc mount
table on every change.   The solution to that is to

 - add a notification mechanism
 - and a way to selectively query mount/superblock information

right?

For the notification we have uevents in sysfs, which also supplies the
changed parameters.  Taking aside namespace issues and addressing
mounts would this work for autofs?

Thanks,
Miklos
