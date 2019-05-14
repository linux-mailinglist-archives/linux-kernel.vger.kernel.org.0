Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 750DC1C126
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 06:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfENECF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 00:02:05 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37134 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfENECF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 00:02:05 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id AD89B20D4DFA; Mon, 13 May 2019 21:02:04 -0700 (PDT)
From:   longli@linuxonhyperv.com
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [PATCH 2/2] cifs:smbd Use the correct DMA direction when sending data
Date:   Mon, 13 May 2019 21:01:29 -0700
Message-Id: <1557806489-11272-2-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1557806489-11272-1-git-send-email-longli@linuxonhyperv.com>
References: <1557806489-11272-1-git-send-email-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

When sending data, use the DMA_TO_DEVICE to map buffers. Also log the number
of requests in a compounding request from upper layer.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/smbdirect.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index 251ef1223206..caac37b1de8c 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -903,7 +903,7 @@ static int smbd_create_header(struct smbd_connection *info,
 	request->sge[0].addr = ib_dma_map_single(info->id->device,
 						 (void *)packet,
 						 header_length,
-						 DMA_BIDIRECTIONAL);
+						 DMA_TO_DEVICE);
 	if (ib_dma_mapping_error(info->id->device, request->sge[0].addr)) {
 		mempool_free(request, info->request_mempool);
 		rc = -EIO;
@@ -1005,7 +1005,7 @@ static int smbd_post_send_sgl(struct smbd_connection *info,
 	for_each_sg(sgl, sg, num_sgs, i) {
 		request->sge[i+1].addr =
 			ib_dma_map_page(info->id->device, sg_page(sg),
-			       sg->offset, sg->length, DMA_BIDIRECTIONAL);
+			       sg->offset, sg->length, DMA_TO_DEVICE);
 		if (ib_dma_mapping_error(
 				info->id->device, request->sge[i+1].addr)) {
 			rc = -EIO;
@@ -2110,8 +2110,10 @@ int smbd_send(struct TCP_Server_Info *server,
 		goto done;
 	}
 
-	rqst_idx = 0;
+	log_write(INFO, "num_rqst=%d total length=%u\n",
+			num_rqst, remaining_data_length);
 
+	rqst_idx = 0;
 next_rqst:
 	rqst = &rqst_array[rqst_idx];
 	iov = rqst->rq_iov;
-- 
2.17.1

