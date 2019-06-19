Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCF94B225
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 08:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbfFSGdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 02:33:55 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:32780 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfFSGdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 02:33:54 -0400
Received: by mail-io1-f66.google.com with SMTP id u13so35719308iop.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 23:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bMNViY4iztj4vl/Dr2F11/lbr0UeP3ZXI0/HogSeDNI=;
        b=FctOUlat3YI5lot/q4NRcZSX4MU2PW4YfhkwI9I4zkZuhPG8P69+R2Aw5jAtcJGQD6
         YFAGkZncePhTyhF1iCR8y8iI+paHhWUIxu6nMZfEYjsEWK8qADgt8khRHaFctIZ9GNR9
         OiYWoTA1dYyRCTz34cuaLp6oezL0oSMReABgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bMNViY4iztj4vl/Dr2F11/lbr0UeP3ZXI0/HogSeDNI=;
        b=Gi9T3eaueUdYCb5yj+SzCM9zExATj1MYYq+OLCGo525GeKMI0NqGAHBs3/5rBad3ii
         DqyY1uLRKmE920lUYFdZ0XaHeNUqKdYJuOaGXJbq0KCTiFv/6kfmnXcjoy4COWgl70nk
         uUH7G9V9fYIsyfw3vOjor42LokKR953O+201tXSUQHiD6BbARdubGgYf+alP+yk+Q0jD
         Obgz6/aoiOPsqCKP9IkSNSkw+VQe8uNQj21KpNMosFSijf2NvrhY2dYa3WjjtU82ZYdt
         I7jE2pYfcQi7Ucx2fuu9B1UqyLtsQYMd1g0NXS96IvX7aU5N9uAOCmO9X8UE7nt6jm26
         EDQg==
X-Gm-Message-State: APjAAAV+oo25Y+/KEDxQryxFRvA8SvCb3QiRiZ4wNQbFZH5Tdx427cnU
        MEHvuloVwyqDc2SaBik1bqZ0bZkrLRntZd3hbSCPtA==
X-Google-Smtp-Source: APXvYqyTrgQB4tUX0NqWRg74v50lPrI1xsfZs2C/h0/lMOY9TptquYR7rxkUMy6gsSAZuF6JO7GiJz7HehcP8VuiOxg=
X-Received: by 2002:a6b:7e41:: with SMTP id k1mr4391132ioq.285.1560926031492;
 Tue, 18 Jun 2019 23:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
 <155905629702.1662.7233272785972036117.stgit@warthog.procyon.org.uk>
 <CAJfpegutheVtnmN6BFSjzrmz8p9+DpZxFoKa4CoShoh4MW+5gQ@mail.gmail.com> <24127.1560897289@warthog.procyon.org.uk>
In-Reply-To: <24127.1560897289@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 19 Jun 2019 08:33:40 +0200
Message-ID: <CAJfpegtXp0bQRFGaZia_MGmFGFjKG5XoCnDCy=onmsWBJGHMHw@mail.gmail.com>
Subject: Re: [PATCH 04/25] vfs: Implement parameter value retrieval with
 fsinfo() [ver #13]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 12:34 AM David Howells <dhowells@redhat.com> wrote:

> > Same goes for vfs_parse_sb_flag() btw.   It should be moved into each
> > filesystem's ->parse_param() and not be a mandatory thing.
>
> I disagree.  Every filesystem *must* be able to accept these standard flags,
> even if it then ignores them.

"posixacl" is not a standard flag.  It never was accepted by mount(8)
so I don't see where you got that from.

Can you explain why you think "mand", "sync", "dirsync", "lazytime"
should be accepted by a filesystem such as proc?  The argument that it
breaks userspace is BS, because this is a new interface, hence by
definition we cannot break old userspace.  If mount(8) wants to use
the new API and there really is breakage if these options are rejected
(which I doubt) then it can easily work around that by ignoring them
itself.

Also why should "rw" not be rejected for filesystems which are
read-only by definition, such as iso9660?

Thanks,
Miklos
