Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81C11148B16
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 16:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389030AbgAXPRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 10:17:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:34230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387796AbgAXPR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 10:17:27 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCCE022527;
        Fri, 24 Jan 2020 15:17:26 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1iv0i5-000qFA-MU; Fri, 24 Jan 2020 10:17:25 -0500
Message-Id: <20200124151725.578551157@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 24 Jan 2020 10:17:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Colin Ian King <colin.king@canonical.com>
Subject: [for-next][PATCH 09/14] tools: bootconfig: Fix spelling mistake "faile" -> "failed"
References: <20200124151651.852781301@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are two spelling mistakes in printf statements, fix these.

Link: http://lkml.kernel.org/r/20200116092206.52192-1-colin.king@canonical.com

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/bootconfig/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index b8f174fd2a0a..91c9a5c0c499 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -140,7 +140,7 @@ int load_xbc_from_initrd(int fd, char **buf)
 		return 0;
 
 	if (lseek(fd, -8, SEEK_END) < 0) {
-		printf("Faile to lseek: %d\n", -errno);
+		printf("Failed to lseek: %d\n", -errno);
 		return -errno;
 	}
 
@@ -155,7 +155,7 @@ int load_xbc_from_initrd(int fd, char **buf)
 		return 0;
 
 	if (lseek(fd, stat.st_size - 8 - size, SEEK_SET) < 0) {
-		printf("Faile to lseek: %d\n", -errno);
+		printf("Failed to lseek: %d\n", -errno);
 		return -errno;
 	}
 
-- 
2.24.1


