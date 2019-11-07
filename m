Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 612EDF3012
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 14:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389237AbfKGNmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 08:42:12 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:47294 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389214AbfKGNmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:10 -0500
Received: by mail-il1-f199.google.com with SMTP id c19so2630016ilf.14
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:42:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=z+Z8TkdvQr/GRZpXW3peRb5jGPad3W0SZz8cB4LQWhs=;
        b=enoI7VBwnujRaE1axmjWw6cAFxLoe7JUqXLx5YXx/4liLtJKJ66vWOS20scqCDE6Fz
         FMDklv8qRCiqUCvof2sVbeANDF1vPZYftxoo8sdImDXU7IEEUA7Dic62GH3X/WByJ1hz
         sYKifS5H98tc8FuJLa9jhmJ+MMhsvFwPKyhA7+083yvC6rtqE7NMM0/AmgYzV+Pu4r2+
         vIhNWcomMl0flGbrimA6RCPDk+lV30gw35oOY1G7cz3nwHzR/x4wVyRtO5aZrkeheFsw
         HyxN+xhP2iEnZyefUbmmi5buDbHjUwAMy+3m48vW186tTqSVBP2Vxc0vOPU3lnfnj7ml
         bmAg==
X-Gm-Message-State: APjAAAX2TMIDpcxWBVpGnZAw1Cf2c+I0AFjWf1HjXk2+rb9b3ymF+e+T
        OC2zf+mo3KpO7dLJrDmckCCQApj4lMfSQcjYGcoWmNbnKAVc
X-Google-Smtp-Source: APXvYqyf1cKz61gO8QSl1DRVCNuMsdbH0nNI8mKaxm3hxYxs5ax7V00wGOmaWFwtfhNI9XqT77Cka6rT2NVHEVha28kuNTLo32XT
MIME-Version: 1.0
X-Received: by 2002:a5d:9613:: with SMTP id w19mr3497924iol.271.1573134128848;
 Thu, 07 Nov 2019 05:42:08 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:08 -0800
In-Reply-To: <001a113f8bf6a9acd90568e8ea59@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef265b0596c1d48c@google.com>
Subject: Re: KASAN: use-after-free Read in uprobe_perf_close
From:   syzbot <syzbot+cef9473c7fa0fe8ab95e@syzkaller.appspotmail.com>
To:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        bhole_prashant_q7@lab.ntt.co.jp, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, oleg@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, stable@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 621b6d2ea297d0fb6030452c5bcd221f12165fcf
Author: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
Date:   Mon Apr 9 10:03:46 2018 +0000

     perf/core: Fix use-after-free in uprobe_perf_close()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1068a38c600000
start commit:   86bbbeba Merge branch 'ras-core-for-linus' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e630e8cb6d3da36
dashboard link: https://syzkaller.appspot.com/bug?extid=cef9473c7fa0fe8ab95e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162240bb800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a4e0bb800000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: perf/core: Fix use-after-free in uprobe_perf_close()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
