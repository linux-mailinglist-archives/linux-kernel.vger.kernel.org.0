Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5499F10B99B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 21:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730918AbfK0UzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 15:55:07 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:33307 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730071AbfK0UzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:55:01 -0500
Received: by mail-io1-f70.google.com with SMTP id p19so16705136iog.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 12:55:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=jQLnoHsKmxpPtDkOoFd6eJabpY7m6+AA5JOgA8Ybj74=;
        b=s/kvgrW2huaEdWoFiqWq8EKNRnC374yldKKJO16VL+YWzfWYWHMg387WncMAGKt4s0
         7Xswk+6zh0XpzCpd6O9UsNq/qig2+B/xkFhRBZEjWRF3GrP3v0oBhmPq+Kz7q7Hkawyv
         qlLyL1STQqth+Nw8z1xvoAk2rRpSXVNwA8eCTMLn2WbztDfNauLjQm/zxZgxWDqy3R5t
         TNdSAjgdK3tqOzHpkEXFWYOvI2LVREcSBp3CATFeFYH7SDMR44O/lGMWAFMOwCMivXHU
         C2pKBaf1IK6b4IIO3U75xoaaGru6zbOOAlpdzbYvtz5FyIeyiEs1dgWG/aMtPfnd4+v5
         ITUQ==
X-Gm-Message-State: APjAAAXiKRdtIK48gUgXCTpPOx2jis1Iulo6XdenlhNheBqeeF7zUqgl
        UAxomywd4v2GF0ZtiLa9/F2+lx/fiIJurt4YKv1tdEZIubyx
X-Google-Smtp-Source: APXvYqz+j/dvUG9sE4PEZA0jKLg/e6cGp5QCogVMjQ5p0MyvvAZ6Ah/N2Rq/BOV+Mzxf0pLx9L1JYqP+zVSMEy27mnZ/q9ADIFgK
MIME-Version: 1.0
X-Received: by 2002:a5e:8505:: with SMTP id i5mr6587567ioj.158.1574888100803;
 Wed, 27 Nov 2019 12:55:00 -0800 (PST)
Date:   Wed, 27 Nov 2019 12:55:00 -0800
In-Reply-To: <Pine.LNX.4.44L0.1911271304410.1319-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cf39d205985a35b0@google.com>
Subject: Re: KASAN: use-after-free Read in si470x_int_in_callback (2)
From:   syzbot <syzbot+9ca7a12fd736d93e0232@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, hverkuil@xs4all.nl,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org, oneukum@suse.com,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+9ca7a12fd736d93e0232@syzkaller.appspotmail.com

Tested on:

commit:         22be26f7 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=387eccb7ac68ec5
dashboard link: https://syzkaller.appspot.com/bug?extid=9ca7a12fd736d93e0232
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17d13f6ae00000

Note: testing is done by a robot and is best-effort only.
