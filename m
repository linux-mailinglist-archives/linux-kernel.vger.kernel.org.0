Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C878192052
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 06:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgCYFHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 01:07:36 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:47209 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725263AbgCYFHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 01:07:36 -0400
Received: from surfplank2.hierzo ([IPv6:2001:981:a812:0:b62e:99ff:fe92:5264])
        by smtp-cloud7.xs4all.net with ESMTPA
        id GyGKjJR2RLu1fGyGLjyPua; Wed, 25 Mar 2020 06:07:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1585112853; bh=sH6rW920hI4EcpzSunVY9nTEHPeYBnJMxTgPAWfNnfk=;
        h=From:Subject:To:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=gXjxI3uxWgS3Jzp9MnJYFcDjN8riMqDz3O9ngMUI95blow/gpvCCA/uAxI6mu4nB6
         NF0gcPiqsPTf0F0edQyoqdNq7n9h9uVm/aHxvh8yePTHScZSH0nv0RDaHYYPBqqpq9
         qOepN6xzrN58I6kPIGNffIJxIeuEpEnLB+zAMX7ZvDAl1qjBS3eK9sfBt4PLGWB7ah
         qDF/smvxZxgM2aBKmh3SeNbvYwYbTyfP9/rfbqi0acRn55t8heBXyYDX0J29t/gP1r
         RWKiDorc0ZOYIY38UdA/JWzc45h3SDgv5KlRXLeT+3xwfLEu9XXKAha8Qv/wt/6RKP
         YbnvGbpOd5/kQ==
From:   Udo van den Heuvel <udovdh@xs4all.nl>
Subject: 5.3.18: general protection fault
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Autocrypt: addr=udovdh@xs4all.nl; prefer-encrypt=mutual; keydata=
 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
 JjyRAfO8kEkwCkTZ6/Mnrxsunx9VNLGDEw==
Organization: hierzo
Message-ID: <93308fad-2462-c8f9-99b2-d8c8aab241d3@xs4all.nl>
Date:   Wed, 25 Mar 2020 06:07:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIaTaxkFjIbDLGNryBDcVqNsCxPYWRx/CaoaUuZveOEVn6UfhmwZyJektQvuF1iyB/dYTfSEDcGDLm4aANYjZyTFpMTZgrrrb3ME9+oR4aBAhAyNPBv7
 clZjkIpvvbhyusofAaICJwCulVax6GF+qzB9+2Tz1k6YcoHP2C4oTiRL3SxzcIq/M0zGM9SncWyp3zyFzQI13J76VBmM21jm0Vm5Q/ImzXsRTl1Cx/bI4GKr
 UnO3zg2DGM70t/ysFl4ltg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Due to the unusable 5.4.x and 5.5.x kernels, see
https://bugzilla.kernel.org/show_bug.cgi?id=206191, I am running 5,3,18.
This kernel crashes way less.
It did show the fault below:

