Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9D0CAEF5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 21:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387579AbfJCTJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 15:09:39 -0400
Received: from ms.lwn.net ([45.79.88.28]:33710 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732733AbfJCTJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 15:09:31 -0400
Received: from meer.lwn.net (localhost [127.0.0.1])
        by ms.lwn.net (Postfix) with ESMTPA id 5A7077C0;
        Thu,  3 Oct 2019 19:09:30 +0000 (UTC)
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/2] docs: move botching-up-ioctls.rst to the process guide
Date:   Thu,  3 Oct 2019 13:09:20 -0600
Message-Id: <20191003190921.5141-2-corbet@lwn.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191003190921.5141-1-corbet@lwn.net>
References: <20191003190921.5141-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is overall information for kernel developers, and not part of the
user-space API.

Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/ioctl/index.rst                           | 1 -
 Documentation/{ioctl => process}/botching-up-ioctls.rst | 0
 Documentation/process/index.rst                         | 1 +
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/{ioctl => process}/botching-up-ioctls.rst (100%)

diff --git a/Documentation/ioctl/index.rst b/Documentation/ioctl/index.rst
index 0f0a857f6615..475675eae086 100644
--- a/Documentation/ioctl/index.rst
+++ b/Documentation/ioctl/index.rst
@@ -9,7 +9,6 @@ IOCTLs
 
    ioctl-number
 
-   botching-up-ioctls
    ioctl-decoding
 
    cdrom
diff --git a/Documentation/ioctl/botching-up-ioctls.rst b/Documentation/process/botching-up-ioctls.rst
similarity index 100%
rename from Documentation/ioctl/botching-up-ioctls.rst
rename to Documentation/process/botching-up-ioctls.rst
diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index e2c9ffc682c5..e2c2cdaa93fa 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -57,6 +57,7 @@ lack of a better place.
    adding-syscalls
    magic-number
    volatile-considered-harmful
+   botching-up-ioctls
    clang-format
 
 .. only::  subproject and html
-- 
2.21.0

