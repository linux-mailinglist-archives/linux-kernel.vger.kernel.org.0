Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27DC4133A94
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 05:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgAHEj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 23:39:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:58168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgAHEj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 23:39:27 -0500
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E17920848
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jan 2020 04:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578458366;
        bh=dPkwsTHDSFh/AlhLKMu8SfXypcftv+MrrSXdjB8TlCg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zo2q/guK0Te/iTqGXf3SvyqyWLZnZryXPvlKdFXdNJdGBBy8ctLeTY2cPwgEHE06N
         NPJbRd8JxRD23NLJgsLXpSJawO2dNwLgMoXyn5etXhzNfdNtiX8KV8gXLwFHH5Jmj7
         K3TYOsWq2pU0Xxc8rWGq+IHMRapADDP2TTdSFTko=
Received: by mail-wm1-f54.google.com with SMTP id m24so1043344wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 20:39:26 -0800 (PST)
X-Gm-Message-State: APjAAAXIgqyJqw/AZVuWRjyJAUtnEJSxsZ5n0rjWSH+LbVnlBKmXc2Cb
        OOPdAuF1CP6CtQDuHXdjeytzqdsP+5QPscB1X6zbiA==
X-Google-Smtp-Source: APXvYqz/SlzA6q8BHzR8wgKeCu5YF8gd0+SAe8SHOFxrPyQnlZmV8Zsm1JVs0cwdLErhzYcGzMfm2lHs87ilm/bZZrU=
X-Received: by 2002:a1c:7ed0:: with SMTP id z199mr1421925wmc.58.1578458364943;
 Tue, 07 Jan 2020 20:39:24 -0800 (PST)
MIME-Version: 1.0
References: <20191230052036.8765-1-cyphar@cyphar.com> <20191230052036.8765-2-cyphar@cyphar.com>
 <CAHk-=wjHPCQsMeK5bFOJQnrGPfVDXTAFQK4VsBZPj5u=ZgS-QA@mail.gmail.com> <20191230082847.dkriyisvu7wwxqqu@yavin.dot.cyphar.com>
In-Reply-To: <20191230082847.dkriyisvu7wwxqqu@yavin.dot.cyphar.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 7 Jan 2020 20:39:10 -0800
X-Gmail-Original-Message-ID: <CALCETrX1JZV-KtU-LwAuTv4Dc2yFWdTOKUZnmN_pgbUdC-bgLw@mail.gmail.com>
Message-ID: <CALCETrX1JZV-KtU-LwAuTv4Dc2yFWdTOKUZnmN_pgbUdC-bgLw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/1] mount: universally disallow mounting over symlinks
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        stable <stable@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Serge Hallyn <serge@hallyn.com>, dev@opencontainers.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 12:29 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> On 2019-12-29, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > On Sun, Dec 29, 2019 at 9:21 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> If allowing bind-mounts over symlinks is allowed (which I don't have a
> problem with really), it just means we'll need a few more kernel pieces
> to get this hardening to work. But these features would be useful
> outside of the problems I'm dealing with (O_EMPTYPATH and some kind of
> pidfd-based interface to grab the equivalent of /proc/self/exe and a few
> other such magic-link targets).

As one data point, I would use this ability in virtme: this would
allow me to more reliably mount over /etc/resolve.conf even when it's
a symlink.

(Perhaps I should use overlayfs instead.  Hmm.)
