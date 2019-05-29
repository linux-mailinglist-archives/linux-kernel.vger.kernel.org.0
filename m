Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97D982D6A0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 09:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfE2HnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 03:43:01 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:34722 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfE2HnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 03:43:01 -0400
Received: by mail-it1-f194.google.com with SMTP id g23so4770924iti.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 00:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hqFyk47sSJVRHLsfxDt9uxstj8u1M1gZeotStw/KYzw=;
        b=id5wu9BvoNG48+Ck6s8h94PZq86QUHxdJHUYxEOU8jSAxFsa+1A4HOIk2KNNGCHNYc
         OwBytSNRzvO8aYb8lITay3X7zkUGradhD9vfX1R53KWAnrSkr37AzcJ0yZUZVC+Trdhy
         bprSeX3NyZpk8vHx5k5/l7d+PI9MlT+Ld0xEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hqFyk47sSJVRHLsfxDt9uxstj8u1M1gZeotStw/KYzw=;
        b=CPCPMgfqjlyIioaYCX0Ay5JGwxccJTuiHzsILRCW4AA64uXYxY6yZbkaGqr8+X20LU
         MnGNT2Dn0lyGh1igDjLAkUrKha2fsJHsud9gs2wuFM8aX0PhXDpbDND++S0Sp89gRp1m
         avG7S8PPNL7VyWilKUt0A4lOLeMo8DIRV0foEjzFE3RGEEAqIjpUKwX9qUq7jT39H02j
         yrWG5lGMgvw9kKllOxxe/LNwhYDas7OBk1GXe3BBqZD8hnfwYB2QZfvfGlP/loaeSS1o
         V+Hz2O3EPYMcMUOo9Or1pmI+d/q94ZEfXCZ1PzbY+hR3tnff/y57j6i+kWwSzcEUSNNM
         jAaQ==
X-Gm-Message-State: APjAAAV0+awxxb/c546uS/ZAR4YSpBh/QD24SYW2A0rCQle1rmrWb5J1
        HvuwfBeL9up04wG4rjEUSZMTUnOczB5Iii/WW3+GHQ==
X-Google-Smtp-Source: APXvYqwAlJ+88fBjLtyGuaqudPy4+GEXvEcXAfTVL7Bhrhnm6RhxFQ9ymvOB6HhajvGltquJ5SQcGvLqHvz3kY11lns=
X-Received: by 2002:a24:2846:: with SMTP id h67mr6510467ith.94.1559115780417;
 Wed, 29 May 2019 00:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
 <155905627049.1662.17033721577309385838.stgit@warthog.procyon.org.uk>
In-Reply-To: <155905627049.1662.17033721577309385838.stgit@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 29 May 2019 09:42:49 +0200
Message-ID: <CAJfpegtkpNNOOWQ3TnLPGSm=bwL2otQp1--GjNNFiXO7imMxEQ@mail.gmail.com>
Subject: Re: [PATCH 01/25] vfs: syscall: Add fsinfo() to query filesystem
 information [ver #13]
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

On Tue, May 28, 2019 at 5:11 PM David Howells <dhowells@redhat.com> wrote:
>
> Add a system call to allow filesystem information to be queried.  A request
> value can be given to indicate the desired attribute.  Support is provided
> for enumerating multi-value attributes.
>

[...]

> +static u32 calc_sb_flags(u32 s_flags)
> +{
> +       u32 flags = 0;
> +
> +       if (s_flags & SB_RDONLY)        flags |= MS_RDONLY;
> +       if (s_flags & SB_SYNCHRONOUS)   flags |= MS_SYNCHRONOUS;
> +       if (s_flags & SB_MANDLOCK)      flags |= MS_MANDLOCK;
> +       if (s_flags & SB_DIRSYNC)       flags |= MS_DIRSYNC;
> +       if (s_flags & SB_SILENT)        flags |= MS_SILENT;
> +       if (s_flags & SB_POSIXACL)      flags |= MS_POSIXACL;
> +       if (s_flags & SB_LAZYTIME)      flags |= MS_LAZYTIME;
> +       if (s_flags & SB_I_VERSION)     flags |= MS_I_VERSION;

Please don't resurrect MS_ flags.  They are from the old API and
shouldn't be used in the new one.  Some of them (e.g. MS_POSIXACL,
MS_I_VERSION) are actually internal flags despite being exported on
the old API.  And there's SB_SILENT which is simply not a superblock
flag and we might be better getting rid of it entirely.

The proper way to query mount options should be analogous to the way
they are set on the new API: list of {key, type, value, aux} tuples.

Thanks,
Miklos
