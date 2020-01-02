Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4C012E78A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jan 2020 15:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgABOz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 09:55:26 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:50199 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728657AbgABOzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 09:55:25 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 344d252d
        for <linux-kernel@vger.kernel.org>;
        Thu, 2 Jan 2020 13:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :from:date:message-id:subject:to:cc:content-type; s=mail; bh=dyO
        6Xh/IVGP9540dVMxI8zwbkGs=; b=T4W+Klir5BBaGMD3meXAJfmfmL6HVkgPfBS
        3hfloqcaChRn5yeXO0HlOIwQRpLmvmIYHMuoCauOCpgWxTqvEQB7vnzfYNFt0S7Q
        XQwCPcIlOm7zawkZlxsRsVLYJn3WkxrHO+3CassCl9DBBIH31N0ob0OQeMUOB2Ix
        051SKWO+VBF84wfUC2QMkvEKj9S07mtgftxovp1yaxdLQld1U6FWJcDxuNLjqYUz
        N+a7nXfG2uM+6i5yKwF4u/HgPWyZpC6WDBHoMEUmBDOHeQseK+xG61/J4Xqi5ik9
        9PwOL1v4NK90zh/y5yEwPTra83+eKNyEtQCDPfMyPd5ifOFZFnQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8e621d91 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Thu, 2 Jan 2020 13:56:52 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id h9so54746204otj.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 06:55:23 -0800 (PST)
X-Gm-Message-State: APjAAAVNOYFjgb7aoBYVZ1SM+14kX256b/D+sxKZY7m/cinK0N4NGWgS
        CwzWJXosweE7M+LWeXaL1Ad1SrhIrwW5SeDWZtw=
X-Google-Smtp-Source: APXvYqx/owVFPOL0hY+m2rThLQaWTX1MS5wQ0/IUnbpb00rakcIY12BtuRlYnVeGjm61MevtcwZw0hkWTJgYEE4dLic=
X-Received: by 2002:a9d:1e88:: with SMTP id n8mr94460910otn.369.1577976922693;
 Thu, 02 Jan 2020 06:55:22 -0800 (PST)
MIME-Version: 1.0
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 2 Jan 2020 15:55:11 +0100
X-Gmail-Original-Message-ID: <CAHmME9pBFvcm7F=-Sxc5apU6JuE=1X=Omza_eMKL5qyuisTJ3g@mail.gmail.com>
Message-ID: <CAHmME9pBFvcm7F=-Sxc5apU6JuE=1X=Omza_eMKL5qyuisTJ3g@mail.gmail.com>
Subject: CONFIG_JUMP_LABEL=y on 32-bit x86 leads to intermittent qemu crashes
To:     QEMU Developers <qemu-devel@nongnu.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's an interesting crash I've seen pop up since enabling CONFIG_JUMP_LABEL=y:

[    4.716238] EIP: secure_tcp_seq+0x1e/0xa0^M
[    4.716238] Code: c1 e8 46 90 fb ff eb a2 8d 74 26 00 55 89 e5 83
ec 18 89 75 f8 89 c6 0f b7 45 08 89 5d f4 0f b7 d9 89 7d fc 89 d7 89
45 ec 3e <8d> 74 26 00 8b 4d
ec c1 e3 10 89 fa c7 04 24 d0 e3 36 c1 89 f0 09^M
[    4.716238] EAX: 000090bc EBX: 00005114 ECX: 00005114 EDX: 01f1a8c0^M
[    4.716238] ESI: 02f1a8c0 EDI: 01f1a8c0 EBP: c010bb88 ESP: c010bb70^M
[    4.716238] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00000282^M
[    4.716238] CR0: 80050033 CR2: bfcd7fb0 CR3: 00380000 CR4: 00000690^M
[    4.716238] Call Trace:^M
[    4.716238]  <SOFTIRQ>^M
[    4.716238]  tcp_v4_init_seq+0x3d/0x50^M
[    4.716238]  tcp_conn_request+0x35d/0x926^M
[    4.716238]  ? fib6_table_lookup+0xb5/0x210^M
[    4.716238]  ? ip_route_input_slow+0x864/0x900^M
...

It looks like this is:
secure_tcp_seq ->
  net_secret_init->
    net_get_random_once(&net_secret, sizeof(net_secret))
        get_random_once(&net_secret, sizeof(net_secret))
          DO_ONCE(get_random_bytes(&net_secret, sizeof(net_secret)))

Which then expands to the usual static_key logic.

I was only able to reproduce this when the host system running
`qemu-system-i386 -m 256M -smp 4 -cpu coreduo -machine q35` is under
considerable load.

Is there a TCG issue with how it handles the dynamic patching debug
instructions?

Jason
