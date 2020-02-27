Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6317171680
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 12:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgB0L5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 06:57:31 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44686 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgB0L5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:57:30 -0500
Received: by mail-wr1-f66.google.com with SMTP id m16so2931515wrx.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 03:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zh05Cj8vtIuH5qpsLMyYEWFCipQ2HuOc3XYtKhBW6hA=;
        b=lPMYR8/2BG8nuN9H0R1Cq+e5+kdzaxauQ8ws/ZcJMjpdlz6Tpw+hvapLx3CBe9ZQWy
         BlGyuk3F2T0KinjIJmB8BTj7WY4Fbjx4Uhh/S1HdSPyM4jBgqrIYzw2XE+zEONhAHNRd
         pNMoruUeOPN85/E91SBQftlqdx+5v97RaBLR6FgoFc7ZJzX4fEkmbWOUCiTmIuDrdA8X
         VJOnPem9ckGuOYYer7jKPwRwL9G/3Oi34Dv4JtAa5QaEEi4oNFtUeDpdtqpq+ZJpKdv1
         fh+BPc1iNqaTPcv9+wGiN8mr2QnvpI/nycwbSZ4NxQZEMKhRB+XeabupV1ilnFb2TYJM
         rrfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zh05Cj8vtIuH5qpsLMyYEWFCipQ2HuOc3XYtKhBW6hA=;
        b=T8gYaHNeUF/v42sLLuKW9EoGmSDiVy+wDAis5mX0ZtC2MCuoSWYT0srAnS3+dNuqQy
         bHsPa/5Fx5L0KhCE6s2/1UusUNzfHt7YISGknxCxrE0aOD45i2I5JJDtRsI8DrVOglK+
         SB464ukPDOSjDaldlK2JF7lErKd0IoUlT1hDruNI1X3dvVHp5krdrQ3WxvJCKCb8sYD1
         Q7YkZS9TzOqeYOUJOA02iOs9mZkFXOVofhz44DYoEcY8ZH7/yRWA8iY7JVoie7MoqlSb
         vXP5TppgKUbjuwgYHyevQBl+i8Rj8jH1443QzaEPqIUJ8nmV/WSq7IbGhSx06JZCrSOP
         nz8w==
X-Gm-Message-State: APjAAAV4gk580thErFuVm4QeFs8TqlaQaQW7gdeZJKTxW4Fzz92h4qqo
        vd2nzaun1N+NZMWUYLgeFY8U1OZbJGJliOK3nFNOFg==
X-Google-Smtp-Source: APXvYqzZG8/nRFzUUy7t28psZ9jaVKoc5iI0sCJb50rEPQJATHPmHl2vMiijVIImTjjmkDU3rGMLIzb4Rqydz2C+AKo=
X-Received: by 2002:a5d:6692:: with SMTP id l18mr4412776wru.382.1582804648383;
 Thu, 27 Feb 2020 03:57:28 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007b25c1059f8b5a4f@google.com>
In-Reply-To: <0000000000007b25c1059f8b5a4f@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 27 Feb 2020 12:57:17 +0100
Message-ID: <CAG_fn=XWOjiLY8KON5VdieOVpWdnbtMqo2v8TZ1f04+4777J=g@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in simple_attr_read
To:     syzbot <syzbot+fcab69d1ada3e8d6f06b@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 10:29 AM syzbot
<syzbot+fcab69d1ada3e8d6f06b@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    8bbbc5cf kmsan: don't compile memmove
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=14394265e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cd0e9a6b0e555cc3
> dashboard link: https://syzkaller.appspot.com/bug?extid=fcab69d1ada3e8d6f06b
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1338127ee00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161403ede00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+fcab69d1ada3e8d6f06b@syzkaller.appspotmail.com

This report says it's uninit in strlen, but there's actually an
information leak later on that lets the user read arbitrary data past
the non-terminated attr->get_buf.
