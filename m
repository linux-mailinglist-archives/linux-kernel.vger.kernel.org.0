Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A531E196374
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Mar 2020 05:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgC1EA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Mar 2020 00:00:29 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:58481 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbgC1EA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 00:00:29 -0400
Received: from surfplank2.hierzo ([IPv6:2001:981:a812:0:b62e:99ff:fe92:5264])
        by smtp-cloud9.xs4all.net with ESMTPA
        id I2e0jqEojfHuvI2e1j3nll; Sat, 28 Mar 2020 05:00:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1585368026; bh=AWtWO70Oljpm3/hz+EGSxPGqTc+Bf81xgMUxPeoxsWQ=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=ADfiXmNJ8sIBEm3/qqRo6iVccVC5WNw/Mg4VfAjtL8uFYQvbUbsk3fgo2k2n7OISB
         UJMfNU1B6IUREHmH1zIf54lvWYCQKpRfMqpvjY1dONxV8fvnTquCZbrhlD9lapTQa8
         WcE8CbiuFUtA8QR9t6aimD5zNRNfHIfMezIZLDenRZYxaBjuK6hkBXLFrPVVtTGXrX
         51N2Fxk5jis7jjjwSf5C0EeCPUfKjz7qQwKLrBULJQL7aPxg+OQEGeEus0k/IIljrT
         8I4eLygoUtrcpPuqXeGtUsmQtyNIpJLjSRUMGRUFVbKfx28LaRwWn/KZkP8RaMqfk7
         gch8FnFl6F1bg==
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Udo van den Heuvel <udovdh@xs4all.nl>
Subject: 5.3.18: BUG: kernel NULL pointer dereference
Autocrypt: addr=udovdh@xs4all.nl; prefer-encrypt=mutual; keydata=
 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
 JjyRAfO8kEkwCkTZ6/Mnrxsunx9VNLGDEw==
Organization: hierzo
Message-ID: <562cb950-c72b-2ad3-7f14-3563edf06cc2@xs4all.nl>
Date:   Sat, 28 Mar 2020 05:00:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPjyXRy0slnK32LJAmeitiPdaH6tEDz1gsmOIm9ZVV//TIP47aOZmFCl0KPbLgFXPeUQSwS5hiwd48OvWi4rrHJ+kayq7AC3/Bxs+w8Qox9hwJ4HngTB
 mLr3h7/YVffDHiPsQozApB+x8eguIprWKqLiJxNSNYA6/3Nr4pnWPVqol/l9/zOjhdGyQ5Tk28DsUe0X+FZYZTCszBryRqyC5EbjpVonvM3tkd8STApOfUkS
 /QyMcBQKcA3teeq+OXF3HA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Is this dmesg below a known issue?
The core message is similar to the one in
https://bugzilla.kernel.org/show_bug.cgi?id=206191 but the trace is
different.

