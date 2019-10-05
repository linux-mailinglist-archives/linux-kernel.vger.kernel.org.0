Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8577DCC908
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2019 11:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbfJEJTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 05:19:01 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:36549 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfJEJTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 05:19:01 -0400
Received: by mail-io1-f71.google.com with SMTP id g126so17732149iof.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 02:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=WHf64SvzoBNVwjzIL2+mLBT/FJ5pbE9VxiOvHeZt8EA=;
        b=EJSXAxFMazwDZMN9cGZLGHOGuWFLFOJgXb1hPXP+plC33py/wqIG1E48mS8m25cI3S
         X4m8cqS9FGodEl5FYVKzvRLzAujz6VvmlH7Ydx5bP3nyWSGEOyLLdqZDKKSuHMWX973g
         BjhIurfbkyjD0Axmk9sxc8/95N4QJJRIAd+hPanD2MxMlDD/h5qmyNS2bcwNdYfnwI8o
         rW71K6vKTU7tN1JRQWcZU1vK1x3rrEdt1U8NUCmWL0MPcDib9xwtGG1Nm/uzUsZCjHyc
         8Aaqybdn340ief/efuraamixP9JfQsbVVnb8ahece/Eej6OGeVT8DeiPSWGoO9BLysh1
         AEiA==
X-Gm-Message-State: APjAAAW/xA0l34BZDTR8UlDo2GLrRS81N/YKFX0lUYPzovbdzbu8Oh9V
        gn1BtWOK8io5NvKNttLjhrY/NZga/AdQ/+udglVQO2nxBDfT
X-Google-Smtp-Source: APXvYqz4MZuBJPFuWT2av0dlIWvrlEdd3Imp6vlXh2/IyPR1aQFBmHkuBcqhjfVQvBerP46hmQ+nyu6sLc4lgE0V8zANyLh0l4Ne
MIME-Version: 1.0
X-Received: by 2002:a92:9cd6:: with SMTP id x83mr20597645ill.198.1570267140493;
 Sat, 05 Oct 2019 02:19:00 -0700 (PDT)
Date:   Sat, 05 Oct 2019 02:19:00 -0700
In-Reply-To: <0000000000000a6fc5059423a8f9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c9bac0594264f96@google.com>
Subject: Re: WARNING in __blk_mq_delay_run_hw_queue
From:   syzbot <syzbot+d44e1b26ce5c3e77458d@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, bvanassche@acm.org, hare@suse.com,
        keith.busch@intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit ed76e329d74a4b15ac0f5fd3adbd52ec0178a134
Author: Jens Axboe <axboe@kernel.dk>
Date:   Mon Oct 29 19:06:14 2018 +0000

     blk-mq: abstract out queue map

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1558f6fb600000
start commit:   b145b0eb Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1758f6fb600000
console output: https://syzkaller.appspot.com/x/log.txt?x=1358f6fb600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ec3be9936e004f6
dashboard link: https://syzkaller.appspot.com/bug?extid=d44e1b26ce5c3e77458d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165fcefb600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162d03db600000

Reported-by: syzbot+d44e1b26ce5c3e77458d@syzkaller.appspotmail.com
Fixes: ed76e329d74a ("blk-mq: abstract out queue map")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
