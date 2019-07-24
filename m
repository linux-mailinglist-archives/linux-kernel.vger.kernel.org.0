Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B944572FB1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 15:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfGXNSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 09:18:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46551 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfGXNSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 09:18:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id k189so2189440pgk.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 06:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=58NE73M0r5hjm0WUUevmLq8PxtOTnsid6fgLOJ13Opg=;
        b=Xkgsa/CljPnpVUWG8yC4aP2YpnKxPeExw01tJFF5kLL1+7YSGWREw1ayN8ywjE6EdL
         QdGIKJ3LvtIjcXkimtxCJMK4vboEeadsidsv59DuJ7I4OziTp42oi5AYSTmGJNpoAcoU
         z2734i5l0O/rjiU22Q2Ej0gDDmWO92ozNMrYAQorBeEl3AXMhe1+5VN3sZdYwY7zBysi
         9fWazRPxFZE/AvWXqu8OuevHTN2yrGzukwPNQSPczO0P6csFMkLBn1iA4HncDqQ7fvvr
         WbF0rr1Uclbbnx4FAvzyXzymGJPx0ywdytB1tKFmfslNNbr4/U/Q1XNJYb1HJgn/P6hj
         gPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=58NE73M0r5hjm0WUUevmLq8PxtOTnsid6fgLOJ13Opg=;
        b=jstF+RzJwLiDKOiv27fi599CFijYYnRYlcK8LP0igMjE6Dx4eLj+M7vvylifyAr+o7
         Es4STWOmmiqM10oIVKSBSBGpelmSucdvKDdIazbR+5V71hQtqbhhpvbLBVP++h8+L5DZ
         X21oGVCR0Rvh0+Ndd8w6iqddZF1APnT/fUcZ3s4yCdJpSePo5iMSNZrUz8UN2ZmY6n0R
         tweIFTQQflovcp8zNjd5k3Fb4RvIgn9h3inVJb9AevEl7uCuHlB8Uf2VJvEmEVW5NJoH
         z2XaO/EHrq6UEXMAFHusLLqawX16QXmj+LTwTSAlh5LeoJn+ma6ETWoAaGZktGkzDdbl
         XOEQ==
X-Gm-Message-State: APjAAAWY5dLGC2ysXPvG4qVp502ZyRvF8BPbZRi3kA+a/31egJmxborQ
        yLY7VhaThA6pWWH5m6sFesrEHqSsdmY=
X-Google-Smtp-Source: APXvYqxLjLCAiJdfFzVuAB48y4E2Afr1w30QjU45qFY1v6uOzGvMXeC1FfpxJW1obUqPz7XghLSebA==
X-Received: by 2002:a17:90a:9488:: with SMTP id s8mr89946755pjo.2.1563974309961;
        Wed, 24 Jul 2019 06:18:29 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id b3sm61106388pfp.65.2019.07.24.06.18.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 06:18:29 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] tty: nozomi: Use dev_get_drvdata
Date:   Wed, 24 Jul 2019 21:18:25 +0800
Message-Id: <20190724131825.1875-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/tty/nozomi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index 3214e22e79f3..ed99948f3b7f 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -1282,7 +1282,7 @@ static void nozomi_setup_private_data(struct nozomi *dc)
 static ssize_t card_type_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
-	const struct nozomi *dc = pci_get_drvdata(to_pci_dev(dev));
+	const struct nozomi *dc = dev_get_drvdata(dev);
 
 	return sprintf(buf, "%d\n", dc->card_type);
 }
@@ -1291,7 +1291,7 @@ static DEVICE_ATTR_RO(card_type);
 static ssize_t open_ttys_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
-	const struct nozomi *dc = pci_get_drvdata(to_pci_dev(dev));
+	const struct nozomi *dc = dev_get_drvdata(dev);
 
 	return sprintf(buf, "%u\n", dc->open_ttys);
 }
-- 
2.20.1

