Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBF62BC08D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 04:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408912AbfIXC7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 22:59:48 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:25078 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394625AbfIXC7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 22:59:47 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13]) by rmmx-syy-dmz-app11-12011 (RichMail) with SMTP id 2eeb5d898685fb4-ecbb4; Tue, 24 Sep 2019 10:59:17 +0800 (CST)
X-RM-TRANSID: 2eeb5d898685fb4-ecbb4
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee75d898681c29-75784;
        Tue, 24 Sep 2019 10:59:16 +0800 (CST)
X-RM-TRANSID: 2ee75d898681c29-75784
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] remoteproc: debug: Remove unneeded NULL check
Date:   Tue, 24 Sep 2019 10:58:54 +0800
Message-Id: <1569293934-31451-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs_remove_recursive will do NULL check, so remove
the redundant null check

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/remoteproc/remoteproc_debugfs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
index 8cd4a0a..dd93cf0 100644
--- a/drivers/remoteproc/remoteproc_debugfs.c
+++ b/drivers/remoteproc/remoteproc_debugfs.c
@@ -333,9 +333,6 @@ struct dentry *rproc_create_trace_file(const char *name, struct rproc *rproc,
 
 void rproc_delete_debug_dir(struct rproc *rproc)
 {
-	if (!rproc->dbg_dir)
-		return;
-
 	debugfs_remove_recursive(rproc->dbg_dir);
 }
 
-- 
1.9.1



