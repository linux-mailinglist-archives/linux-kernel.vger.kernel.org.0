Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60F9C191169
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 14:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgCXNnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 09:43:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727495AbgCXNnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:43:19 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86860206F6;
        Tue, 24 Mar 2020 13:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585057398;
        bh=cL0BLqma9/afGrVRw6wv2HjXvWZfwS9SlngDwmWrnZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z+UApu2F6o3fqfffxQlFQEi2twFUB/nWLlk/5W7AOz/gxgKfAU1g/jHw9j0U4AVKf
         Ln7OFg01E4hNlvM2uYI3hhz8/s2L/cPnAhpSxXKPIAsPLd2JkIkXsYmF+HqGePHvqX
         WacO988G8I3UuEv0W84zW3k7mUSqxa1EHCAhIR/M=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jGjps-0025r1-Kv; Tue, 24 Mar 2020 14:43:16 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v2 05/20] media: Kconfig: update the MEDIA_SUPPORT help message
Date:   Tue, 24 Mar 2020 14:42:58 +0100
Message-Id: <d3634df983d2db9052bb09808b683791981e1b3f.1585057134.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1585057134.git.mchehab+huawei@kernel.org>
References: <cover.1585057134.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more things than just cameras and TV devices on
media. Update the help message accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index 586d8931d9fc..18dea82d76d7 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -18,8 +18,10 @@ menuconfig MEDIA_SUPPORT
 	tristate "Multimedia support"
 	depends on HAS_IOMEM
 	help
-	  If you want to use Webcams, Video grabber devices and/or TV devices
-	  enable this option and other options below.
+	  If you want to use media devices, including Webcams, Video grabber
+	  devices and/or TV devices, V4L2 codecs, etc, enable this option
+	  and other options below.
+
 	  Additional info and docs are available on the web at
 	  <https://linuxtv.org>
 
-- 
2.24.1

