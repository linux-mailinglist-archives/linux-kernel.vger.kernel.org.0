Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADB4911A67E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 10:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfLKJL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 04:11:28 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44607 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbfLKJL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:11:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id d199so1480098pfd.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 01:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=clN4DZ1+UzZ8X2+xnLk0rPl0nRDgP4NWoUukx7osbdw=;
        b=aPSG7JoWCAdyw1wBNQ0w4sI9pX6XrOeEDHMDtr7JYmGiXyfntBvIPcOmrQabyctr2S
         8oYrpYA9ngfb1x36uv5EOfSzc7f54jPfl1QLhnKurOV2D5bTL6TrcoWfuZiYqQxqc65w
         RjTyYAJmxblhquQjD1fu31x6W0CVrPOcrrlNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=clN4DZ1+UzZ8X2+xnLk0rPl0nRDgP4NWoUukx7osbdw=;
        b=Em8J0XdpnUVjx7wE+aFwZD1sSzx8MOwDGdqtb/fffRyRmasrgiFIDHlGu1eJZT07r8
         ALZ0Katk14WB5n5ZDzy07IzAXpqg+yIQYFxEcFggF8pnSm/aLAg3vBnHlR1biMET7I73
         bHM4hpHy7I4v5IC4JupwNgtzwMuV3BVTXtrkHo9MgPPmoNFZxglNn7kVkh8PqgMSQqel
         gh16EG9NUm33Mye2IUqRrJf3qfGm/P5Ajwr568SyzSjpgR8GwhtZXejdM6SbrD3tKpkS
         FpGFpDWlOIrtKvre4r03vA33bdl9xV99Ypfgs+q8TW0Wrh2adEr9Dv5gUzYhNhTBlROK
         fIyw==
X-Gm-Message-State: APjAAAW6i76m8YQov87wPMbIZ/slhy1+yrV4CyFjOgM5BnE7UjWtkGST
        zbJrkWKyZne41kHn3K7irmAamg==
X-Google-Smtp-Source: APXvYqxP1CFPPOVd0xjT+TIWrmflIBJlnchwj32/k9sp3Jr/v3tHlGkFrFjdZ9TLtugXmzmlGYJivg==
X-Received: by 2002:a63:504f:: with SMTP id q15mr2962436pgl.8.1576055485667;
        Wed, 11 Dec 2019 01:11:25 -0800 (PST)
Received: from brooklyn.i.sslab.ics.keio.ac.jp (sslab-relay.ics.keio.ac.jp. [131.113.126.173])
        by smtp.googlemail.com with ESMTPSA id y62sm2201092pfg.45.2019.12.11.01.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 01:11:25 -0800 (PST)
From:   Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Cc:     keitasuzuki.park@sslab.ics.keio.ac.jp,
        takafumi.kubota1012@sslab.ics.keio.ac.jp, naohiro.aota@wdc.com,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] block/genhd: Fix memory leak in error path of __alloc_disk_node()
Date:   Wed, 11 Dec 2019 09:10:49 +0000
Message-Id: <20191211091049.11080-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191127024057.5827-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
References: <20191127024057.5827-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'disk->part_tbl' is malloced in disk_expand_part_tbl() and should be
freed before leaving from the error handling cases. However, current code
does not free this, causing a memory leak. Add disk_replace_part_tbl()
before freeing 'disk'.

I have tested this by randomly causing failures to the target code,
and verified on kmemleak that this memory leak does occur.

unreferenced object 0xffff888006dad500 (size 64):
  comm "systemd-udevd", pid 116, jiffies 4294895558 (age 121.716s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000eec79bf3>] disk_expand_part_tbl+0xab/0x170
    [<00000000624e7d03>] __alloc_disk_node+0xb1/0x1c0
    [<00000000ca3f4185>] 0xffffffffc01b8584
    [<000000006f88a6ee>] do_one_initcall+0x8b/0x2a4
    [<0000000016058199>] do_init_module+0xfd/0x380
    [<00000000b6fde336>] load_module+0x3fae/0x4240
    [<00000000c523d013>] __do_sys_finit_module+0x11a/0x1b0
    [<00000000f07bba26>] do_syscall_64+0x6d/0x1e0
    [<00000000979467fd>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: 6c71013ecb7e ("block: partition: convert percpu ref")

Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 block/genhd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/genhd.c b/block/genhd.c
index ff6268970ddc..8c4b63d7f507 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1504,6 +1504,7 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 		 */
 		seqcount_init(&disk->part0.nr_sects_seq);
 		if (hd_ref_init(&disk->part0)) {
+			disk_replace_part_tbl(disk, NULL);
 			hd_free_part(&disk->part0);
 			kfree(disk);
 			return NULL;
-- 
2.17.1

