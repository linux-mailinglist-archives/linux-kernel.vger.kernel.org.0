Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCA063843
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 16:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfGIOzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 10:55:46 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:44433 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfGIOzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 10:55:46 -0400
Received: by mail-io1-f48.google.com with SMTP id s7so43742263iob.11;
        Tue, 09 Jul 2019 07:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9KMd9yknkR/+c86sYJxaacnce7lwo4HnwkWIRsstIvc=;
        b=en9sy9BoC7AQ5xWdOXvEGc7M1sc8G+FncI3Wyf8tSliOeOv9I0QKLXudMJBeKS5bgC
         Lve6jVlSQ5y277mYdGTyzFuO2Gz9bmHjn898R/i6KNFCn2sx4Co0Y+Yqv+EE275ZcXH6
         iK0rGJn/cLWvFdxk8SXTbetAYu/5je58SOkP94dzw29sNTGpKCgqyIpTtsYIzq5c4qs2
         ic0lV+wFjB9uqcy9MeXAS5nsZndMEoD03Y7UgTDIZjfUac8QvU0xCnO7De+ZXxwPMzkF
         SS4q/fPVKymRKFsqg4zifJvvrxAuK5JiMkU7pY6LkMo29hGmbMzL41H4iEayvHbHW73B
         zKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9KMd9yknkR/+c86sYJxaacnce7lwo4HnwkWIRsstIvc=;
        b=aZMKERySd/i3jU2Z3izPJo07gPm73PPpjfjDXoNTQgjIY2lmgdLQWYLxh5+uda+oa7
         kqrhXg4mwzXRn/O3HhJsbiw8kkCdSNZgUvPvFZP1QMYNxHN5b4V8ZbnIh4qM+MZfmk/s
         qAeTY6hvrhuJs75ovzDOKDS1dDajDalWZy59n64bDgCaE2Wk5zaMCzb4cTS4chaIbFIp
         szJ5UjCL8nvnj1evcYoI/W7yJ6jtKG+OgPYGxAmPmkm9sqHus7sedxrSo/ndx61xEnMz
         wrLf8NXPv3yqlzRazvK0UBeI22B3HGnJMG9vU2mE96+475MFbqBhe9pU+3ZEZVUdT6pb
         giuQ==
X-Gm-Message-State: APjAAAXP1SP3q7f6rJ8zQTc32/ef0nIal0LmZnTgMgiEJI6yveTFBWcQ
        +GzA1vFMXo6PDLK8Kzs3yaUTELiZxaEaBefbdC+EPKQ=
X-Google-Smtp-Source: APXvYqwDxozVdqx2YUjLNkgpJjIKpdsN6GzZLTkWR9W7hcYndFmMhOnt4/nJgTTsxkPIdoGLLKL1prXG/lBM8MLRZKs=
X-Received: by 2002:a5d:8404:: with SMTP id i4mr11903742ion.146.1562684145110;
 Tue, 09 Jul 2019 07:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190708072858.566aa564@canb.auug.org.au> <CAABAsM7jKzWPNoe63LU33tVfn7a88ZP9yzp4Bb1BN2TDWMxgjQ@mail.gmail.com>
 <ed6656ad172920882862e5571b6c237a31974bc3.camel@netapp.com>
In-Reply-To: <ed6656ad172920882862e5571b6c237a31974bc3.camel@netapp.com>
From:   Trond Myklebust <trondmy@gmail.com>
Date:   Tue, 9 Jul 2019 10:55:34 -0400
Message-ID: <CAABAsM4GzOXHrv1JLC3KRpdA=+7jiFF2tGL5=5PKYbV_Qcys5A@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the nfs tree
To:     "Schumaker, Anna" <Anna.Schumaker@netapp.com>
Cc:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes please.

On Tue, 9 Jul 2019 at 10:30, Schumaker, Anna <Anna.Schumaker@netapp.com> wrote:
>
> On Sun, 2019-07-07 at 17:30 -0400, Trond Myklebust wrote:
> > NetApp Security WARNING: This is an external email. Do not click
> > links or open attachments unless you recognize the sender and know
> > the content is safe.
> >
> >
> >
> >
> > On Sun, 7 Jul 2019 at 17:29, Stephen Rothwell <sfr@canb.auug.org.au>
> > wrote:
> > > Hi all,
> > >
> > > Commits
> > >
> > >   fe9ad197bd8a ("xprtrdma: Remove the RPCRDMA_REQ_F_PENDING flag")
> > >   08d720bcd822 ("xprtrdma: Fix occasional transport deadlock")
> > >   beb843739ea0 ("xprtrdma: Replace use of xdr_stream_pos in
> > > rpcrdma_marshal_req")
> > >
> > > are missing a Signed-off-by from their committer.
> > >
> >
> > Anna?
>
> Looks like I missed the "-s" flag to `git-am` when I was applying
> these. I just fixed it locally, do you want me to send you a new pull
> request?
>
> Anna
