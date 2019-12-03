Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39772111B9D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 23:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfLCWZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 17:25:09 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:56298 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfLCWZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:25:09 -0500
Received: by mail-io1-f69.google.com with SMTP id z21so3556461iob.22
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 14:25:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=CXOkI0TBPtmTtJsgF6Sr0rjb/p028NpwaM4sLEBYlYQ=;
        b=TaTxXn+jddrEjRA+Kx6ltJHMvvjcuBsPElNj7REBlpKhlapE5+wRszsEwWe/5ttCpt
         EWelRChbJWUzfBZvzDOBrq+2vrd1dno7F5UBFnM7rg5At2Oz7EYdcJl3Crg/r3HLyHkb
         4soMXY4gDsOWOCffwrPShRzn4uPe+Q9gt1dT8F2Ftp4wUmEnIz5vINbhyOqJtnD//Hzw
         nGfpjs75WidDySaBYFeA5ryaZ7sVDVQaXpbn3lzkpBNEhilrehH9v/mj1FFGkbC8fkOQ
         WBXFpCvKGhUkGuTR7I0gEdMuYXTyzksWyP4hsgsbrE4/iKZfsM0Sq+/P40EIG2mI/jQD
         /XDA==
X-Gm-Message-State: APjAAAXgxnG6Z4kv5tRhL+C4bzKTuXayVtN1jRRbfHDkNzv7ysJY9zIv
        d1MtA7oPhBwCjTUninVqyfqe4VD4IyKVh4K11xCQ474X87dJ
X-Google-Smtp-Source: APXvYqw0xQihGRub9pr2EXHoW6MqapjULktrGjdJ8k6mGFbVD7FZp6C3iVDmayNWFbuvk79pyYzHmOJ+M1o4qnItZXeuDkXdbxWn
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2541:: with SMTP id j1mr388622ioe.239.1575411908408;
 Tue, 03 Dec 2019 14:25:08 -0800 (PST)
Date:   Tue, 03 Dec 2019 14:25:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002cfc3a0598d42b70@google.com>
Subject: KASAN: slab-out-of-bounds Read in fbcon_get_font
From:   syzbot <syzbot+4455ca3b3291de891abc@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, daniel.thompson@linaro.org,
        daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org,
        ghalat@redhat.com, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        sam@ravnborg.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    76bb8b05 Merge tag 'kbuild-v5.5' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10bfe282e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd226651cb0f364b
dashboard link: https://syzkaller.appspot.com/bug?extid=4455ca3b3291de891abc
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11181edae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105cbb7ae00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4455ca3b3291de891abc@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in memcpy include/linux/string.h:380 [inline]
BUG: KASAN: slab-out-of-bounds in fbcon_get_font+0x2b2/0x5e0  
drivers/video/fbdev/core/fbcon.c:2465
Read of size 16 at addr ffff888094b0aa10 by task syz-executor414/9999

CPU: 0 PID: 9999 Comm: syz-executor414 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:638
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
  memcpy+0x24/0x50 mm/kasan/common.c:124
  memcpy include/linux/string.h:380 [inline]
  fbcon_get_font+0x2b2/0x5e0 drivers/video/fbdev/core/fbcon.c:2465
  con_font_get drivers/tty/vt/vt.c:4446 [inline]
  con_font_op+0x20b/0x1250 drivers/tty/vt/vt.c:4605
  vt_ioctl+0x181a/0x26d0 drivers/tty/vt/vt_ioctl.c:965
  tty_ioctl+0xa37/0x14f0 drivers/tty/tty_io.c:2658
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:545 [inline]
  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4444d9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff6f4393b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fff6f4393c0 RCX: 00000000004444d9
RDX: 0000000020000440 RSI: 0000000000004b72 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000400da0
R10: 00007fff6f438f00 R11: 0000000000000246 R12: 00000000004021e0
R13: 0000000000402270 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 9999:
  save_stack+0x23/0x90 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  __kasan_kmalloc mm/kasan/common.c:512 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:485
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:526
  __do_kmalloc mm/slab.c:3656 [inline]
  __kmalloc+0x163/0x770 mm/slab.c:3665
  kmalloc include/linux/slab.h:561 [inline]
  fbcon_set_font+0x32d/0x860 drivers/video/fbdev/core/fbcon.c:2663
  con_font_set drivers/tty/vt/vt.c:4538 [inline]
  con_font_op+0xe18/0x1250 drivers/tty/vt/vt.c:4603
  vt_ioctl+0xd2e/0x26d0 drivers/tty/vt/vt_ioctl.c:913
  tty_ioctl+0xa37/0x14f0 drivers/tty/tty_io.c:2658
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:545 [inline]
  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 9771:
  save_stack+0x23/0x90 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  kasan_set_free_info mm/kasan/common.c:334 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:473
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:482
  __cache_free mm/slab.c:3426 [inline]
  kfree+0x10a/0x2c0 mm/slab.c:3757
  tomoyo_init_log+0x15c1/0x2070 security/tomoyo/audit.c:294
  tomoyo_supervisor+0x33f/0xef0 security/tomoyo/common.c:2095
  tomoyo_audit_env_log security/tomoyo/environ.c:36 [inline]
  tomoyo_env_perm+0x18e/0x210 security/tomoyo/environ.c:63
  tomoyo_environ security/tomoyo/domain.c:670 [inline]
  tomoyo_find_next_domain+0x1354/0x1f6c security/tomoyo/domain.c:876
  tomoyo_bprm_check_security security/tomoyo/tomoyo.c:107 [inline]
  tomoyo_bprm_check_security+0x124/0x1a0 security/tomoyo/tomoyo.c:97
  security_bprm_check+0x63/0xb0 security/security.c:784
  search_binary_handler+0x71/0x570 fs/exec.c:1645
  exec_binprm fs/exec.c:1701 [inline]
  __do_execve_file.isra.0+0x1329/0x22b0 fs/exec.c:1821
  do_execveat_common fs/exec.c:1867 [inline]
  do_execve fs/exec.c:1884 [inline]
  __do_sys_execve fs/exec.c:1960 [inline]
  __se_sys_execve fs/exec.c:1955 [inline]
  __x64_sys_execve+0x8f/0xc0 fs/exec.c:1955
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff888094b0a000
  which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 2576 bytes inside of
  4096-byte region [ffff888094b0a000, ffff888094b0b000)
The buggy address belongs to the page:
page:ffffea000252c280 refcount:1 mapcount:0 mapping:ffff8880aa402000  
index:0x0 compound_mapcount: 0
raw: 00fffe0000010200 ffffea0002a3ae08 ffffea0002a6aa88 ffff8880aa402000
raw: 0000000000000000 ffff888094b0a000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888094b0a900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff888094b0a980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff888094b0aa00: 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                          ^
  ffff888094b0aa80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff888094b0ab00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
