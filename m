Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 579E6F01DB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 16:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389987AbfKEPtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 10:49:08 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36338 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389506AbfKEPtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:49:07 -0500
Received: by mail-pg1-f195.google.com with SMTP id k13so3193780pgh.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 07:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Da4uiaQj7qVMKa9oAKwCKH6uxJg0bHesNrE0BWHWXgs=;
        b=hfnreEuHEVOOB4GYxQpvcNt/tzK2jHW/3WicKvVvnoECbhjeTfvJ/jRVCXoVfoFwBD
         gh3UoJbBuR7BW388M6JzkvjPJo2P5gMEmdXXbL+SX8wCS5HtPQrU/DpxQE9Zdy1IwEIE
         1W5uG/KdoyUy7Fi5vrMI7VVqu6PlqCGu3nFAWomVbU1FMzmiEHTzyHi22EsDOKKw5+SF
         Qa5pv5rX9fsLm2x6BIIKMypZFT1b+/p8/K7NeOe0eH67JQqWtbbNe206u4qYMuQmI+bT
         S+Qrk8fyhuiVjq25M8dNkPU4DSGtRkZC2HIhmgERALnPAzLclCK6Xs4xtXg4zi8e/Oos
         QU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Da4uiaQj7qVMKa9oAKwCKH6uxJg0bHesNrE0BWHWXgs=;
        b=GmuUhalIXm+iPgGntlb7nUs/cXawg+naW70hKpmUWUObPcEwjQUANeCb8GRMGkhQO9
         a9BvCmuUIPxevazVdgQxqqL/NakDBhwQDOPNSQC+b71FZPxj+GKR75CIGp2wxp3hERH2
         VKVReP3QtkjgXJQUMa7K/jzW1PxmdvuL711TU7QgvNLNGfIuNe0FRkAq1aVUMDiL1MNx
         w/+cZ5K2c1ynZt6J5jddiXqd6ztk/ASDArWbamLxlsQB0z/+bF08VWJ5kr4U7ZMgejDG
         ThNiCvYzF3e0EwphQqPJ9nejTj6d3x5U3rwBb7PdtQC2VHffOJqfEGU0S04C/zsxFpeq
         cJVQ==
X-Gm-Message-State: APjAAAXf71IHtAogt7SUqoF2poCFwN1fMSXRb+efqWspH9w7HkJUbWtt
        9UQqRBtpMfmVL08OchrTKFyT3s3JloK0fA==
X-Google-Smtp-Source: APXvYqw6TT6h4xdMnSvvaN4taYhNyZSJ66DjuT/Lvx+weHFctd/pnh6xoc71B6HDMJiRTUZW/XU+Sw==
X-Received: by 2002:a63:5966:: with SMTP id j38mr36959501pgm.304.1572968945118;
        Tue, 05 Nov 2019 07:49:05 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id f189sm29671326pgc.94.2019.11.05.07.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 07:49:04 -0800 (PST)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>,
        linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        linux-afs@lists.infradead.org, Jan Kara <jack@suse.cz>
Subject: [PATCH] afs: xattr: use scnprintf
Date:   Tue,  5 Nov 2019 07:48:44 -0800
Message-Id: <20191105154850.187723-1-salyzyn@android.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sprintf and snprintf are fragile in future maintenance, switch to
using scnprintf to ensure no accidental Use After Free conditions
are introduced.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>
Cc: linux-afs@lists.infradead.org
Cc: Jan Kara <jack@suse.cz>
---
 fs/afs/xattr.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/afs/xattr.c b/fs/afs/xattr.c
index 5552d034090a..7af41fd5f3ee 100644
--- a/fs/afs/xattr.c
+++ b/fs/afs/xattr.c
@@ -228,11 +228,11 @@ static int afs_xattr_get_yfs(const struct xattr_handler *handler,
 		break;
 	case 1:
 		data = buf;
-		dsize = snprintf(buf, sizeof(buf), "%u", yacl->inherit_flag);
+		dsize = scnprintf(buf, sizeof(buf), "%u", yacl->inherit_flag);
 		break;
 	case 2:
 		data = buf;
-		dsize = snprintf(buf, sizeof(buf), "%u", yacl->num_cleaned);
+		dsize = scnprintf(buf, sizeof(buf), "%u", yacl->num_cleaned);
 		break;
 	case 3:
 		data = yacl->vol_acl->data;
@@ -370,13 +370,15 @@ static int afs_xattr_get_fid(const struct xattr_handler *handler,
 	/* The volume ID is 64-bit, the vnode ID is 96-bit and the
 	 * uniquifier is 32-bit.
 	 */
-	len = sprintf(text, "%llx:", vnode->fid.vid);
+	len = scnprintf(text, sizeof(text), "%llx:", vnode->fid.vid);
 	if (vnode->fid.vnode_hi)
-		len += sprintf(text + len, "%x%016llx",
-			       vnode->fid.vnode_hi, vnode->fid.vnode);
+		len += scnprintf(text + len, sizeof(text) - len, "%x%016llx",
+				vnode->fid.vnode_hi, vnode->fid.vnode);
 	else
-		len += sprintf(text + len, "%llx", vnode->fid.vnode);
-	len += sprintf(text + len, ":%x", vnode->fid.unique);
+		len += scnprintf(text + len, sizeof(text) - len, "%llx",
+				 vnode->fid.vnode);
+	len += scnprintf(text + len, sizeof(text) - len, ":%x",
+			 vnode->fid.unique);
 
 	if (size == 0)
 		return len;
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

