Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D610143465
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 00:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgATXQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 18:16:01 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:55142 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgATXQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 18:16:01 -0500
Received: by mail-io1-f72.google.com with SMTP id u6so571200iog.21
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 15:16:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=y3GTXWLuk9NLOUo9vngxj+QH9Vmo0/vEpcLHw8rmxOE=;
        b=uRN1ARuXVzdbSqzosmf9H9Y1c9VGbKTWCAObadMHnLYUhvHIGsD378TMirpxZpsHlJ
         5Z5tyzvZzpvTPxLti44+0Av0yV6H/hCr7om2mIF+gKQQ402df8xM/2WOUnj0c9+jUyR0
         UUtodS+xjgBc8MBVFDNH3W7QoZwbz4AZQ99CiI/t3DFPlHCIfIkwdZ77nNPTWj6z3sGc
         thEixC5invFXPWW1/3qTN3cBpFndFJEIJoFtaqw6/TSs7lcdJgaScf2NDti0/G2sUFEv
         5oqggU1v4gppoodt5eBC374/M/gjJ2Ahje9T6DI5iYind608M5hmvWV4Pp6he6Na6WMJ
         pAsg==
X-Gm-Message-State: APjAAAXj3/HaEgiPNLIQboboZG3Asdp8Gl3Uf1eel1tMOMt4X/xOOu2K
        jv3Lsk/JokYk790tJIsXFvuu6FB6t+HC7rGQRSfjiOBPYznX
X-Google-Smtp-Source: APXvYqwTQzxbm8PYHQsYDQTufEheVPhobojoxo91G/kDDsKtigITdXJIOhyQnk0UJj6rRXnzx2pnx/MUqigsEvuGYyTl0a8JeDIb
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:f0f:: with SMTP id x15mr1213167ilj.298.1579562160891;
 Mon, 20 Jan 2020 15:16:00 -0800 (PST)
Date:   Mon, 20 Jan 2020 15:16:00 -0800
In-Reply-To: <000000000000c7999e059c86eebe@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000802f87059c9a7984@google.com>
Subject: Re: KASAN: use-after-free Read in bitmap_ipmac_ext_cleanup
From:   syzbot <syzbot+33fc3ad6fa11675e1a7e@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        coreteam@netfilter.org, davem@davemloft.net,
        florent.fourcot@wifirst.fr, fw@strlen.de, jeremy@azazel.net,
        johannes.berg@intel.com, kadlec@netfilter.org,
        linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, po-hsu.lin@canonical.com,
        skhan@linuxfoundation.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit ff95bf28c23490584b9d75913a520bb7bb1f2ecb
Author: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Mon Jul 1 04:40:31 2019 +0000

    selftests/net: skip psock_tpacket test if KALLSYMS was not enabled

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17e2e966e00000
start commit:   8f8972a3 Merge tag 'mtd/fixes-for-5.5-rc7' of git://git.ke..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1412e966e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1012e966e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9290aeb7e6cf1c4
dashboard link: https://syzkaller.appspot.com/bug?extid=33fc3ad6fa11675e1a7e
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15982cc9e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11be38d6e00000

Reported-by: syzbot+33fc3ad6fa11675e1a7e@syzkaller.appspotmail.com
Fixes: ff95bf28c234 ("selftests/net: skip psock_tpacket test if KALLSYMS was not enabled")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
