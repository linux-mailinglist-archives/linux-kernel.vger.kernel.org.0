Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7CC1A7EE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2019 15:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbfEKN1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 May 2019 09:27:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35525 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728559AbfEKN1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 09:27:04 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hPS1l-0003mv-9X; Sat, 11 May 2019 13:27:01 +0000
From:   Colin King <colin.king@canonical.com>
To:     Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] orangefs: remove redundant assignment to variable buffer_index
Date:   Sat, 11 May 2019 14:27:00 +0100
Message-Id: <20190511132700.4862-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable buffer_index is being initialized however this is never
read and later it is being reassigned to a new value. The initialization
is redundant and hence can be removed.

Addresses-Coverity: ("Unused Value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/orangefs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index a35c17017210..80f06ee794c5 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -52,7 +52,7 @@ ssize_t wait_for_direct_io(enum ORANGEFS_io_type type, struct inode *inode,
 	struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
 	struct orangefs_khandle *handle = &orangefs_inode->refn.khandle;
 	struct orangefs_kernel_op_s *new_op = NULL;
-	int buffer_index = -1;
+	int buffer_index;
 	ssize_t ret;
 	size_t copy_amount;
 
-- 
2.20.1

