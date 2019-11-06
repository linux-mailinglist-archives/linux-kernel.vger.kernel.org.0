Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32C1CF1A08
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 16:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfKFPbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 10:31:36 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41914 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfKFPbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 10:31:36 -0500
Received: by mail-ot1-f65.google.com with SMTP id 94so21135090oty.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 07:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZfcZe9oAWNS5cY+zOKEHcifoIj+GXmX62KAGJO2tELE=;
        b=ksjGv+rDVrfFKq4SrfX25KHYUoZD40eY/vdrA1L1rRwKvhWwyM/U8/0JTcSouughJ2
         ShNHkRzqbWvGVvZJRJImFTkTpOhBDsvVSyZYEHXjAxs0Z9Ye62gnr6g17tOHWJ979lRD
         fQVdCoTe2+R8x57FHmFv0U/56bzLXn6zpcrTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZfcZe9oAWNS5cY+zOKEHcifoIj+GXmX62KAGJO2tELE=;
        b=XxJ1VppoOt8AW633CplXr2kSyd9lFmQbpWAAUX2VjS1fpyJhB+v2TM5u+Dhnu4Jl8N
         ZSmvkBNwOVz1JPgIAJ3MUN9ZtAA/O4Tz+qUUAu1EauHwB0RKfzvvwBSBhL0XtMdy6GfQ
         RZKwhPTG+zK187gp33qbHdypwfQdKUya5a4QgD10M2GBjdbwx64WSQjgX0IN0U4zpZkR
         lt+L5bT8kWr5rmWV4F5aSGoTwxH9wgtmgPtmdVO4hzfDiAxU4zc8TnH0TiM4OmT/pA7n
         2ta6LXcimaEvbiE6+QXv+JJpgI6BcP1SEmhZqMpQiTbdHzD4iAOej31sAuEt5EMeYxEx
         NTug==
X-Gm-Message-State: APjAAAWacWXutrz66kLyWNJlgUBSnA10vuRHhtN34LE0eltAMycB4Y0c
        osUQQuNCm5h4p+bsESMSNiLwTs0VKr174vnRmm/U4g==
X-Google-Smtp-Source: APXvYqw///Krsse2DBdzdG/Ka2FfTS2Yrqhg8d4s7w790j42sEyA6RynvjYQk6BR3wvplC+Qo9T0aGtE99YzD1fI/Tc=
X-Received: by 2002:a9d:6343:: with SMTP id y3mr2195352otk.106.1573053846999;
 Wed, 06 Nov 2019 07:24:06 -0800 (PST)
MIME-Version: 1.0
References: <000000000000b2de3a0594d8b4ca@google.com> <00000000000012ff570596af15cc@google.com>
In-Reply-To: <00000000000012ff570596af15cc@google.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 6 Nov 2019 16:23:55 +0100
Message-ID: <CAKMK7uFQt+=7XMo9jvz77QvDWLAAU_V7-_qZ=iKe-GXG7cqeJg@mail.gmail.com>
Subject: Re: WARNING in drm_mode_createblob_ioctl
To:     syzbot <syzbot+fb77e97ebf0612ee6914@syzkaller.appspotmail.com>
Cc:     Dave Airlie <airlied@linux.ie>,
        Andrew Morton <akpm@linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 4:20 PM syzbot
<syzbot+fb77e97ebf0612ee6914@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit 9e5a64c71b2f70ba530f8156046dd7dfb8a7a0ba
> Author: Kees Cook <keescook@chromium.org>
> Date:   Mon Nov 4 22:57:23 2019 +0000
>
>      uaccess: disallow > INT_MAX copy sizes

Ah cool, this explains it.

fwiw I never managed to get the WARNING in the backtrace to lign up
with any code. No idea what's been going on.

I'll type a patch to paper over this.
-Daniel

>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=125fe6dce00000
> start commit:   51309b9d Add linux-next specific files for 20191105
> git tree:       linux-next
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=115fe6dce00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=165fe6dce00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a9b1a641c1f1fc52
> dashboard link: https://syzkaller.appspot.com/bug?extid=fb77e97ebf0612ee6914
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1212dc3ae00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145f604ae00000
>
> Reported-by: syzbot+fb77e97ebf0612ee6914@syzkaller.appspotmail.com
> Fixes: 9e5a64c71b2f ("uaccess: disallow > INT_MAX copy sizes")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
