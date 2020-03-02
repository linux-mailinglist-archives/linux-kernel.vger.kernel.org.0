Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEFC1755B8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 09:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgCBISg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 03:18:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:57202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727194AbgCBIQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:16:21 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C319246E2;
        Mon,  2 Mar 2020 08:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583136979;
        bh=Wsekl1TItVvD3INJBbJmeaHL8C61RFnhJoja63XF3zA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=baLPp7dUT1VRau+gkYzv1kLgn4sFkgTEX0DN9u/QE7zuFzE9uiOh1k4orY3yFtVwn
         g0Xo3geIpWNq+a9qh9rxu+poUVIidpmVJy/PDGZnsh877k3RRRiWQ9difIIcPuKnQO
         pL/AgIQjTM4fPBkGt8exOR80Nxbn0Lhl0FB1OtTQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8gFN-0003yD-IS; Mon, 02 Mar 2020 09:16:17 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 21/42] docs: scsi: convert lpfc.txt to ReST
Date:   Mon,  2 Mar 2020 09:15:54 +0100
Message-Id: <48c13184b77ba61ed4fd7c235816fdb8e7530664.1583136624.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1583136624.git.mchehab+huawei@kernel.org>
References: <cover.1583136624.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/scsi/index.rst              |  1 +
 Documentation/scsi/{lpfc.txt => lpfc.rst} | 16 +++++++---------
 2 files changed, 8 insertions(+), 9 deletions(-)
 rename Documentation/scsi/{lpfc.txt => lpfc.rst} (93%)

diff --git a/Documentation/scsi/index.rst b/Documentation/scsi/index.rst
index c40050ac3b32..22427511e227 100644
--- a/Documentation/scsi/index.rst
+++ b/Documentation/scsi/index.rst
@@ -25,5 +25,6 @@ Linux SCSI Subsystem
    hptiop
    libsas
    link_power_management_policy
+   lpfc
 
    scsi_transport_srp/figures
diff --git a/Documentation/scsi/lpfc.txt b/Documentation/scsi/lpfc.rst
similarity index 93%
rename from Documentation/scsi/lpfc.txt
rename to Documentation/scsi/lpfc.rst
index 5741ea8aa88a..6e217e82b9b9 100644
--- a/Documentation/scsi/lpfc.txt
+++ b/Documentation/scsi/lpfc.rst
@@ -1,10 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
 
-LPFC Driver Release Notes:
+=========================
+LPFC Driver Release Notes
+=========================
 
-=============================================================================
 
-
-                               IMPORTANT:
+.. important::
 
   Starting in the 8.0.17 release, the driver began to be targeted strictly
   toward the upstream kernel. As such, we removed #ifdefs for older kernels
@@ -22,9 +23,6 @@ LPFC Driver Release Notes:
   Please heed these dependencies....
 
 
-   ********************************************************************
-
-
 The following information is provided for additional background on the
 history of the driver as we push for upstream acceptance.
 
@@ -64,6 +62,7 @@ Cable pull and temporary device Loss:
 
 
 Kernel Support
+==============
 
   This source package is targeted for the upstream kernel only. (See notes
   at the top of this file). It relies on interfaces that are slowing
@@ -77,7 +76,6 @@ Kernel Support
 
 
 Patches
+=======
 
   Thankfully, at this time, patches are not needed.
-
-
-- 
2.21.1