[222221.211818] BUG: kernel NULL pointer dereference, address:
0000000000000024
[222221.254073] #PF: supervisor read access in kernel mode
[222221.285375] #PF: error_code(0x0000) - not-present page
[222221.316678] PGD 0 P4D 0
[222221.332354] Oops: 0000 [#1] PREEMPT SMP NOPTI
[222221.358969] CPU: 2 PID: 2512 Comm: monit Tainted: G        W
5.3.18 #25
[222221.403285] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS
PRO/X570 AORUS PRO, BIOS F11 12/06/2019
[222221.462197] RIP: 0010:pid_nr_ns+0xb/0x30
[222221.486201] Code: c0 74 0e 48 c1 e6 04 48 29 f0 48 2d 78 04 00 00 c3
31 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00 45 31 c0 48 85 ff 74 17 8b 46
48 <3b> 47 04 77 0f 48 c1 e0 04 48 8d 14 07 48 39 74 07 58 74 04 44 89
[222221.599270] RSP: 0018:ffffab684185fda0 EFLAGS: 00010202
[222221.631089] RAX: 0000000000000000 RBX: 0000000000041570 RCX:
0000000000000000
[222221.674370] RDX: 0000000000041571 RSI: ffffffff9e026000 RDI:
0000000000000020
[222221.717650] RBP: ffffab684185fdc8 R08: 0000000000000000 R09:
ffff9b0ace12b000
[222221.760925] R10: 0000000000041580 R11: 0000000000000000 R12:
0000000000000020
[222221.804208] R13: ffffffff9e026000 R14: 0000000000041570 R15:
ffff9b0931896dc0
[222221.847488] FS:  00007f19e41c0740(0000) GS:ffff9b0b9f080000(0000)
knlGS:0000000000000000
[222221.896496] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[222221.931440] CR2: 0000000000000024 CR3: 0000000407efe000 CR4:
00000000003406e0
[222221.974719] Call Trace:
[222221.989878]  next_tgid+0x4a/0xc0
[222222.009717]  proc_pid_readdir+0x11a/0x1fb
[222222.034251]  iterate_dir+0x147/0x1a0
[222222.056179]  ksys_getdents64+0x97/0x130
[222222.079669]  ? filldir+0x180/0x180
[222222.100548]  __x64_sys_getdents64+0x11/0x20
[222222.126126]  do_syscall_64+0x5f/0x2d0
[222222.148569]  ? schedule+0x48/0xc0
[222222.168934]  ? switch_fpu_return+0x24/0xc0
[222222.193986]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[222222.224763] RIP: 0033:0x7f19e42c957b
[222222.246687] Code: 0f 1e fa 48 8b 47 20 c3 0f 1f 80 00 00 00 00 f3 0f
1e fa 48 81 fa ff ff ff 7f b8 ff ff ff 7f 48 0f 47 d0 b8 d9 00 00 00 0f
05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 d9 88 0f 00 f7 d8
[222222.258517] [drm] Fence fallback timer expired on ring gfx
[222222.359755] RSP: 002b:00007fff0a192818 EFLAGS: 00000293 ORIG_RAX:
00000000000000d9
[222222.359758] RAX: ffffffffffffffda RBX: 000055d197c26530 RCX:
00007f19e42c957b
[222222.359759] RDX: 0000000000008000 RSI: 000055d197c26560 RDI:
0000000000000006
[222222.359760] RBP: 000055d197c26560 R08: 0000000000000030 R09:
00007f19e43c2e80
[222222.359761] R10: 0000000000000000 R11: 0000000000000293 R12:
ffffffffffffff80
[222222.359761] R13: 000055d197c26534 R14: 0000000000000002 R15:
00007fff0a192940
[222222.359764] Modules linked in: fuse mq_deadline xt_MASQUERADE
iptable_nat nf_nat ipt_REJECT nf_reject_ipv4 xt_u32 xt_multiport
iptable_filter nf_conntrack_netbios_ns nf_conntrack_broadcast
ip6t_REJECT nf_reject_ipv6 xt_tcpudp xt_state xt_conntrack nf_conntrack
it87 hwmon_vid nf_defrag_ipv6 nf_defrag_ipv4 msr ip6table_filter
ip6_tables uvcvideo videobuf2_vmalloc snd_usb_audio videobuf2_memops
videobuf2_v4l2 videodev snd_hwdep snd_hda_codec_realtek snd_usbmidi_lib
videobuf2_common snd_rawmidi snd_hda_codec_generic cdc_acm snd_hda_intel
snd_hda_codec snd_hda_core snd_seq snd_seq_device snd_pcm i2c_piix4
snd_timer k10temp snd bfq evdev acpi_cpufreq binfmt_misc ip_tables
x_tables amdgpu hid_generic backlight gpu_sched aesni_intel ttm sr_mod
cdrom usbhid i2c_dev autofs4
[222223.061704] CR2: 0000000000000024
[222223.082071] ---[ end trace 818f302d0488ec29 ]---
[222223.110249] RIP: 0010:pid_nr_ns+0xb/0x30
[222223.122491] [drm] Fence fallback timer expired on ring sdma0
[222223.134252] Code: c0 74 0e 48 c1 e6 04 48 29 f0 48 2d 78 04 00 00 c3
31 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00 45 31 c0 48 85 ff 74 17 8b 46
48 <3b> 47 04 77 0f 48 c1 e0 04 48 8d 14 07 48 39 74 07 58 74 04 44 89
[222223.134253] RSP: 0018:ffffab684185fda0 EFLAGS: 00010202
[222223.134254] RAX: 0000000000000000 RBX: 0000000000041570 RCX:
0000000000000000
[222223.134254] RDX: 0000000000041571 RSI: ffffffff9e026000 RDI:
0000000000000020
[222223.134254] RBP: ffffab684185fdc8 R08: 0000000000000000 R09:
ffff9b0ace12b000
[222223.134255] R10: 0000000000041580 R11: 0000000000000000 R12:
0000000000000020
[222223.134255] R13: ffffffff9e026000 R14: 0000000000041570 R15:
ffff9b0931896dc0
[222223.134256] FS:  00007f19e41c0740(0000) GS:ffff9b0b9f080000(0000)
knlGS:0000000000000000
[222223.134256] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[222223.134257] CR2: 0000000000000024 CR3: 0000000407efe000 CR4:
00000000003406e0
