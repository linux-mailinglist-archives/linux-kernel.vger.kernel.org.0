Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69D191084AD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2019 20:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfKXTKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Nov 2019 14:10:02 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:40447 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfKXTKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 14:10:02 -0500
Received: by mail-il1-f199.google.com with SMTP id y3so7444077ilk.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2019 11:10:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=rNtPPUmvTAuaseACe333tB1gvLHQA8VrBz37N2SCQEI=;
        b=f8PZWUxt/ec60B5/iFbSEeNqQA5gwrsGW3metN3rajKC1JARyZEMUQybcT/VUCXHBk
         g4SwiJWS3mJiWBHZvQRPk8JNu/qpbM46hdudYFV37S2w2dotzsvhUH+UB3CaJCPXhZo6
         jCmRYBdLPuHvmGZ848102FpRkkKTSISlN3pPG26M1MmalmwDXzNORwiJ9D4JJY7RDhoQ
         Nqr9OAiAPeRy4BrQQGDmy4XEUKMl3XjFoeZnTMHfvOUj7Z/3FNbiZ+froVWRYXW9eD+v
         CiCXpX5Bsen+uvC4eYv+IpRphqrEE9l/4b4KfLOUJg792Kupg3XTZCkczZGbh3d8oSzV
         JkPg==
X-Gm-Message-State: APjAAAXKR47cGRGvnNrhOpVksJ1vNFNbAiSclYAYll+pfikqW9fUx9ZF
        IPH/80NbYJqGtqPqyYWPz+tbjkf9O7YJp6PqenPTSPeEEYW3
X-Google-Smtp-Source: APXvYqw4LewVpY7ux6pwbys8MgW7qpOt924SvU7Tldt/xQxnFTlNtc3lXSECVTTqXA7ZBOhI+AkU9W5vYufpU6zgxjYcj56gf1LO
MIME-Version: 1.0
X-Received: by 2002:a6b:770b:: with SMTP id n11mr21183251iom.154.1574622601295;
 Sun, 24 Nov 2019 11:10:01 -0800 (PST)
Date:   Sun, 24 Nov 2019 11:10:01 -0800
In-Reply-To: <Pine.LNX.4.44L0.1911241052300.26037-100000@netrider.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce3cc905981c64bd@google.com>
Subject: Re: possible deadlock in mon_bin_vma_fault
From:   syzbot <syzbot+56f9673bb4cdcbeb0e92@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        jrdr.linux@gmail.com, keescook@chromium.org,
        kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, zaitcev@redhat.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but build/boot failed:

failed to apply patch:
checking file drivers/usb/mon/mon_bin.c
patch: **** unexpected end of file in patch



Tested on:

commit:         4d856f72 Linux 5.3
git tree:        
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v5.3
dashboard link: https://syzkaller.appspot.com/bug?extid=56f9673bb4cdcbeb0e92
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17a22f16e00000

