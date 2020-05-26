Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9E4D198EED
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 10:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbgCaI4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 04:56:49 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41314 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730161AbgCaI4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 04:56:48 -0400
Received: by mail-ed1-f68.google.com with SMTP id v1so24148077edq.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 01:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=naz5vFiOyfqlYWnFE99McWHBp3JuwM6PJW7GvvgW6Cc=;
        b=SRrMxw42id0lcjITOkFTm2e3NqOUSpRQCBgX9s9jnPN2a4QIoRIquUmMdmA0BMf4Xp
         U9VQN9PleCKPt5lfXlorjcO0kIf7U2qTLno3a5/zbtdGi6/2rue+eSwXvWzUkQQ0e/+T
         wx6QHGfcYE219bRqR+z8DEBh5rBLCib4PDNcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=naz5vFiOyfqlYWnFE99McWHBp3JuwM6PJW7GvvgW6Cc=;
        b=MwbZBygwphHWh9lU0vMqfpfFTTGlsNneAU5OkfAvWW1vcy+eowAXCiTPcglC4FpC/9
         DwB7mbr/HslBfRjRHtEQguqDle2wLZC0M+ykY/nNbhT3GuARqsaVcdirtReAPXBUUA3D
         Du9c8Hn77jj/5oOgGkvlkqFnM0RP0l61zQhz8TTLJckNFS9/c+BrxcLs0mj03utdEuGq
         lrOvOpX9SkCG1RTNTvsXD1L0S1QOYwGXSPa9C1QuGq4OLqj66hGDKK/z4Do3JM//KyDz
         QeUx/VrIy9/Fnpe8AMIfMooWJZhOdEzU3ypKTKQejMllKQ6g85evvRcacwlD6Kd6ldYA
         rT9w==
X-Gm-Message-State: ANhLgQ2lKlgVSajZMwlwru5davJAR+hoI1vGrPP3VHgEvocMwx8wIIYE
        yJx68qcsSeSdrafVi7KyqiUCEbNmendnbjHqeiexug==
X-Google-Smtp-Source: ADFU+vuc3wwrmQlPzGgTvWh3b6LAUponQqY+y346aNWSjswhKCEVIqgH877rVN/HXD7gX3ps66sOeJ/wC9Whp3TCFTQ=
X-Received: by 2002:a17:906:848d:: with SMTP id m13mr14671902ejx.348.1585645006637;
 Tue, 31 Mar 2020 01:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <1445647.1585576702@warthog.procyon.org.uk> <20200330211700.g7evnuvvjenq3fzm@wittgenstein>
 <CAJfpegtjmkJUSqORFv6jw-sYbqEMh9vJz64+dmzWhATYiBmzVQ@mail.gmail.com> <20200331083430.kserp35qabnxvths@ws.net.home>
In-Reply-To: <20200331083430.kserp35qabnxvths@ws.net.home>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 31 Mar 2020 10:56:35 +0200
Message-ID: <CAJfpegsNpabFwoLL8HffNbi_4DuGMn4eYpFc6n7223UFnEPAbA@mail.gmail.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
To:     Karel Zak <kzak@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 10:34 AM Karel Zak <kzak@redhat.com> wrote:
>
> On Tue, Mar 31, 2020 at 07:11:11AM +0200, Miklos Szeredi wrote:
> > On Mon, Mar 30, 2020 at 11:17 PM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> >
> > > Fwiw, putting down my kernel hat and speaking as someone who maintains
> > > two container runtimes and various other low-level bits and pieces in
> > > userspace who'd make heavy use of this stuff I would prefer the fd-based
> > > fsinfo() approach especially in the light of across namespace
> > > operations, querying all properties of a mount atomically all-at-once,
> >
> > fsinfo(2) doesn't meet the atomically all-at-once requirement.
>
> I guess your /proc based idea have exactly the same problem...

Yes, that's exactly what I wanted to demonstrate: there's no
fundamental difference between the two API's in this respect.

> I see two possible ways:
>
> - after open("/mnt", O_PATH) create copy-on-write object in kernel to
>   represent mount node -- kernel will able to modify it, but userspace
>   will get unchanged data from the FD until to close()
>
> - improve fsinfo() to provide set (list) of the attributes by one call

I think we are approaching this from the wrong end.   Let's just
ignore all of the proposed interfaces for now and only concentrate on
what this will be used for.

Start with a set of use cases by all interested parties.  E.g.

 - systemd wants to keep track attached mounts in a namespace, as well
as new detached mounts created by fsmount()

 - systemd need to keep information (such as parent, children, mount
flags, fs options, etc) up to date on any change of topology or
attributes.

 - util linux needs to display the topology and state of mounts in the
system that corresponds to a consistent state that set of mounts

 - etc...

From that we can derive a set of requirements for the API.

Thanks,
Miklos
