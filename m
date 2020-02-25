Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF58316C419
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 15:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbgBYOiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 09:38:15 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33074 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729721AbgBYOiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:38:15 -0500
Received: by mail-qt1-f194.google.com with SMTP id d5so9176328qto.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 06:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=K85rzbISZ9phjPe7qHH/4r4BQnNPXo7AftTkrTSEUyg=;
        b=OSiSB30S+FpwCoVnFe4ufZ+25rEIL9+NPkxPHyt7xfEzRaVVb+JniyRS8Qpfo4WMiS
         mRgKnYcFu7TY9VuYzSBRCSYw+XN99WbOSRhXLnsuzB9dWFilpMX1uvz1Esbhl3akWBA/
         Irq7rVhMnX32uVSnN5ll9lp5sy39c2Rl/wvuKsqd7dnCsaKVT4G8t7mDxyQE6C1ScWLA
         /loulP0o7DpmVk04hkznH+UShJmAWMqy15BEzn6LsxIk9R06XXLq9Cw66RaCQUG/FNeR
         7u1VdRnULkSoD0rmuIDZBWc1SEp+yo0kBQjyHzV1ItiuNisZRSS4ENJ+RFFJuhLmKTTN
         iCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K85rzbISZ9phjPe7qHH/4r4BQnNPXo7AftTkrTSEUyg=;
        b=ZZCAhkWTpYoxENuZFu7MaJqIDzbbL6j2ijuUiAIEfXukkQBNan/zrIvEafJFBKAmum
         2xhRh8TibQg6vVCDj3KAMy/YY7GmOF8uyUOYZdgG3ReJWkG2IsulftSHrCKaRiqoG9zf
         D3Q9DTmdK5Gq4zME5e8dPuEoJu3UCVwtYG9/1PAUM9VAW44Adj7ehlEYYPIzlogMHXfM
         GubEc6sdqCT5lZ6sQgxq2534bmLxxbd6L8iZHAxFqbYAOey8FftRWl6auMVJ4CKEiSPH
         9SQEGRfb0ISUBZ+VyPKjg1fF1yIyKIPGxQQUh4jAdPabvak8EN54L5nr4A0GVCZ0QmKG
         5mjg==
X-Gm-Message-State: APjAAAXl5udPZCbnJFyn6Kvf2n4p/6GToMKrpH5kmdi2XuhCsPKZkaao
        20h7kVSGdcC5Ze5dly2t+MuvzA==
X-Google-Smtp-Source: APXvYqyJ0BZR9+pbLb0Aj+10J/A1VPEvpuu8G0xNNkjWUuaHQbs5tKZg8iXhIaGWIb1WkI6kORpKkg==
X-Received: by 2002:aed:3324:: with SMTP id u33mr52349364qtd.322.1582641492085;
        Tue, 25 Feb 2020 06:38:12 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a13sm7387061qkh.123.2020.02.25.06.38.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Feb 2020 06:38:11 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] xfs: fix an undefined behaviour in _da3_path_shift
Date:   Tue, 25 Feb 2020 09:37:57 -0500
Message-Id: <1582641477-4011-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

state->path.active could be 1 in xfs_da3_node_lookup_int() and then in
xfs_da3_path_shift() could see state->path.blk[-1].

 UBSAN: Undefined behaviour in fs/xfs/libxfs/xfs_da_btree.c:1989:14
 index -1 is out of range for type 'xfs_da_state_blk_t [5]'
 Call trace:
  dump_backtrace+0x0/0x2c8
  show_stack+0x20/0x2c
  dump_stack+0xe8/0x150
  __ubsan_handle_out_of_bounds+0xe4/0xfc
  xfs_da3_path_shift+0x860/0x86c [xfs]
  xfs_da3_node_lookup_int+0x7c8/0x934 [xfs]
  xfs_dir2_node_addname+0x2c8/0xcd0 [xfs]
  xfs_dir_createname+0x348/0x38c [xfs]
  xfs_create+0x6b0/0x8b4 [xfs]
  xfs_generic_create+0x12c/0x1f8 [xfs]
  xfs_vn_mknod+0x3c/0x4c [xfs]
  xfs_vn_create+0x34/0x44 [xfs]
  do_last+0xd4c/0x10c8
  path_openat+0xbc/0x2f4
  do_filp_open+0x74/0xf4
  do_sys_openat2+0x98/0x180
  __arm64_sys_openat+0xf8/0x170
  do_el0_svc+0x170/0x240
  el0_sync_handler+0x150/0x250
  el0_sync+0x164/0x180

Signed-off-by: Qian Cai <cai@lca.pw>
---
 fs/xfs/libxfs/xfs_da_btree.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
index 875e04f82541..0906b7748a3f 100644
--- a/fs/xfs/libxfs/xfs_da_btree.c
+++ b/fs/xfs/libxfs/xfs_da_btree.c
@@ -1986,7 +1986,11 @@ static inline int xfs_dabuf_nfsb(struct xfs_mount *mp, int whichfork)
 	ASSERT(path != NULL);
 	ASSERT((path->active > 0) && (path->active < XFS_DA_NODE_MAXDEPTH));
 	level = (path->active-1) - 1;	/* skip bottom layer in path */
-	for (blk = &path->blk[level]; level >= 0; blk--, level--) {
+
+	if (level >= 0)
+		blk = &path->blk[level];
+
+	for (; level >= 0; blk--, level--) {
 		xfs_da3_node_hdr_from_disk(dp->i_mount, &nodehdr,
 					   blk->bp->b_addr);
 
-- 
1.8.3.1

