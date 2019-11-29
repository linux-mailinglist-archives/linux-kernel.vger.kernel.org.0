Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82A7310D060
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2019 02:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfK2Bhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 20:37:53 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36066 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfK2Bhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 20:37:52 -0500
Received: by mail-pj1-f66.google.com with SMTP id n96so1342701pjc.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 17:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k3v9fPmWBvPWOvk0SjUoi4f+APOY7zLlhiQMCyWJoH8=;
        b=erTACxUD1Kt3C9eaiEpltWhj1WInSir/xn0VsOuiEQX/pyXUZ7DuQzxBRnMdhH4evB
         NLUKZ45k7V+j8TbI4mhm/4AVtGxnR7M16uLkyfVv8zF2a8swgCYUpRwphykj1uhdPZyc
         LQ2hFAbKEttOytooysFhBXcQiVMkt8xT5oOQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k3v9fPmWBvPWOvk0SjUoi4f+APOY7zLlhiQMCyWJoH8=;
        b=rQ2lSmAP1PT17mFtUlzc/JpHrnIPMC/RgugtZqjeo2XJsvrPiaStFTikAKyYASSONB
         HR/cwp4JD4BvgkRvzenWL4TgMWz+Fi6/I6C2aZdR/Hc4Jed4PQn0QaS8y08YUgRBV2GM
         MLEz22tJYFsW8AW9qMdoA996bZ9HuqJ9xfIyQkgxyMR9EfaBA7TXNFW5lyTn43hSaUpT
         hJrzLwAFiqBRtFQDEmppiN7PD+uw8RMGGXS9EB7swwdobwDHSgXZHYTnQ05Hn5D3Vtah
         ludoPriLpE1FDdXI0EIwMnc6Xny3gUULivlWqTtMnthkpKza/eVTCDlZTvA2okd3FY4v
         TfPQ==
X-Gm-Message-State: APjAAAVHMtwmtpQpDy+DmQkfWlvYXL6AM/eL0+rbAPi7mWyVozVtIXs8
        ym7rvJYu2mW06IOIgYMwtKgRZHOYhg8=
X-Google-Smtp-Source: APXvYqw559/nrItIpXQo+aum94P8JTRI4qBdChHdQQz6QBllmcOTS5Kgy+G3u+tLSdbfyoBFXfeZtg==
X-Received: by 2002:a17:902:8f98:: with SMTP id z24mr12544679plo.35.1574991470396;
        Thu, 28 Nov 2019 17:37:50 -0800 (PST)
Received: from localhost (2001-44b8-111e-5c00-a4ac-b85f-e5f8-ea9e.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:a4ac:b85f:e5f8:ea9e])
        by smtp.gmail.com with ESMTPSA id h5sm5418014pfk.30.2019.11.28.17.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 17:37:49 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     akash.goel@intel.com, ajd@linux.ibm.com,
        Daniel Axtens <dja@axtens.net>,
        syzbot+1e925b4b836afe85a1c6@syzkaller-ppc64.appspotmail.com,
        syzbot+587b2421926808309d21@syzkaller-ppc64.appspotmail.com,
        syzbot+58320b7171734bf79d26@syzkaller.appspotmail.com,
        syzbot+d6074fb08bdb2e010520@syzkaller.appspotmail.com
Subject: [PATCH] relay: handle alloc_percpu returning NULL in relay_open
Date:   Fri, 29 Nov 2019 12:37:45 +1100
Message-Id: <20191129013745.7168-1-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_percpu() may return NULL, which means chan->buf may be set to
NULL. In that case, when we do *per_cpu_ptr(chan->buf, ...), we
dereference an invalid pointer:

BUG: Unable to handle kernel data access at 0x7dae0000
Faulting instruction address: 0xc0000000003f3fec
...
NIP [c0000000003f3fec] relay_open+0x29c/0x600
LR [c0000000003f3fc0] relay_open+0x270/0x600
Call Trace:
[c000000054353a70] [c0000000003f3fb4] relay_open+0x264/0x600 (unreliable)
[c000000054353b00] [c000000000451764] __blk_trace_setup+0x254/0x600
[c000000054353bb0] [c000000000451b78] blk_trace_setup+0x68/0xa0
[c000000054353c10] [c0000000010da77c] sg_ioctl+0x7bc/0x2e80
[c000000054353cd0] [c000000000758cbc] do_vfs_ioctl+0x13c/0x1300
[c000000054353d90] [c000000000759f14] ksys_ioctl+0x94/0x130
[c000000054353de0] [c000000000759ff8] sys_ioctl+0x48/0xb0
[c000000054353e20] [c00000000000bcd0] system_call+0x5c/0x68

Check if alloc_percpu returns NULL. Because we can readily catch and
handle this situation, switch to alloc_cpu_gfp and pass in __GFP_NOWARN.

This was found by syzkaller both on x86 and powerpc, and the reproducer
it found on powerpc is capable of hitting the issue as an unprivileged
user.

Fixes: 017c59c042d0 ("relay: Use per CPU constructs for the relay channel buffer pointers")
Reported-by: syzbot+1e925b4b836afe85a1c6@syzkaller-ppc64.appspotmail.com
Reported-by: syzbot+587b2421926808309d21@syzkaller-ppc64.appspotmail.com
Reported-by: syzbot+58320b7171734bf79d26@syzkaller.appspotmail.com
Reported-by: syzbot+d6074fb08bdb2e010520@syzkaller.appspotmail.com
Cc: Akash Goel <akash.goel@intel.com>
Cc: Andrew Donnellan <ajd@linux.ibm.com> # syzkaller-ppc64
Cc: stable@vger.kernel.org # v4.10+
Signed-off-by: Daniel Axtens <dja@axtens.net>

--

There's a syz reproducer on the powerpc syzbot that eventually hits
the bug, but it can take up to an hour or so before it keels over on a
kernel with all the syzkaller debugging on, and even longer on a
production kernel. I have been able to reproduce it once on a stock
Ubuntu 5.0 ppc64le kernel.

I will ask MITRE for a CVE - while only the process doing the syscall
gets killed, it gets killed while holding the relay_channels_mutex,
so it blocks all future relay activity.
---
 kernel/relay.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/relay.c b/kernel/relay.c
index ade14fb7ce2e..a376cc6b54ec 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -580,7 +580,13 @@ struct rchan *relay_open(const char *base_filename,
 	if (!chan)
 		return NULL;
 
-	chan->buf = alloc_percpu(struct rchan_buf *);
+	chan->buf = alloc_percpu_gfp(struct rchan_buf *,
+				     GFP_KERNEL | __GFP_NOWARN);
+	if (!chan->buf) {
+		kfree(chan);
+		return NULL;
+	}
+
 	chan->version = RELAYFS_CHANNEL_VERSION;
 	chan->n_subbufs = n_subbufs;
 	chan->subbuf_size = subbuf_size;
-- 
2.20.1

