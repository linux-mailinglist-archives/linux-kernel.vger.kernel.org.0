Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0703859B77
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 14:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfF1Mai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 08:30:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39060 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfF1Mah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MSf6WYg3rPynf1ed5KWX3InGKFXb2jdSCBsFjVpKoa4=; b=bEeZlsB0ifTLt4MRr+YUN9A1ai
        OAmYJXQFnvtz9Jlkv29vpkFU41FLeWXTfZQEX1CrUvjVgmjv2s2J5hunI53llEqwobtmg/yE+KIDb
        bRsVf4+LZkuH1JJG6kEx51tdUrsOraECb8JObAumFVe7+PUKTMI0Zq938IENczByFNbxg1nUciiDy
        r+IWNc/zFLVBM0Zw/uKZzlrEwZaoaTuuMO8i9h8Ogys1Ulg86nE9CxUax/FIYWEXBOvQ+E1E93NsI
        O02KJt3yS2C3rJIVNUj8HWZNv+oMntJuSbnYIHV5tFPjT+qs/d9DZHgvtSe8cRR8g+ffQRNgc058/
        U/pSDIUQ==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgq1U-000555-4R; Fri, 28 Jun 2019 12:30:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgq1S-0005Ri-6f; Fri, 28 Jun 2019 09:30:34 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 10/39] docs: leds: add it to the driver-api book
Date:   Fri, 28 Jun 2019 09:30:03 -0300
Message-Id: <9b50fb4c160ee1cc7a5d98f5a77d4688a9ab70f5.1561724493.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561724493.git.mchehab+samsung@kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The contents of leds driver docs is messy: it has lots of
admin-guide stuff and kernel internal ones, just like other
driver subsystems.

I'm opting to keep the dir at the same place and just add
a link to it. This makes clearer that this require changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/index.rst      | 1 +
 Documentation/leds/index.rst | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 2f9bf37b8989..3a17a621896c 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -91,6 +91,7 @@ needed).
 
    driver-api/index
    core-api/index
+   leds/index
    media/index
    networking/index
    input/index
diff --git a/Documentation/leds/index.rst b/Documentation/leds/index.rst
index 9885f7c1b75d..060f4e485897 100644
--- a/Documentation/leds/index.rst
+++ b/Documentation/leds/index.rst
@@ -1,4 +1,4 @@
-:orphan:
+.. SPDX-License-Identifier: GPL-2.0
 
 ====
 LEDs
-- 
2.21.0

