Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A37EBCAEF3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 21:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387490AbfJCTJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 15:09:35 -0400
Received: from ms.lwn.net ([45.79.88.28]:33722 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729464AbfJCTJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 15:09:31 -0400
Received: from meer.lwn.net (localhost [127.0.0.1])
        by ms.lwn.net (Postfix) with ESMTPA id AF974740;
        Thu,  3 Oct 2019 19:09:30 +0000 (UTC)
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 2/2] docs: Move the user-space ioctl() docs to userspace-api
Date:   Thu,  3 Oct 2019 13:09:21 -0600
Message-Id: <20191003190921.5141-3-corbet@lwn.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191003190921.5141-1-corbet@lwn.net>
References: <20191003190921.5141-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is strictly user-space material at this point, so put it with the
other user-space API documentation.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/index.rst                                    | 1 -
 Documentation/userspace-api/index.rst                      | 1 +
 Documentation/{ => userspace-api}/ioctl/cdrom.rst          | 0
 Documentation/{ => userspace-api}/ioctl/hdio.rst           | 0
 Documentation/{ => userspace-api}/ioctl/index.rst          | 0
 Documentation/{ => userspace-api}/ioctl/ioctl-decoding.rst | 0
 Documentation/{ => userspace-api}/ioctl/ioctl-number.rst   | 0
 7 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/{ => userspace-api}/ioctl/cdrom.rst (100%)
 rename Documentation/{ => userspace-api}/ioctl/hdio.rst (100%)
 rename Documentation/{ => userspace-api}/ioctl/index.rst (100%)
 rename Documentation/{ => userspace-api}/ioctl/ioctl-decoding.rst (100%)
 rename Documentation/{ => userspace-api}/ioctl/ioctl-number.rst (100%)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index b843e313d2f2..dbf0951a0abe 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -57,7 +57,6 @@ the kernel interface as seen by application developers.
    :maxdepth: 2
 
    userspace-api/index
-   ioctl/index
 
 
 Introduction to kernel development
diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index ad494da40009..e983488b48b1 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -21,6 +21,7 @@ place where this information is gathered.
    unshare
    spec_ctrl
    accelerators/ocxl
+   ioctl/index
 
 .. only::  subproject and html
 
diff --git a/Documentation/ioctl/cdrom.rst b/Documentation/userspace-api/ioctl/cdrom.rst
similarity index 100%
rename from Documentation/ioctl/cdrom.rst
rename to Documentation/userspace-api/ioctl/cdrom.rst
diff --git a/Documentation/ioctl/hdio.rst b/Documentation/userspace-api/ioctl/hdio.rst
similarity index 100%
rename from Documentation/ioctl/hdio.rst
rename to Documentation/userspace-api/ioctl/hdio.rst
diff --git a/Documentation/ioctl/index.rst b/Documentation/userspace-api/ioctl/index.rst
similarity index 100%
rename from Documentation/ioctl/index.rst
rename to Documentation/userspace-api/ioctl/index.rst
diff --git a/Documentation/ioctl/ioctl-decoding.rst b/Documentation/userspace-api/ioctl/ioctl-decoding.rst
similarity index 100%
rename from Documentation/ioctl/ioctl-decoding.rst
rename to Documentation/userspace-api/ioctl/ioctl-decoding.rst
diff --git a/Documentation/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
similarity index 100%
rename from Documentation/ioctl/ioctl-number.rst
rename to Documentation/userspace-api/ioctl/ioctl-number.rst
-- 
2.21.0

