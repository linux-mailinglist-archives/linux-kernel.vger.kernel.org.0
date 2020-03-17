Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C51E2187705
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 01:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733134AbgCQApY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 20:45:24 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53802 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733005AbgCQApX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 20:45:23 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 47A2528AE2F
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jdike@addtoit.com
Cc:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Martyn Welch <martyn.welch@collabora.com>
Subject: [PATCH 1/2] um: ubd: Prevent buffer overrun on command completion
Date:   Mon, 16 Mar 2020 20:45:06 -0400
Message-Id: <20200317004507.1513370-2-krisman@collabora.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200317004507.1513370-1-krisman@collabora.com>
References: <20200317004507.1513370-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the hypervisor side, when completing commands and the pipe is full,
we retry writing only the entries that failed, by offsetting
io_req_buffer, but we don't reduce the number of bytes written, which
can cause a buffer overrun of io_req_buffer, and write garbage to the
pipe.

Cc: Martyn Welch <martyn.welch@collabora.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 arch/um/drivers/ubd_kern.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 6627d7c30f37..0f5d0a699a49 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1606,7 +1606,9 @@ int io_thread(void *arg)
 		written = 0;
 
 		do {
-			res = os_write_file(kernel_fd, ((char *) io_req_buffer) + written, n);
+			res = os_write_file(kernel_fd,
+					    ((char *) io_req_buffer) + written,
+					    n - written);
 			if (res >= 0) {
 				written += res;
 			}
-- 
2.25.0

