Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0595F31035
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 16:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfEaOan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 10:30:43 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:57169 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726555AbfEaOan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 10:30:43 -0400
Received: from [109.168.11.45] (port=37380 helo=pc-ceresoli.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.91)
        (envelope-from <luca@lucaceresoli.net>)
        id 1hWiYI-00GxC2-0F; Fri, 31 May 2019 16:30:38 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH] docs: clk: fix struct syntax
Date:   Fri, 31 May 2019 16:30:16 +0200
Message-Id: <20190531143016.23185-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clk_foo_ops struct example has syntax errors. Fix it so it can be
copy-pasted and used more easily.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 Documentation/driver-api/clk.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/clk.rst b/Documentation/driver-api/clk.rst
index 593cca5058b1..3cad45d14187 100644
--- a/Documentation/driver-api/clk.rst
+++ b/Documentation/driver-api/clk.rst
@@ -175,9 +175,9 @@ the following::
 To take advantage of your data you'll need to support valid operations
 for your clk::
 
-	struct clk_ops clk_foo_ops {
-		.enable		= &clk_foo_enable;
-		.disable	= &clk_foo_disable;
+	struct clk_ops clk_foo_ops = {
+		.enable		= &clk_foo_enable,
+		.disable	= &clk_foo_disable,
 	};
 
 Implement the above functions using container_of::
-- 
2.21.0

