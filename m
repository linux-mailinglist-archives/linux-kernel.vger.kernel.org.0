Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACF2187706
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 01:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733167AbgCQAp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 20:45:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53812 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733005AbgCQAp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 20:45:27 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 403CF283BEE
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jdike@addtoit.com
Cc:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Martyn Welch <martyn.welch@collabora.com>
Subject: [PATCH 2/2] um: ubd: Retry buffer read on any kind of error
Date:   Mon, 16 Mar 2020 20:45:07 -0400
Message-Id: <20200317004507.1513370-3-krisman@collabora.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200317004507.1513370-1-krisman@collabora.com>
References: <20200317004507.1513370-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Should bulk_req_safe_read return an error, we want to retry the read,
otherwise, even though no IO will be done, os_write_file might still end
up writing garbage to the pipe.

Cc: Martyn Welch <martyn.welch@collabora.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 arch/um/drivers/ubd_kern.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 0f5d0a699a49..d259f0728003 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1591,11 +1591,11 @@ int io_thread(void *arg)
 			&io_remainder_size,
 			UBD_REQ_BUFFER_SIZE
 		);
-		if (n < 0) {
-			if (n == -EAGAIN) {
+		if (n <= 0) {
+			if (n == -EAGAIN)
 				ubd_read_poll(-1);
-				continue;
-			}
+
+			continue;
 		}
 
 		for (count = 0; count < n/sizeof(struct io_thread_req *); count++) {
-- 
2.25.0

