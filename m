Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02D74162734
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 14:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgBRNhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 08:37:06 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:55597 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgBRNhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 08:37:05 -0500
Received: by mail-io1-f69.google.com with SMTP id z21so13891306iob.22
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 05:37:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=aHgHZ98+U4qABqernE/QDZiaIAcqsbiecjuclCSQv3M=;
        b=Gx+1eT5SBpK9P8o1x0L3wjNuELsik1SrSupkqwZeL/6p3uCJf1aeQ610TzBACvnEdb
         wy0vRtUtHhb4lFM5QKRgEOG9SyBys9GGZzoUaotL18uSPd9PA33OQFOzuoKPHVuYEGQj
         uqctyY8/7cqwz6EV95C44p86CiRp1cxdYQblaRNoHcBYCDy9umV/55G3i1iUUjYwwSek
         uQaN6u49fI2qhf1iignZWAEfrHeFY4h/KHCwLHC/5Z3AgJcxh4v87qnrupVrLte3s1sC
         Hz6jQLtF/dkDzDAZ6AMvJT9/6JACVdp1aUy/pUFDd9DAAgmJJ+azJWIyQPSguMRV/oFY
         sKLw==
X-Gm-Message-State: APjAAAUsCBWuJe9YqVj11wbOR8PUwJGI+oG7tMSdUE02f9yoGlEcBfnG
        3Rlf/4QEt+mn0/Iec4DAwyAGMuFevBJlxVN5wO03y83qomi2
X-Google-Smtp-Source: APXvYqyshNr6yoq5/wyQMhnfun/9MaaVUhImNxSLDXvsUcP+/UH3ULcBhS56N6d3AxYFbB6MIE376Q80hME1hctKKSSfPJJLaJ4T
MIME-Version: 1.0
X-Received: by 2002:a92:a1c5:: with SMTP id b66mr18063518ill.190.1582033022916;
 Tue, 18 Feb 2020 05:37:02 -0800 (PST)
Date:   Tue, 18 Feb 2020 05:37:02 -0800
In-Reply-To: <000000000000b7ee04059ed40af8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005a9ed2059ed9c426@google.com>
Subject: Re: general protection fault in sco_sock_getsockopt
From:   syzbot <syzbot+4a38d3795200fd59a9eb@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.von.dentz@intel.com, marcel@holtmann.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit eab2404ba798a8efda2a970f44071c3406d94e57
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Fri Feb 14 18:08:57 2020 +0000

    Bluetooth: Add BT_PHY socket option

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=105f1a29e00000
start commit:   c25a951c Add linux-next specific files for 20200217
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=125f1a29e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=145f1a29e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c727d8fc485ff049
dashboard link: https://syzkaller.appspot.com/bug?extid=4a38d3795200fd59a9eb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=158849e9e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e3d711e00000

Reported-by: syzbot+4a38d3795200fd59a9eb@syzkaller.appspotmail.com
Fixes: eab2404ba798 ("Bluetooth: Add BT_PHY socket option")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
