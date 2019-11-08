Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86225F59FC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 22:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732783AbfKHVdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 16:33:52 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:52815 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731765AbfKHVdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:33:52 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MSswA-1iLzYt2E18-00UGxO; Fri, 08 Nov 2019 22:33:37 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Carmeli Tamir <carmeli.tamir@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH 02/16] fat: use prandom_u32() for i_generation
Date:   Fri,  8 Nov 2019 22:32:40 +0100
Message-Id: <20191108213257.3097633-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191108213257.3097633-1-arnd@arndb.de>
References: <20191108213257.3097633-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xyMkheBDOQ2yaVVntEHgn9uUv1eZLDi2PHuV/3eFCHO8p5lovZV
 RSePDEWBDJbgngLzGRALBZfJl5JOc/Jtxuyr7QiT/iBCBbjdZJGTSgC2IvsTsu/G8Wrk8Qp
 GiN6kRR+nPbTe/wfuUTgyPddaHuqJCxUZ4XE1/4ITyS+2pjP8u0UFcA4cFLt8YYwP57kCQJ
 fk91hJAfaQeU9TGvmYShw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DJ2s+pQ7k9s=:/y5VLXzDEQnWFAeSQ6xOT6
 CQnsEi8h6oR3+uq3G21bQgEahitqAHnJmT2KNTIAE8E657mVB3N+hZQ9MTvbAybhVKnqHNHNR
 idT/3YENYmr7+Njvqjjc5RlZUQ7KJ/Xv+472f1SMhcd4wTbzZ9Q+ZvYWq2DeXrpC93sVDUloQ
 I32eSBkZX/7ZdDfCUxAp0B+IIwql1HylbLmE5hP6xhaB/uFKE2x5CE9Ua89bKlPpuSBg0HWki
 zHAbhuWTY2ZKkVv/X0MMYPM6aKf2kNzBxAAltGfZ+eRS3mu2lwNR9W3LZZEiUUfBB7+iSfVzW
 /jxxhOSksfm3m7CthVRll/a6vzheR2WY6N5z2p2DsAmenRm83oq8O6BEfhrAjxj0gXmpAzR5w
 kraqdJ2wHUtKHYL4l5I/PgR4ZwVw6/3tEyql+pwkXSEbvxGyGWxSdpEluEBbekv2jL394ePX+
 uMs9A3kzqjXQRDuahnIHfvYhfryebO84fKl/Cf6TpkqZwxIpYkK1ivI8m6E8GXYxLB8d5YhKR
 MAYuH+Ji89DIFPRilXJPMotaHackTxXkzFWYwbl5fO1Rr0yxPGxDzQq/DS98nCPNLFyKvhFxK
 HlJSfzSdE58tDYScQrsLPnu7A/z5bKPzaq3SCdjqAFtYaHj0HNAe0dOSSVfXjulvXmrGEpsMX
 cinqux25sQ19OjeTolQIXEge/FzmqODBKtBdAXBzhY64ukP5DvhJxTWMjNcYsylJhppWeRbmY
 +qRFjY/JlKmmqmFeFZGMG/qAbOSmXB16SupBJmoVWfFYh5zRUzZUrPMStqqrRK95Z0H5qj/qB
 g7stPBh+VKB1WFBmPVWW/pvdNqHEn/Zqhh14UaYRUD/jI6qp9qeqL+r6hhd+ITpG67/O+Hsas
 q+8rrmNsLbzj3POPuP2w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit 46c9a946d766 ("shmem: use monotonic time for i_generation")
we should not use the deprecated get_seconds() interface for i_generation.

prandom_u32() is the replacement used in other file systems.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/fat/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 5f04c5c810fb..594b05ae16c9 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -21,6 +21,7 @@
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <asm/unaligned.h>
+#include <linux/random.h>
 #include <linux/iversion.h>
 #include "fat.h"
 
@@ -521,7 +522,7 @@ int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
 	inode->i_uid = sbi->options.fs_uid;
 	inode->i_gid = sbi->options.fs_gid;
 	inode_inc_iversion(inode);
-	inode->i_generation = get_seconds();
+	inode->i_generation = prandom_u32();
 
 	if ((de->attr & ATTR_DIR) && !IS_FREE(de->name)) {
 		inode->i_generation &= ~1;
-- 
2.20.0

