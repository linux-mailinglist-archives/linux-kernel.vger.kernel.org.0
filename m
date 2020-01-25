Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C81F314937D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jan 2020 06:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgAYFRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jan 2020 00:17:03 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:46687 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgAYFRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 00:17:03 -0500
Received: by mail-io1-f72.google.com with SMTP id r74so2725205iod.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 21:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Hm1zljW9y0AexWcJitkyOHbzqNCGgR9k713xPpYIVAY=;
        b=Bhn2yJnn/6cb0FK622x9Eu7iBzhv+S/k3P9/LRgjSS5eW73gXKoJiMsP2AAgC7ZlJ8
         gJgfJpCvG7zXVSR0IweXmGZdKD9WvmS+/1VWgztd/yaDSViO4mU54nyWcHettwbBd+uI
         SY50hisslUiDGkDpB/s+HHsytwX+N/+qf70CQCyBbC+mLW4BXxdCa+Xxw4/NGhA8homU
         /zEDfmLQ0seygNsDagM/RijQgHL9N4bUEtv3txkYLAa34BWk2A6DMYvH7kNIOJ/oI1wL
         t+GAw25uACt0AEGTBTllTeb1hGlJxOedRlM3ed4SJAOCymwPhepk4AV5htcwRv44d782
         szEQ==
X-Gm-Message-State: APjAAAXrNiLiqQP2LrXi3Fq33vZOvkguOTXZBIKPQwPGtdhxo3X+prUc
        /Q+7a6mO1J111zGF8G6zEcN4SZ1IuB8WJRnhAw1TfRgLPPTI
X-Google-Smtp-Source: APXvYqzktrXlzRHbfMlINQ4SHuMoXb8GIG7MQZ6dYPldTUgzSyB7rjjYXEMSwB2k5zI32/xnqeOrTvFvtLKPcvFAYhveGhIqcFFK
MIME-Version: 1.0
X-Received: by 2002:a5d:9514:: with SMTP id d20mr5091562iom.198.1579929422654;
 Fri, 24 Jan 2020 21:17:02 -0800 (PST)
Date:   Fri, 24 Jan 2020 21:17:02 -0800
In-Reply-To: <000000000000c8a983059ce8298c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000001f420059ceffc95@google.com>
Subject: Re: INFO: rcu detected stall in ip_set_udel
From:   syzbot <syzbot+c27b8d5010f45c666ed1@syzkaller.appspotmail.com>
To:     bp@alien8.de, coreteam@netfilter.org, davem@davemloft.net,
        fw@strlen.de, hpa@zytor.com, info@metux.net, jeremy@azazel.net,
        kadlec@blackhole.kfki.hu, kadlec@netfilter.org,
        kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 23c42a403a9cfdbad6004a556c927be7dd61a8ee
Author: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Date:   Sat Oct 27 13:07:40 2018 +0000

    netfilter: ipset: Introduction of new commands and protocol version 7

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1352c611e00000
start commit:   4703d911 Merge tag 'xarray-5.5' of git://git.infradead.org..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10d2c611e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1752c611e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=83c00afca9cf5153
dashboard link: https://syzkaller.appspot.com/bug?extid=c27b8d5010f45c666ed1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1568f9c9e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17db3611e00000

Reported-by: syzbot+c27b8d5010f45c666ed1@syzkaller.appspotmail.com
Fixes: 23c42a403a9c ("netfilter: ipset: Introduction of new commands and protocol version 7")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
