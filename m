Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEB0F4C5B4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 05:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbfFTDLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 23:11:46 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:35600 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfFTDLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 23:11:46 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id A345F72CC64;
        Thu, 20 Jun 2019 06:11:44 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 895497CCE2E; Thu, 20 Jun 2019 06:11:44 +0300 (MSK)
Date:   Thu, 20 Jun 2019 06:11:44 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] samples: make pidfd-metadata fail gracefully on older kernels
Message-ID: <20190620031144.GA32182@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize pidfd to an invalid descriptor, to fail gracefully on
those kernels that do not implement CLONE_PIDFD and leave pidfd
unchanged.

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 samples/pidfd/pidfd-metadata.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/samples/pidfd/pidfd-metadata.c b/samples/pidfd/pidfd-metadata.c
index 14b454448429..ff109fdac3a5 100644
--- a/samples/pidfd/pidfd-metadata.c
+++ b/samples/pidfd/pidfd-metadata.c
@@ -83,7 +83,7 @@ static int pidfd_metadata_fd(pid_t pid, int pidfd)
 
 int main(int argc, char *argv[])
 {
-	int pidfd = 0, ret = EXIT_FAILURE;
+	int pidfd = -1, ret = EXIT_FAILURE;
 	char buf[4096] = { 0 };
 	pid_t pid;
 	int procfd, statusfd;
@@ -91,7 +91,11 @@ int main(int argc, char *argv[])
 
 	pid = pidfd_clone(CLONE_PIDFD, &pidfd);
 	if (pid < 0)
-		exit(ret);
+		err(ret, "CLONE_PIDFD");
+	if (pidfd < 0) {
+		warnx("CLONE_PIDFD is not supported by the kernel");
+		goto out;
+	}
 
 	procfd = pidfd_metadata_fd(pid, pidfd);
 	close(pidfd);
-- 
ldv
