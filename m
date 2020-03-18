Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5E11894B6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 04:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgCRD7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 23:59:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11716 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726682AbgCRD7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 23:59:31 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8E4C28FB8D73FE15242A;
        Wed, 18 Mar 2020 11:59:27 +0800 (CST)
Received: from [127.0.0.1] (10.173.223.48) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Wed, 18 Mar 2020
 11:59:20 +0800
From:   Yilu Lin <linyilu@huawei.com>
Subject: [PATCH] CIFS: Fix bug which the return value by asynchronous read is
 error
To:     <linux-cifs@vger.kernel.org>, Steve French <sfrench@samba.org>,
        <samba-technical@lists.samba.org>, <linux-kernel@vger.kernel.org>,
        <alex.chen@huawei.com>
Message-ID: <ef49e240-fc8f-9eb4-af98-26bfd39104aa@huawei.com>
Date:   Wed, 18 Mar 2020 11:59:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.223.48]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is used to fix the bug in collect_uncached_read_data()
that rc is automatically converted from a signed number to an
unsigned number when the CIFS asynchronous read fails.
It will cause ctx->rc is error.

Example:
Share a directory and create a file on the Windows OS.
Mount the directory to the Linux OS using CIFS.
On the CIFS client of the Linux OS, invoke the pread interface to
deliver the read request.

The size of the read length plus offset of the read request is greater
than the maximum file size.

In this case, the CIFS server on the Windows OS returns a failure
message (for example, the return value of
smb2.nt_status is STATUS_INVALID_PARAMETER).

After receiving the response message, the CIFS client parses
smb2.nt_status to STATUS_INVALID_PARAMETER
and converts it to the Linux error code (rdata->result=-22).

Then the CIFS client invokes the collect_uncached_read_data function to
assign the value of rdata->result to rc, that is, rc=rdata->result=-22.

The type of the ctx->total_len variable is unsigned integer,
the type of the rc variable is integer, and the type of
the ctx->rc variable is ssize_t.

Therefore, during the ternary operation, the value of rc is
automatically converted to an unsigned number. The final result is
ctx->rc=4294967274. However, the expected result is ctx->rc=-22.

Signed-off-by: Yilu Lin <linyilu@huawei.com>
---
 fs/cifs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 022029a5d..ff4ac244c 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3323,7 +3323,7 @@ again:
 	if (rc == -ENODATA)
 		rc = 0;

-	ctx->rc = (rc == 0) ? ctx->total_len : rc;
+	ctx->rc = (rc == 0) ? (ssize_t)ctx->total_len : rc;

 	mutex_unlock(&ctx->aio_mutex);

-- 
2.19.1


