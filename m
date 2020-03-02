Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 236F717554C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 09:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbgCBIQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 03:16:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:56660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgCBIQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:16:19 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA24D2468E;
        Mon,  2 Mar 2020 08:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583136979;
        bh=nV63mygbqIlSdEuAeS3jerQtFEfh0JoRk5ZMKUB4pXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QXD22tW/qnOXfPLw6y8YrXC4N0eoMS9JIEg28/vuj8gA/BqPHSvbeqsz2Bdvm6N7I
         rEqNxqXK9BbEQsHgoIqfCoFoxIvF1qAZfTlwsm1Dzwjyy0tvQIQksbuj6gG1okZUnP
         tZ+bhiHvBZryj1lBo9pb3/IvKTizcdHUD9AHcm38=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8gFN-0003wj-04; Mon, 02 Mar 2020 09:16:17 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 01/42] Add an empty index file for SCSI documents
Date:   Mon,  2 Mar 2020 09:15:34 +0100
Message-Id: <4d8c1b7ebe5898ac4a8265ca5e5a9552da3b426f.1583136624.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1583136624.git.mchehab+huawei@kernel.org>
References: <cover.1583136624.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding the SCSI documents to the documentation
body, add an empty index for it.

The next patches should be adding contents to it, as files get
converted to ReST format.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/index.rst      |  1 +
 Documentation/scsi/index.rst | 10 ++++++++++
 2 files changed, 11 insertions(+)
 create mode 100644 Documentation/scsi/index.rst

diff --git a/Documentation/index.rst b/Documentation/index.rst
index e99d0bd2589d..d39fd2c9f1ce 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -130,6 +130,7 @@ needed).
    bpf/index
    usb/index
    PCI/index
+   scsi/index
    misc-devices/index
    mic/index
    scheduler/index
diff --git a/Documentation/scsi/index.rst b/Documentation/scsi/index.rst
new file mode 100644
index 000000000000..16baf8b0f11f
--- /dev/null
+++ b/Documentation/scsi/index.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================
+Linux SCSI Subsystem
+====================
+
+.. toctree::
+   :maxdepth: 1
+
+
-- 
2.21.1

