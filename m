Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD1DC17678D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 23:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgCBWkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 17:40:13 -0500
Received: from ms.lwn.net ([45.79.88.28]:59698 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgCBWkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 17:40:10 -0500
Received: from meer.lwn.net (localhost [127.0.0.1])
        by ms.lwn.net (Postfix) with ESMTPA id 7D4809B1;
        Mon,  2 Mar 2020 22:40:09 +0000 (UTC)
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 3/3] docs: move core-api/ioctl.rst to driver-api/
Date:   Mon,  2 Mar 2020 15:39:57 -0700
Message-Id: <20200302223957.905473-4-corbet@lwn.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200302223957.905473-1-corbet@lwn.net>
References: <20200302223957.905473-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ioctl() documentation belongs with the rest of the driver-oriented
info, so move it there.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/core-api/index.rst                 | 1 -
 Documentation/driver-api/index.rst               | 1 +
 Documentation/{core-api => driver-api}/ioctl.rst | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/{core-api => driver-api}/ioctl.rst (100%)

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 9836a0ac09a3..0897ad12c119 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -102,7 +102,6 @@ Documents that don't fit elsewhere or which have yet to be categorized.
    :maxdepth: 1
 
    librs
-   ioctl
 
 .. only:: subproject and html
 
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index ea3003b3c5e5..1d8c5599149b 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -17,6 +17,7 @@ available subsections can be seen below.
    driver-model/index
    basics
    infrastructure
+   ioctl
    early-userspace/index
    pm/index
    clk
diff --git a/Documentation/core-api/ioctl.rst b/Documentation/driver-api/ioctl.rst
similarity index 100%
rename from Documentation/core-api/ioctl.rst
rename to Documentation/driver-api/ioctl.rst
-- 
2.24.1