[56279.400332] general protection fault: 0000 [#1] PREEMPT SMP NOPTI
[56279.436856] CPU: 1 PID: 233 Comm: kswapd0 Tainted: G        W
5.3.18 #25
[56279.481174] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS
PRO/X570 AORUS PRO, BIOS F11 12/06/2019
[56279.539562] RIP: 0010:queued_spin_lock_slowpath+0x178/0x1d0
[56279.572948] Code: 8b 45 00 48 85 c0 74 f5 48 89 c2 eb e4 c1 ea 12 83
e0 03 ff ca 48 c1 e0 04 48 63 d2 48 05 c0 ed 01 00 48 03 04 d5 20 d5 e0
b1 <48> 89 28 8b 45 08 85 c0 75 09 f3 90 8b 45 08 85 c0 74 f7 48 8b 45
[56279.685489] RSP: 0018:ffffa85240747a88 EFLAGS: 00010002
[56279.716787] RAX: 0001812dff56fe58 RBX: ffffa2e9c6690350 RCX:
0000000000000000
[56279.759547] RDX: 0000000000003199 RSI: 00000000c6690300 RDI:
ffffa2e9c6690350
[56279.802302] RBP: ffffa2ea9f05edc0 R08: 0000000000000238 R09:
0000000000000002
[56279.845063] R10: ffffa2e9c6690348 R11: ffffa2ea8b08ed80 R12:
0000000000080000
[56279.887823] R13: 0000000000000001 R14: ffffa2e9c6690350 R15:
ffffddcf0c8ad008
[56279.930579] FS:  0000000000000000(0000) GS:ffffa2ea9f040000(0000)
knlGS:0000000000000000
[56279.979068] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[56280.013491] CR2: 00007f07ef659fe0 CR3: 00000003eaa7e000 CR4:
00000000003406e0
[56280.056253] Call Trace:
[56280.070891]  _raw_spin_lock_irqsave+0x33/0x40
[56280.096982]  __remove_mapping+0x4a/0x1e0
[56280.120469]  shrink_page_list+0xb12/0xe60
[56280.144477]  shrink_inactive_list+0x1ad/0x350
[56280.170573]  shrink_node_memcg.isra.0+0x46e/0x7b0
[56280.198747]  shrink_node+0x80/0x2e0
[56280.219631]  balance_pgdat+0x239/0x4a0
[56280.242078]  kswapd+0x165/0x2f0
[56280.260880]  ? wait_woken+0x70/0x70
[56280.281761]  kthread+0xfb/0x130
[56280.300562]  ? balance_pgdat+0x4a0/0x4a0
[56280.324052]  ? kthread_park+0x70/0x70
[56280.345980]  ret_from_fork+0x22/0x40
[56280.367383] Modules linked in: fuse mq_deadline ip6t_REJECT
nf_reject_ipv6 xt_state ip6table_filter ip6_tables
nf_conntrack_netbios_ns nf_conntrack_broadcast xt_MASQUERADE iptable_nat
nf_nat ipt_REJECT nf_reject_ipv4 xt_u32 xt_multiport xt_tcpudp
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 it87 hwmon_vid
msr iptable_filter uvcvideo videobuf2_vmalloc videobuf2_memops
snd_usb_audio videobuf2_v4l2 snd_hwdep snd_usbmidi_lib videodev
snd_hda_codec_realtek videobuf2_common snd_rawmidi cdc_acm
snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_core snd_seq
snd_seq_device snd_pcm i2c_piix4 k10temp snd_timer snd bfq evdev
acpi_cpufreq binfmt_misc ip_tables x_tables amdgpu hid_generic backlight
sr_mod gpu_sched aesni_intel ttm cdrom usbhid i2c_dev autofs4
[56280.442646] [drm] Fence fallback timer expired on ring gfx
[56280.773148] ---[ end trace 76feac8f53a00048 ]---
[56280.773152] RIP: 0010:queued_spin_lock_slowpath+0x178/0x1d0
[56280.773154] Code: 8b 45 00 48 85 c0 74 f5 48 89 c2 eb e4 c1 ea 12 83
e0 03 ff ca 48 c1 e0 04 48 63 d2 48 05 c0 ed 01 00 48 03 04 d5 20 d5 e0
b1 <48> 89 28 8b 45 08 85 c0 75 09 f3 90 8b 45 08 85 c0 74 f7 48 8b 45
[56280.773155] RSP: 0018:ffffa85240747a88 EFLAGS: 00010002
[56280.773156] RAX: 0001812dff56fe58 RBX: ffffa2e9c6690350 RCX:
0000000000000000
[56280.773157] RDX: 0000000000003199 RSI: 00000000c6690300 RDI:
ffffa2e9c6690350
[56280.773157] RBP: ffffa2ea9f05edc0 R08: 0000000000000238 R09:
0000000000000002
[56280.773158] R10: ffffa2e9c6690348 R11: ffffa2ea8b08ed80 R12:
0000000000080000
[56280.773159] R13: 0000000000000001 R14: ffffa2e9c6690350 R15:
ffffddcf0c8ad008
[56280.773160] FS:  0000000000000000(0000) GS:ffffa2ea9f040000(0000)
knlGS:0000000000000000
[56280.773160] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[56280.773161] CR2: 00007f07ef659fe0 CR3: 00000003eaa7e000 CR4:
00000000003406e0
[56280.773163] note: kswapd0[233] exited with preempt_count 1



What happened here?
Please let me know.

Kind regards,
Udo
