Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF84115AC3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2019 03:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfLGChr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 21:37:47 -0500
Received: from sonic306-21.consmr.mail.gq1.yahoo.com ([98.137.68.84]:34578
        "EHLO sonic306-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726371AbfLGChq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 21:37:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1575686265; bh=82fzkijXm+n6ft45Y/RezXKrtgCgFJ4irkLCD48yicI=; h=From:To:Cc:Subject:Date:References:From:Subject; b=oJKZjJPRAYh0vPLgNNsI/2IAydnH367tI2U+36+YuwDLDUJWYEbYyKtCuGZO3UoCOiRdNoTyvyk7Y0xIYkZvuZwHoPmaCVB3eav8291ycZn/E2nwYii/0qn4uuOmqtHq4HAq5UpvQ8MoMxVnKk8IPB1rzC7JoWJsLR+7TLg8m6TpYE4Uk/qBpHRGeFA8oeoA0xAbQygHcn4xOAm9mwxu/zQOHzU11zqEXpU8L0muCVWy4j4ju6hD/By96UO0o6CrOPOG6xWIRQsdjP12ILHc/q7PJAE7gnNKDPHcWU5C8VeJmmzk2jcHZAw2ETFdb35avIIwxfYj8ij+l3wP5BHYNg==
X-YMail-OSG: rO6V5FEVM1k6K6ElIjpcjIX2knF0W_YgA6UeOpsGVrbXgW97bgNZ70IFTDP7dg8
 Yhb2mq6.mtantepFIlwlDfL8DZyB1uZZSALICyb3CiRtkqiwOsCN2f1YOTawBMNcj_ZJ1sX0S8FF
 vVDvICv6TXnpBmmIK.eonpIl3oDf8jxzxQ.CXCOkiSGp11iLg0JlqMIH_fni1umzZKKYuRG7TLp6
 LDkHbqcBaZ53xw0cET1OVhaWw7q7lfz2aHYHAuDumn6Wo7e5cCxzAdAt4sQej_G5aZ5XucwLgNgb
 tQRA2UaCnaU9XJJk5bdTwyMznM.z4u632504yHdEje1Fm.1xXVgma_P4UDMjJf6kcj_BTscjqZee
 FscJjQ_FG4xBbSQdKcqxR_fJ6FhG2dyrrftmRcnkYb0_f6ven9arMaZF3lfF0fIIgHW7Gao0Q5xU
 rUsPjJvJQTtosOUXdYcEMpMCxc5rTGd18NeJCADfGTsELnmm9fytx8e.GZxdJDuztupsDWgvOd1a
 QNo8LtnB_YAwmS1JWfE3L1KQybLwBdLFnZK5eWOeqxQjkK3NDS2WcXQZc_KfQJ..CuRQs2Xxdx3V
 RC32hHN83OqwheH7wnfIPPOBpkF42I6j0hFVgv9PcD0tNe8pNQ.TXGU7x1fCKZDRFlxA1hQCggFO
 _6tbJrI8lyYXu7vFz6RAmj7mk1DZOH3Un02NvpuX.gPUi_C.gvrU_VUBvNfCzmMKF_U1TFaI1ZQI
 PDFJ6RpOCGm8_lOoAdnEX7jwNILqJBMIz1jD11SuAVe3Ma6GLNpOACkBw8OpH4jpWTlVanygF2Uy
 h5OdlHd2sidz67qLPU2.oQQRBLbEB2c7v_cklriWqNIv2KrpDL9jP01.19PBFQIIdoJmWqjjYdvr
 QKVCWyGzoKXMH3PEUB9Mku8aAwuK_3hk9DZwCJLj9yE8BaRhBTqK4GZkn4I7FvDkvztbokZXTAB7
 oQhzY5j.igVthLmAYdsyGj03lrvz7PbMVADc1MST6iAbCBKqtozEkO5UEwqdsj.ktYeGfRHVqca.
 zpoFPD95u4u0pszo6LYFtCKZ83_lcwa99i6Qcp8gPKe.qWsYImikU3MJGMKufpEBaMvSadcByfke
 M3LSA1KsBR_cf4HE3Ezg1AZsYkPMTwXmxrhINhW7Yl99RZn7IanjjsK2cRsUFu1x3lfY8QPGaseV
 MznkbZ3hGNIDqaxWlCnd7.R25sG6.OmclfhowPEff40dmTrUGJAM.YS5aHmmYupr.fPXcxW9fPEN
 uVxtXiAkNW5oPNPHORZJwCTDE1DrLV.rg_C.I8ZxZNDETx_iq39G3iJgKS.qsz7MUWDhncZnMYnn
 x9PBHJJgMwiENyDm9LB9uS72QwsQY8ONrkVvWPMrxIQPPj2ZWY9ppXQFMKaD5R9Q_WLgZ1YDSRz0
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Sat, 7 Dec 2019 02:37:45 +0000
Received: by smtp408.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2c993444cd13115bc8db15969c606d3b;
          Sat, 07 Dec 2019 02:37:40 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     Chao Yu <chao@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-erofs@lists.ozlabs.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH] erofs: update documentation
