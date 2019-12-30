Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3CB12D19D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Dec 2019 16:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfL3Pz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Dec 2019 10:55:28 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:42395 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfL3Pz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 10:55:27 -0500
Received: by mail-yb1-f193.google.com with SMTP id z10so6888361ybr.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 07:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=58VefUNI1Hj0F9zlhiCoQzCFKomrgTvZEEVdE1v+Dik=;
        b=QvQsPTvFPAHEl8kd1fAlobXt7Yynz7ZVbroAE0f67rZRUxnllntgsohzrRVExGbpqB
         FeK+cfAAPwJkyP8TF2x3VNv27DQ+mpYpCe/BvCtLb/8uz1+3oZWc2dvTNs1jNli9qTjs
         okxHr8Boi6PmgUawTXoNacswcwGNos68qHRqQwMHs6FuSo4Nei7TeiWq9xT6s4z7Pr9S
         FaGDW7f9yzkwQK8hZIt277cdlADpt8fQ53Ag2feILHT10cGI7h7/ZXS6MZiaa28Uz+0J
         xa1f0on8LtbvPpzmrEizFHe8sBiEK7CcWeJkSrVYgEPfOPse0VlLTVUMBIEq208O3m/5
         aS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=58VefUNI1Hj0F9zlhiCoQzCFKomrgTvZEEVdE1v+Dik=;
        b=omyA831p6XhbjnIwwK4MdZTs9J8RvtG+ofMAvfgwTzwmu1KIdnhMyR54g22K6D/2Uh
         l2RZz2qqfZys77kZf9SBiDbuum80/ng8UCL608YJZcltbnvZ70dLs2OoQs3oJSKg7sRP
         NKolEAOUwblry1TjhzxrHLPBdo5gsIqVeESbDmHm53KztBUQEyKcHjBl12EZAE4ZYup6
         alTK4Pa1egk6hclTGyovctdv/dhcdtAcJb61ZHZjTQyoa0rNLUGksLSjzukKxW0TYo/j
         8WRzBwu1u9NrkM3sJ5t/Ou41FhcxuklBopusjf7IZjSj0UHpstNSpzeWhdnxcRu9tfzn
         iz7w==
X-Gm-Message-State: APjAAAUXYKx+klduHQ2KuDeHrlpvm1RNLk+oYqp1Jn1LOYYXLl3ZcDZz
        zVDgXK8R4tb4+FeINSCr8J8=
X-Google-Smtp-Source: APXvYqz7Wfq8q5/eX3xpAkHdK9OcfDn258qbUVwjItfx3qwK0uhs/97g2chZpHq8xEWL2dCVATtg5Q==
X-Received: by 2002:a25:bfca:: with SMTP id q10mr46486462ybm.223.1577721326827;
        Mon, 30 Dec 2019 07:55:26 -0800 (PST)
Received: from user-ThinkPad-X230 ([2601:cd:4005:d680:598a:ed33:1bb1:b28a])
        by smtp.gmail.com with ESMTPSA id m30sm18008899ywh.12.2019.12.30.07.55.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Dec 2019 07:55:26 -0800 (PST)
Date:   Mon, 30 Dec 2019 10:55:20 -0500
From:   Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
To:     "forest@alittletooquiet.net>" <gregkh@linuxfoundation.org>,
        quentin.deslandes@itdev.co.uk, indigoomega021@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6656: remove unnecessary parenthesis
Message-ID: <20191230155520.GA27072@user-ThinkPad-X230>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parenthesis to abide by kernel
coding-style.

Signed-off-by: Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
---
 drivers/staging/vt6656/baseband.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/baseband.c
index 8d19ae71e7cc..25fb19fadc57 100644
--- a/drivers/staging/vt6656/baseband.c
+++ b/drivers/staging/vt6656/baseband.c
@@ -381,8 +381,8 @@ int vnt_vt3184_init(struct vnt_private *priv)
 
 	dev_dbg(&priv->usb->dev, "RF Type %d\n", priv->rf_type);
 
-	if ((priv->rf_type == RF_AL2230) ||
-	    (priv->rf_type == RF_AL2230S)) {
+	if (priv->rf_type == RF_AL2230 ||
+	    priv->rf_type == RF_AL2230S) {
 		priv->bb_rx_conf = vnt_vt3184_al2230[10];
 		length = sizeof(vnt_vt3184_al2230);
 		addr = vnt_vt3184_al2230;
@@ -461,8 +461,8 @@ int vnt_vt3184_init(struct vnt_private *priv)
 	if (ret)
 		goto end;
 
-	if ((priv->rf_type == RF_VT3226) ||
-	    (priv->rf_type == RF_VT3342A0)) {
+	if (priv->rf_type == RF_VT3226 ||
+	    priv->rf_type == RF_VT3342A0) {
 		ret = vnt_control_out_u8(priv, MESSAGE_REQUEST_MACREG,
 					 MAC_REG_ITRTMSET, 0x23);
 		if (ret)
-- 
2.17.1

