Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFEFF795C4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 21:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390028AbfG2Tpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 15:45:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389209AbfG2Tpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:45:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41771217D4;
        Mon, 29 Jul 2019 19:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429549;
        bh=FM6vvuUXPW62pbJVaulANSqvApoEDIWBFygeeUxo9vU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sXBz1ZV/J8hYaNsmjdlgIy8DBtDCv7RgkemA53zs2ZUTKdvON/YCSxsCYcP0sS6pQ
         +qlHKmydFdPLgOOSQjnh44tLZ+Zarh77rXUMOOcElXsFi17W2xk1H88KovzaQGifOg
         NbacBk5a3TNepSAl8gLm/Kca4UNigOpxeaTxDmuY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 5.2 002/215] media: drivers: media: coda: fix warning same module names
Date:   Mon, 29 Jul 2019 21:19:58 +0200
Message-Id: <20190729190740.264792750@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190739.971253303@linuxfoundation.org>
References: <20190729190739.971253303@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anders Roxell <anders.roxell@linaro.org>

commit 1296987d2baf7f56748359b8dd42c425b9e7ee3a upstream.

When building with CONFIG_VIDEO_CODA and CONFIG_CODA_FS enabled as
loadable modules, we see the following warning:

  fs/coda/coda.ko
  drivers/media/platform/coda/coda.ko

Rework so media/platform/coda is named coda-vpu. Leaving CODA_FS as is
since that's a well known module.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/coda/Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/media/platform/coda/Makefile
+++ b/drivers/media/platform/coda/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 ccflags-y += -I$(src)
 
-coda-objs := coda-common.o coda-bit.o coda-gdi.o coda-h264.o coda-jpeg.o
+coda-vpu-objs := coda-common.o coda-bit.o coda-gdi.o coda-h264.o coda-jpeg.o
 
-obj-$(CONFIG_VIDEO_CODA) += coda.o
+obj-$(CONFIG_VIDEO_CODA) += coda-vpu.o
 obj-$(CONFIG_VIDEO_IMX_VDOA) += imx-vdoa.o