Date:   Sat,  7 Dec 2019 10:37:26 +0800
Message-Id: <20191207023726.5359-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20191207023726.5359-1-hsiangkao.ref@aol.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

Some on-disk structures, fields have been renamed in v5.4,
the corresponding document should be updated as well.

Also fix misrespresentation of file time and words about
fixed-sized output compression, data inline, etc.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
Hi,

I plan to update documentation together with
https://lore.kernel.org/r/20191201084040.29275-1-hsiangkao@aol.com/
for this round.

Comments about this are greatly welcomed.

Thanks,
Gao Xiang

 Documentation/filesystems/erofs.txt | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/Documentation/filesystems/erofs.txt b/Documentation/filesystems/erofs.txt
index b0c085326e2e..061eb8bd8387 100644
--- a/Documentation/filesystems/erofs.txt
+++ b/Documentation/filesystems/erofs.txt
@@ -24,11 +24,11 @@ Here is the main features of EROFS:
  - Metadata & data could be mixed by design;
 
  - 2 inode versions for different requirements:
-                          v1            v2
+                          compact (v1)  extended (v2)
    Inode metadata size:   32 bytes      64 bytes
    Max file size:         4 GB          16 EB (also limited by max. vol size)
    Max uids/gids:         65536         4294967296
-   File creation time:    no            yes (64 + 32-bit timestamp)
+   File change time:      no            yes (64 + 32-bit timestamp)
    Max hardlinks:         65536         4294967296
    Metadata reserved:     4 bytes       14 bytes
 
@@ -39,7 +39,7 @@ Here is the main features of EROFS:
  - Support POSIX.1e ACLs by using xattrs;
 
  - Support transparent file compression as an option:
-   LZ4 algorithm with 4 KB fixed-output compression for high performance;
+   LZ4 algorithm with 4 KB fixed-sized output compression for high performance.
 
 The following git tree provides the file system user-space tools under
 development (ex, formatting tool mkfs.erofs):
@@ -85,7 +85,7 @@ All data areas should be aligned with the block size, but metadata areas
 may not. All metadatas can be now observed in two different spaces (views):
  1. Inode metadata space
     Each valid inode should be aligned with an inode slot, which is a fixed
-    value (32 bytes) and designed to be kept in line with v1 inode size.
+    value (32 bytes) and designed to be kept in line with compact inode size.
 
     Each inode can be directly found with the following formula:
          inode offset = meta_blkaddr * block_size + 32 * nid
@@ -117,10 +117,10 @@ may not. All metadatas can be now observed in two different spaces (views):
                                                        |-> aligned with 4B
 
     Inode could be 32 or 64 bytes, which can be distinguished from a common
-    field which all inode versions have -- i_advise:
+    field which all inode versions have -- i_format:
 
         __________________               __________________
-       |     i_advise     |             |     i_advise     |
+       |     i_format     |             |     i_format     |
        |__________________|             |__________________|
        |        ...       |             |        ...       |
        |                  |             |                  |
@@ -129,12 +129,13 @@ may not. All metadatas can be now observed in two different spaces (views):
                                         |__________________| 64 bytes
 
     Xattrs, extents, data inline are followed by the corresponding inode with
-    proper alignes, and they could be optional for different data mappings,
-    _currently_ there are totally 3 valid data mappings supported:
+    proper alignment, and they could be optional for different data mappings.
+    _currently_ total 4 valid data mappings are supported:
 
-     1) flat file data without data inline (no extent);
-     2) fixed-output size data compression (must have extents);
-     3) flat file data with tail-end data inline (no extent);
+     0   flat file data without data inline (no extent);
+     1   fixed-sized output data compression (with non-compacted indexes);
+     2   flat file data with tail packing data inline (no extent);
+     3   fixed-sized output data compression (with compacted indexes).
 
     The size of the optional xattrs is indicated by i_xattr_count in inode
     header. Large xattrs or xattrs shared by many different files can be
@@ -182,8 +183,8 @@ introduce another on-disk field at all.
 
 Compression
 -----------
-Currently, EROFS supports 4KB fixed-output clustersize transparent file
-compression, as illustrated below:
+Currently, EROFS supports 4KB fixed-sized output transparent file compression,
+as illustrated below:
 
          |---- Variant-Length Extent ----|-------- VLE --------|----- VLE -----
          clusterofs                      clusterofs            clusterofs
-- 
2.20.1

