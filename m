Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5246F59B03
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 14:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfF1Mav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 08:30:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39528 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbfF1Mao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QMM4exs7jud05s0t69omyAIGb8+3B6KryCpeIhHj/mA=; b=o6ZWTuP6HJ36VTCdvwqZNCY8AK
        FwOqU6RUn7uRNWKdTCImCLr3Azrv/XKoufsC9HKmJwwpPEB4aYkTILDHtULA4kenSWzr9PhQCdrGi
        gGKt0Wuy6ondeZHp5RRcP8u2ZxpPB+U9pcNZbfJtQxhvNLaPgmiYVQExmq1SHUiGplXzpI7AdS3gF
        ngHUQazrNIhwamf5y+FQT4E983TpzFISXlkKS+AFv76wZTjJdXMC6d1Bg0uBwll+mIWoCTB9r81Pc
        gir0GHRIveCwoTR9Jlt5+KQ+JWCXzdafMGtrmbXCvQa+gL5jocEzRmV1LIPuf0xt8yRJyW+l9/IaE
        Gj50BO+Q==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgq1U-00055i-MT; Fri, 28 Jun 2019 12:30:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgq1S-0005TJ-No; Fri, 28 Jun 2019 09:30:34 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 30/39] docs: driver-api: add xilinx driver API documentation
Date:   Fri, 28 Jun 2019 09:30:23 -0300
Message-Id: <b587333d0add640d6dc73f1b5f276521b0d5fd8d.1561724493.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561724493.git.mchehab+samsung@kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current file there (emmi) provides a description of
the driver uAPI and kAPI.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/driver-api/index.rst              | 1 +
 Documentation/{ => driver-api}/xilinx/eemi.rst  | 0
 Documentation/{ => driver-api}/xilinx/index.rst | 1 -
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/{ => driver-api}/xilinx/eemi.rst (100%)
 rename Documentation/{ => driver-api}/xilinx/index.rst (94%)

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index bba01cb95162..0bc5f2e3b98b 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -93,6 +93,7 @@ available subsections can be seen below.
    sync_file
    vfio-mediated-device
    vfio
+   xilinx/index
    xillybus
    zorro
 
diff --git a/Documentation/xilinx/eemi.rst b/Documentation/driver-api/xilinx/eemi.rst
similarity index 100%
rename from Documentation/xilinx/eemi.rst
rename to Documentation/driver-api/xilinx/eemi.rst
diff --git a/Documentation/xilinx/index.rst b/Documentation/driver-api/xilinx/index.rst
similarity index 94%
rename from Documentation/xilinx/index.rst
rename to Documentation/driver-api/xilinx/index.rst
index 01cc1a0714df..13f7589ed442 100644
--- a/Documentation/xilinx/index.rst
+++ b/Documentation/driver-api/xilinx/index.rst
@@ -1,4 +1,3 @@
-:orphan:
 
 ===========
 Xilinx FPGA
-- 
2.21.0

