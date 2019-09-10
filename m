Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 033F6AF12B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 20:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfIJSmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 14:42:05 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:47666 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbfIJSmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 14:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vJAeRMch7ip54W8wc3UhVFZN0MUREcLR4FPZHtlSeHo=; b=F3kG4VZua+8Qi8Sh/M8n8kd4/d
        HuXgSQsgcHQaCjMlbmdwDlrOfAS6im9RsPoB3CTVRStUhPnduMbdlPVzCd5MID0gsQrVi+IQqVhLk
        uoHLTnVSwToOI5xa4jOSZ3IX8OZGnkZZHOcHDwgegGUzAmd12IpXwvVvKQqJ4YyC9EBY=;
Received: from p200300ccff17ef007ee9d3fffe1fa246.dip0.t-ipconnect.de ([2003:cc:ff17:ef00:7ee9:d3ff:fe1f:a246] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1i7l5R-0005mG-Lg; Tue, 10 Sep 2019 20:41:57 +0200
Received: from andi by localhost with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1i7hzy-0001xi-Vb; Tue, 10 Sep 2019 17:24:07 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hns@goldelico.com
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] backlight: lm3630a: fix module aliases
Date:   Tue, 10 Sep 2019 17:23:59 +0200
Message-Id: <20190910152359.7448-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
X-Spam-Score: -1.0 (-)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devicetree aliases are missing, so that module autoloading
does not work properly.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/video/backlight/lm3630a_bl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 3b45a1733198..9d67c07db2f2 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -617,12 +617,14 @@ static const struct i2c_device_id lm3630a_id[] = {
 	{}
 };
 
+MODULE_DEVICE_TABLE(i2c, lm3630a_id);
+
 static const struct of_device_id lm3630a_match_table[] = {
 	{ .compatible = "ti,lm3630a", },
 	{ },
 };
 
-MODULE_DEVICE_TABLE(i2c, lm3630a_id);
+MODULE_DEVICE_TABLE(of, lm3630a_match_table);
 
 static struct i2c_driver lm3630a_i2c_driver = {
 	.driver = {
-- 
2.11.0

