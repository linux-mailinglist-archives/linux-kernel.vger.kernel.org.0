Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20F225FEA9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2019 01:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfGDXaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 19:30:07 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:36373 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfGDXaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 19:30:06 -0400
Received: by mail-oi1-f174.google.com with SMTP id w7so5927860oic.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 16:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jpJE/bqP4X6jrsYS/SpmQVJwmzBbGwqkBkuMzE86lUY=;
        b=t46jnHbILyNK0g4ZEs23J3dRvagDLYPDvkj1YjlXpXJi8rS2Bi+gXbhqybTPochshM
         4mLRunjSElqJvSM9u6VQ8xvDpHfZM0KtnF3sV2iU3eV3N1umokhhHWSOEffb+QBWijdP
         4TGejdmVfh9/A1S9N4kCjZ7gK2ncfJ5txGjoVnPEEMULYsUW3zUGHYRbpgtkQlDjabCm
         GdWqTfT/XzNCzbnaObAIDmTfCMfUXrqsiyCcA7Yc5oY6dDIG1eJMNNzkuXEUzCwOli76
         kJtJXq1fliaNRmLF5+Eol4M90zEMwsidjxOjgAXPGR4Wa8XkETbcYw0Rfqz825FC+8tl
         WKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jpJE/bqP4X6jrsYS/SpmQVJwmzBbGwqkBkuMzE86lUY=;
        b=FB+b8gm4DTyrOsLZlYeAPWxByRb3j47D+0y6VEQ+nCW51nOm3GE6qht048FrXC1v/D
         rk6XwlEleU+bQRB4hDqDEUXoMxT0LPG4LItwZrjXjhmdlnqILYNO7pFjaOuvnIT8xELJ
         rhJt78nKpmXrw/RdMiPz27rRcWTXSx5a7HvUIvS58TiVamnm01hWHzExSL8ghn1iC6/K
         A6IpgkZSqneIYsTas47Rqr/CXlcY62DYf1cMDuZBaUd4/noXwxYb7WZQU2tCKzjONO62
         H/lF+FJi14WTFXnLTun0G4bg0ZOWndrsaulLjELlH4VIUhDlFxFPH0S6j0p2Pa8qr8QI
         aJPA==
X-Gm-Message-State: APjAAAWf7lGZF4TnYB66VkWneeLlBE5woCNe4cenjXhc0hRAdzdLfTQc
        IUJhK2xjpNb6mIcVvY18vX5n7FfcJ7WoJZPdoIqBpg==
X-Google-Smtp-Source: APXvYqyUg9zB4UkzwLNPZjhDg6DEZ/CNRZgUWhl5B36J0qzQHr/AyZC9CTcUMNmaPFnBFn1hyTDr97quKbh6HOd8JsU=
X-Received: by 2002:aca:1304:: with SMTP id e4mr427146oii.149.1562283006306;
 Thu, 04 Jul 2019 16:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190704205536.32740b34@canb.auug.org.au> <20190704125539.GL3401@mellanox.com>
 <20190704230133.1fe67031@canb.auug.org.au> <20190704132836.GM3401@mellanox.com>
 <20190705070810.1e01ea9d@canb.auug.org.au>
In-Reply-To: <20190705070810.1e01ea9d@canb.auug.org.au>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 4 Jul 2019 16:29:55 -0700
Message-ID: <CAPcyv4hHC3s3nePSSHaKkFFbxuABZE3GLa7Li=0j6Z45ERrPEg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the hmm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guys, Andrew has kicked the subsection patches out of -mm because of
the merge conflicts. Can we hold off on the hmm cleanups for this
cycle?

On Thu, Jul 4, 2019 at 2:08 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Jason,
>
> On Thu, 4 Jul 2019 13:28:41 +0000 Jason Gunthorpe <jgg@mellanox.com> wrote:
> >
> > BTW, do you use a script to get these conflicting patch commit ID
> > automatically? It is so helpful to have them.
>
> No, I just use gitk and a bit of searching.  Though often there are not
> many possible commits to search.
>
> --
> Cheers,
> Stephen Rothwell
