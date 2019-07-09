Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3F863CB0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 22:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbfGIUWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 16:22:04 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:36340 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729545AbfGIUWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 16:22:01 -0400
Received: by mail-io1-f69.google.com with SMTP id k21so191962ioj.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 13:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=gNp6IGzQMQGefwcCXwihte4j+oJMtUnlDKJXuaM+cUk=;
        b=tSxU67gJy48F/TCxJdR2QxVnoy7xUImIBkrejze5jOv3EtHLKsIhQyXi6Hzcrcur9g
         trYxybm8ThTgk5c5e4wAZQJMXFx/JUNQQoOcob0joQa5kcn6ZKITIWGQb4hw+TvTMbLL
         ldCynwzSNs+m9A34TJ3WEfOlH40JvcTuOLQ36DLDs7Im7XXgUpCmPSEqLMLfRq9OZQ9x
         2nGGsXpc+K+hMWGoxVccr1CdCh6DVj4sD+CmO/aY3YQ6etbuFYRs78mfWXZQ+4rb7gax
         ZEr+h7MaKA8dL1LwgLIZL48cDvNrHaEXgvcj2H7BmUy5voOfv5gszh80lAohDbNA4FDa
         p8Jw==
X-Gm-Message-State: APjAAAUg8vJcsn8+G+twpvbwfd1Fiub673FIXx1AjingjGvjX73SHqi8
        Yf5e+lYxVSbGhf1QKziubvht3IVekvNsjMUie/Jh2bE4p0M+
X-Google-Smtp-Source: APXvYqwFgwJAcUPiL5NbtuCyvSACDdRE25Si64mrNjVzIA9vXUAmOPuBWXTLl+KgXo65r6gDEueAVIzpruHAb52RcugMcVs1Xph6
MIME-Version: 1.0
X-Received: by 2002:a6b:6409:: with SMTP id t9mr9378524iog.270.1562703720611;
 Tue, 09 Jul 2019 13:22:00 -0700 (PDT)
Date:   Tue, 09 Jul 2019 13:22:00 -0700
In-Reply-To: <0000000000000595ea058d411c35@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000280332058d45509c@google.com>
Subject: Re: WARNING: refcount bug in nr_insert_socket
From:   syzbot <syzbot+ec1fd464d849d91c3665@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ralf@linux-mips.org, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit c8c8218ec5af5d2598381883acbefbf604e56b5e
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu Jun 27 21:30:58 2019 +0000

     netrom: fix a memory leak in nr_rx_frame()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1677f227a00000
start commit:   4608a726 Add linux-next specific files for 20190709
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1577f227a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1177f227a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a02e36d356a9a17
dashboard link: https://syzkaller.appspot.com/bug?extid=ec1fd464d849d91c3665
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b47be8600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15172e7ba00000

Reported-by: syzbot+ec1fd464d849d91c3665@syzkaller.appspotmail.com
Fixes: c8c8218ec5af ("netrom: fix a memory leak in nr_rx_frame()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
