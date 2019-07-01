Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2E3620700
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 14:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfEPMdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 08:33:01 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:40031 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbfEPMdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 08:33:01 -0400
Received: by mail-io1-f72.google.com with SMTP id d24so2544776iob.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 05:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=r+Egu140poF9tk75Gappftvz+qoaAR2oEuAec5aF1lc=;
        b=FJF3OIPCgWU0Ty+Kfo3gRd/v2Ruslu6ujIKG4xq5hqlFKGtAu5q3re/F9DYTxKRQ8h
         VKweMDVTL8g3MjQ7xYRByxhKDXnAD43hn8Y4XdyuWFqY7/ms4fZdWzLoBVrV0mWbdA8V
         E/p9XDyyeL7XCcLhJPW4+6vYziAJwDo/maxrpKAgiACacVq4kgFvLhEMlCfXR/qV9CR6
         TP9YyiQrzhOcWVlA+ciggwk1uITgdOqRDx2Q7r0cR8DbTcF0u3fXDp6nvziHUXnmFC5b
         bSboauWT7dR/Ii7h0oJKgKSwIhKQrsjQr331fTiKIDXVT0wvjH1IQdUYjvbaQTM2pZEH
         DvQQ==
X-Gm-Message-State: APjAAAXAikYVj2OFi1/sBjqlxlC81y0IkCPfJsvTTVlkwC7cJPGJsqlI
        e2+40cC2kOlqttUilB9KrG4kC842FJeMGsF1ONJx2P5CmiJb
X-Google-Smtp-Source: APXvYqxi4qMlBgNoO/Oy+N4ls5yZp4lS3lRfW02dBfYXmkjFfsJ3hI2rbfbc0oB9b59/5ibzuynp9DYFx7tHwakcm80fTlZInRdf
MIME-Version: 1.0
X-Received: by 2002:a05:660c:2ce:: with SMTP id j14mr12523202itd.70.1558009980711;
 Thu, 16 May 2019 05:33:00 -0700 (PDT)
Date:   Thu, 16 May 2019 05:33:00 -0700
In-Reply-To: <20190516114817.GD13274@quack2.suse.cz>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000074f88405890077a3@google.com>
Subject: Re: INFO: task hung in __get_super
From:   syzbot <syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, dvyukov@google.com, jack@suse.cz,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com

Tested on:

commit:         e93c9c99 Linux 5.1
git tree:        
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v5.1
kernel config:  https://syzkaller.appspot.com/x/.config?x=5edd1df52e9bc982
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=135c5b02a00000

Note: testing is done by a robot and is best-effort only.
