Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66236145280
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 11:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgAVKZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 05:25:36 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:57018 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728931AbgAVKZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:25:36 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3F12412C5CBA7696B902;
        Wed, 22 Jan 2020 18:25:33 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Wed, 22 Jan 2020 18:25:25 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <sfrench@samba.org>
CC:     <linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
        <linux-kernel@vger.kernel.org>, <chenzhou10@huawei.com>
Subject: [PATCH -next] cifs: use PTR_ERR_OR_ZERO() to simplify code
Date:   Wed, 22 Jan 2020 18:20:30 +0800
Message-ID: <20200122102030.95853-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTR_ERR_OR_ZERO contains if(IS_ERR(...)) + PTR_ERR, just use
PTR_ERR_OR_ZERO directly.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 fs/cifs/dfs_cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index 751c2fc..43c1b43 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -662,7 +662,7 @@ static int __dfs_cache_find(const unsigned int xid, struct cifs_ses *ses,
 	 */
 	if (noreq) {
 		up_read(&htable_rw_lock);
-		return IS_ERR(ce) ? PTR_ERR(ce) : 0;
+		return PTR_ERR_OR_ZERO(ce);
 	}
 
 	if (!IS_ERR(ce)) {
-- 
2.7.4

