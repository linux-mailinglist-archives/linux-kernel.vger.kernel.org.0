Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9D8E11F5BE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2019 05:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfLOE3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Dec 2019 23:29:11 -0500
Received: from m12-17.163.com ([220.181.12.17]:56501 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfLOE3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 23:29:11 -0500
X-Greylist: delayed 920 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Dec 2019 23:29:10 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=BWTdlW55hKdOTW8KL+
        CQW/awhiXtoEwWmiDZHrCF9oo=; b=Jp5FDd0TM4ln22qh+ymdnZE2HesPJI7udi
        qND8c+TSjwJ3gmLCifEQQukmCCBXkCtXqY/I/vLwvCxqnCviFMn3EP9IvtOlF5Es
        hETdN4jm+rJTVlHBkdViUiIOn2hkLQ8E0Db+A8fVe+GqSzNtGS0alAl77JeibnKU
        fmC2iK2Cg=
Received: from localhost.localdomain (unknown [59.63.206.36])
        by smtp13 (Coremail) with SMTP id EcCowACHrvnusvVdSOyfYw--.1570S4;
        Sun, 15 Dec 2019 12:13:36 +0800 (CST)
From:   xianrong_zhou@163.com
To:     dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, agk@redhat.com, snitzer@redhat.com,
        haizhou.song@transsion.com, xianrong.zhou@transsion.com,
        zhouxianrong <xianrong_zhou@163.com>,
        "yuanjiong . gao" <yuanjiong.gao@transsion.com>,
        "ruxian . feng" <ruxian.feng@transsion.com>
Subject: [PATCH] dm: shrink data blocks using bitmap for hash reading
Date:   Sun, 15 Dec 2019 12:13:22 +0800
Message-Id: <20191215041322.7874-1-xianrong_zhou@163.com>
X-Mailer: git-send-email 2.17.2
X-CM-TRANSID: EcCowACHrvnusvVdSOyfYw--.1570S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF1rGry8Xr1DGr1fZFW3GFg_yoW8GFWUpa
        4jvryY9r18GFW7Wa13ZF1xZF15CaykGFW2kry7W3s5ZF90krWSqw1DtrW3uFW7tFZxXrZI
        vF43ZrWUCa1qvFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b6q2NUUUUU=
X-Originating-IP: [59.63.206.36]
X-CM-SenderInfo: h0ld02prqjs6xkrxqiywtou0bp/1tbiQBCMz1SIdpGMJAAAsA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhouxianrong <xianrong_zhou@163.com>

If check_at_most_once enabled, just like verity work,
the prefetching work should check for data block bitmap
firstly before reading hash block as well.This can reduce
99.28% data blocks which need not to read hash blocks.

The reduced data blocks would be enlarged again by cluster
reading later.

Signed-off-by: zhouxianrong <xianrong_zhou@163.com>
Signed-off-by: yuanjiong.gao <yuanjiong.gao@transsion.com>
Signed-off-by: ruxian.feng <ruxian.feng@transsion.com>
---
 drivers/md/dm-verity-target.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 4fb33e7562c5..fe4c15a0723c 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -581,6 +581,23 @@ static void verity_prefetch_io(struct work_struct *work)
 	struct dm_verity *v = pw->v;
 	int i;
 
+	if (v->validated_blocks) {
+		while (pw->n_blocks) {
+			if (unlikely(!test_bit(pw->block, v->validated_blocks)))
+				break;
+			pw->block++;
+			pw->n_blocks--;
+		}
+		while (pw->n_blocks) {
+			if (unlikely(!test_bit(pw->block + pw->n_blocks - 1,
+				v->validated_blocks)))
+				break;
+			pw->n_blocks--;
+		}
+		if (!pw->n_blocks)
+			return;
+	}
+
 	for (i = v->levels - 2; i >= 0; i--) {
 		sector_t hash_block_start;
 		sector_t hash_block_end;
-- 
2.17.2


