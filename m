Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4E20113F0C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 11:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbfLEKHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 05:07:40 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46287 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfLEKHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 05:07:39 -0500
Received: by mail-qk1-f194.google.com with SMTP id f5so2783924qkm.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 02:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VjuJOLMr71h7BlPci2DPhEaeOFOWk4IptWl8UX4/lTE=;
        b=fqJeEwH0xCJVcVN6Y2Hianz9HNMP0U31kJaTF8Icl+GvgCKY26rcH9EfkJ6ZuAZXqj
         YdmxthWzoY48S+YU1nAVjf4mfjrEVVuyHE2/SRhg7kftqMRm2aXcKcTCjtwp/0WJbonS
         /ZxpTU2kdu2uruQ9HX1Cn/NoUJfPclDto38g7SbGpyvY4Zh8Nk6LYxnWR9H9EK+cNN81
         +Vzp2x15Ikf8g5OkD3QHqvi+enYjgm+WiV8/ZFgdmMzwO4YOVrDsbmHcK1h4/NdxSX1Z
         XkHy7fuCCf3S7nKfhw6MDBYgg9Q7eo15DigV7kliC9abuB4DB1HXKHvS+R7rIP+kCnem
         sGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VjuJOLMr71h7BlPci2DPhEaeOFOWk4IptWl8UX4/lTE=;
        b=GzRCpc1ASb/yhZOwMwdFyFeer6M4FS2X/VjZgwWZPsSVvliXHCp4hKITCRUfSHCmPm
         04m48O45q7qEU4z4+wQ8GurOwLIBWotgG/S5Do8pIlqJcWrUR81HGVNdxAnP8HhtwXDi
         h8UiLUMhIoOln+TiJNcs22kiH9H0kwQy+g4QkUpjw/0IGgrXuqdZTePMD7VodLHYqBzA
         wdUjXeFXN7i5w5OfgZZA1B6HaN2tnc5ul2tX3Tf469391l/EXc0ig+G6Za9p4F6v2D73
         wJNjx5pEK28WdRhRn3IyRg64aJ0iJ2Bfr+Rve1uhztkoICwCsaoRGDHkOX9QWqcnKc0r
         cpwA==
X-Gm-Message-State: APjAAAWxHDbV+AIwCxDsnmLZb1RFyGXU3pP5UuFOAnfUM/25TCu1ZRjj
        rPwiIGOHhBeKsd+nQj7MH4BRsC+iEk0e30inQyHAfQ==
X-Google-Smtp-Source: APXvYqzB/lXSwXDa8RTXCOXE09H5N1QU+BgfeEZa+cNXplG0wSGJpWdAaLRTg123akVsxlSGT1JeXJLn+CPmdOsO9zQ=
X-Received: by 2002:a37:9d12:: with SMTP id g18mr897328qke.43.1575540458488;
 Thu, 05 Dec 2019 02:07:38 -0800 (PST)
MIME-Version: 1.0
References: <00000000000096009b056df92dc1@google.com> <beffba5d-e3d7-8b06-655b-bd04349177ea@kernel.org>
 <20191205100047.GA11438@Johanness-MacBook-Pro.local>
In-Reply-To: <20191205100047.GA11438@Johanness-MacBook-Pro.local>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 5 Dec 2019 11:07:27 +0100
Message-ID: <CACT4Y+Z-9g59XTwpfW+3fv1_jhbsskkvt8E8fx5F44BjofZ0ow@mail.gmail.com>
Subject: Re: kernel BUG at fs/btrfs/volumes.c:LINE!
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        syzbot <syzbot+5b658d997a83984507a6@syzkaller.appspotmail.com>,
        Chris Mason <clm@fb.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 11:00 AM Johannes Thumshirn <jthumshirn@suse.de> wrote:
>
> On Wed, Dec 04, 2019 at 03:59:01PM +0100, Johannes Thumshirn wrote:
> > #syz-test git://git.kernel.org/pub/scm/linux/kernel/git/jth/linux.git
> > close_fs_devices
>
> Ok this doesn't look like it worked, let's retry w/o line wrapping
>
> #syz-test git://git.kernel.org/pub/scm/linux/kernel/git/jth/linux.git close_fs_devices

The correct syntax would be (no dash + colon):

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/jth/linux.git
close_fs_devices
