Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92CB516490E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 16:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgBSPqF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Feb 2020 10:46:05 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:38679 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSPqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 10:46:04 -0500
Received: by mail-il1-f197.google.com with SMTP id i67so538642ilf.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 07:46:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:content-transfer-encoding;
        bh=meEL6Fy6aleZ9jtvpgGrvnGSbq9MuEYemHMybXseYg4=;
        b=f3SUE58/YgBfF0JLpdg9f1ANe71O21x02oULTlSzD5TwuiLDfaMMNM4ZElqA2XF+Md
         WSSHB6Rvc39JEoZ/IjzMmR7z7+MZLZz8NMlX90i+XjhUTgnKZhVBgqJaqSEuEgw2dtZI
         tykv4U4rnYWW4FD78g0o8k21ZTN20b/EQS0hpaG41ri8T9zVHuQb7ouVxtFOetdr3T2C
         nZvlouXsaYw6I+M85eLVv8L94rUcdOhuwHje9eMCeTENC2QlSONAmfB6ssskhWwbfcgC
         LpU9rU7eFL1kfolj20zPVcmM30Z9qUDYSqf56cdz07sIDKYl7xWVFEFv59JWAZkAFuyi
         MGMQ==
X-Gm-Message-State: APjAAAXl3kOf5Br7zXZg4GzQkZ9bLKIUE3lEHnNaSn25fVJ1yknqrjDW
        filLa+R2GcoK5+OzNuAyyYQ/FtU8ALDF6RwAv1mkcvPoyc5D
X-Google-Smtp-Source: APXvYqwJfaY34Duul7QI4nsW4eP5gWo56eh9X0PBjI8pEz/ZDnQ4R7/IwdlEugDK5rSMkM2M9L+WROKda4/pXhpDOVDjiChOjTov
MIME-Version: 1.0
X-Received: by 2002:a92:91d8:: with SMTP id e85mr25001159ill.146.1582127163011;
 Wed, 19 Feb 2020 07:46:03 -0800 (PST)
Date:   Wed, 19 Feb 2020 07:46:02 -0800
In-Reply-To: <000000000000c7999e059c86eebe@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a7b14059eefafff@google.com>
Subject: Re: KASAN: use-after-free Read in bitmap_ipmac_ext_cleanup
From:   syzbot <syzbot+33fc3ad6fa11675e1a7e@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        coreteam@netfilter.org, davem@davemloft.net,
        florent.fourcot@wifirst.fr, fw@strlen.de, jeremy@azazel.net,
        johannes.berg@intel.com, kadlec@blackhole.kfki.hu,
        kadlec@netfilter.org, linux-kernel@vger.kernel.org,
        mareklindner@neomailbox.ch, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        po-hsu.lin@canonical.com, skhan@linuxfoundation.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 32c72165dbd0e246e69d16a3ad348a4851afd415
Author: Kadlecsik József <kadlec@blackhole.kfki.hu>
Date:   Sun Jan 19 21:06:49 2020 +0000

    netfilter: ipset: use bitmap infrastructure completely

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13435a7ee00000
start commit:   8f8972a3 Merge tag 'mtd/fixes-for-5.5-rc7' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9290aeb7e6cf1c4
dashboard link: https://syzkaller.appspot.com/bug?extid=33fc3ad6fa11675e1a7e
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15982cc9e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11be38d6e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: netfilter: ipset: use bitmap infrastructure completely

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
