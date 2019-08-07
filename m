Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F535852E5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 20:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389321AbfHGSXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 14:23:01 -0400
Received: from mail-ot1-f70.google.com ([209.85.210.70]:45879 "EHLO
        mail-ot1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387953AbfHGSXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 14:23:00 -0400
Received: by mail-ot1-f70.google.com with SMTP id b25so56319834otp.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 11:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=BKZrN8UHWqfJl9RbVEGYooh5RMS//IjsbU72N8zChOk=;
        b=nwm6Ki5qNzJHYsiC74z3UMasdA4Twgo+gFuPaknqS/xwQ4d0nAO5J46WWZAbU+kXQx
         wO/VaOuVUK0BIq4NFBZoTDVqDiRm+BIlfp76eXPOJBIcT/1hCQKqK0KVIk6XSf3RTxGB
         fCGPlC1TXyUkwJVFFMZ95lzXHqASBpgDhT2eakBfIWrx6nipetC0bZRPvbBLnjNDJfAx
         cDz3vQyTUa/L0PPn/FVvbkaJ7m97luPSVPc87u4rUWvc18lby3wskf4QQS32NI3Kxgiy
         KFxKhIaix6GAj5OtMBmI/x7kwhJ/QIEXB6vuxrKpl4f9m+TR90icPZ2tKFsPAv9iLIwZ
         mihQ==
X-Gm-Message-State: APjAAAUKBp7Xh8VYAEQT99qKqUjwKqFD4nk9lIIqMkgxZQzRbdrxLefL
        S4ciE9ZfkC6HeRdSaD3onPrfDCf1IANUhrJiZnSyfnUDzUwD
X-Google-Smtp-Source: APXvYqzlO/1fjO7fAy/i44rUl8mH1jIN27N+7wScaoD71Pg9Q4qvka+DRr471Gcojl3BUxTa+jpNIACS3U3IJuzDdu5WJcZppu/t
MIME-Version: 1.0
X-Received: by 2002:a02:9004:: with SMTP id w4mr11668135jaf.111.1565202180169;
 Wed, 07 Aug 2019 11:23:00 -0700 (PDT)
Date:   Wed, 07 Aug 2019 11:23:00 -0700
In-Reply-To: <Pine.LNX.4.44L0.1908071402160.1514-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f365b6058f8b07ca@google.com>
Subject: Re: KASAN: use-after-free Read in device_release_driver_internal
From:   syzbot <syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, oneukum@suse.com,
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
syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com

Tested on:

commit:         6a3599ce usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=700ca426ab83faae
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=132eec8c600000

Note: testing is done by a robot and is best-effort only.
