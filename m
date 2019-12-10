Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFC88117D42
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 02:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfLJBiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 20:38:02 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:44669 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfLJBiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 20:38:01 -0500
Received: by mail-il1-f200.google.com with SMTP id h87so13131129ild.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 17:38:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=d/rLwgpGcOLrJAfYzylpfLq8TO3Ppq0ukiadwzb7btY=;
        b=eRXsF6Zdw/ku8QVjKZaLEWiPhrXQzSjYmJM1YriDrna0cwUOF1hLm15RaTlNm4T7Gk
         2ozMmnkGkOSFl6UlJhsnxQuFSaLtffw9Hx/pcAJSVsx274oOPneVZ8SUlbCPAo+dLrtZ
         IR2q2It+jhB3KmCBWEXWfs/yk8R0RI7xwCsJBfDKOdIrzkX6GKcXITpTP9nZQDyUPAXA
         XQkya/JPCEWb1zbdUPPu6+kIrw69JCp2Cjip03Rodq34bM+Bk8aDPiP/x4rtD/3UjlR8
         MedhI+ntcX+EzdoHwfl7YQaF1KiasKvQZUXqHPmBLSCbfNu1h1hc7qM6u4B6t54whfNR
         oVJA==
X-Gm-Message-State: APjAAAVBPHNLlI5OcRQbURcU3XC4RZHT9iKRgO1dbKuKu88OHiVxh7lz
        9t4LKePWNGkJzJCf82lLQJ52eX8gc/fzdwxpPEjD5LZduXrE
X-Google-Smtp-Source: APXvYqx3F0Ru+DmMowW3EN6d2QYATYtlFpjQe/HbQv1AYpW3UNnTiZ8L2MNSyTDTtQA/qzP66Ug/fqFZPiweGeK/5P/FGvCtPAyx
MIME-Version: 1.0
X-Received: by 2002:a6b:5b12:: with SMTP id v18mr24150486ioh.112.1575941881185;
 Mon, 09 Dec 2019 17:38:01 -0800 (PST)
Date:   Mon, 09 Dec 2019 17:38:01 -0800
In-Reply-To: <00000000000044a65205994a7e13@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003cc8505994f9036@google.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in mem16_serial_out
From:   syzbot <syzbot+92f32d4e21fb246d31a2@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, asierra@xes-inc.com,
        corbet@lwn.net, ext-kimmo.rautkoski@vaisala.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        kai.heng.feng@canonical.com, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, mika.westerberg@linux.intel.com,
        paulburton@kernel.org, peter@hurleysoftware.com, sr@denx.de,
        syzkaller-bugs@googlegroups.com, yamada.masahiro@socionext.com,
        yegorslists@googlemail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit bd94c4077a0b2ecc35562c294f80f3659ecd8499
Author: Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed Oct 28 03:46:05 2015 +0000

     serial: support 16-bit register interface for console

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13723196e00000
start commit:   e42617b8 Linux 5.5-rc1
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10f23196e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=17723196e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3754e2c78c1adb82
dashboard link: https://syzkaller.appspot.com/bug?extid=92f32d4e21fb246d31a2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136f7e41e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112b7c82e00000

Reported-by: syzbot+92f32d4e21fb246d31a2@syzkaller.appspotmail.com
Fixes: bd94c4077a0b ("serial: support 16-bit register interface for  
console")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
