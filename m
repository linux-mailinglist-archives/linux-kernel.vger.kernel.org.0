Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC1812D430
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Dec 2019 20:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfL3T4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Dec 2019 14:56:16 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33258 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfL3T4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 14:56:16 -0500
Received: by mail-ed1-f67.google.com with SMTP id r21so33700843edq.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 11:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gO16AQCkNPb14dsCdpkNOICcLP4HpRwvIVTrCALZZko=;
        b=fzz92Rr5ad/tw0dAyXatXMplVhuQTUMwBoHdS2zFzvNq3breMRsKrqsAxDoCTQvjpj
         WB5JiebaJGU/chwFRmjzZtX66Re6Rm3vCKvnP2CwjjzBa3yQBa7X3ve2scCY/dC9ljry
         VJoXuBqYtHvYc2PtO3mdZDZcuEGoGUQigwd0u1XguvL8OcAP2WYRTjUbUeGFMwe3gmgh
         rOMNHL58k4ZYkEcc7vFiYn3vjtOcnLzwJ6yLVpWjnTGmvagFT0WvPI7Gc8DMp+R3rMms
         g5+qwkh3pwPpRsSJpRA4BQPwL2prIzuXHCjXa6IH9NViXz6mr2cZsL8ckh8YsSL4Hq2z
         DdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gO16AQCkNPb14dsCdpkNOICcLP4HpRwvIVTrCALZZko=;
        b=cfEMkUTKQFMrXVhTQnu4ByvTfdksgiVtF0E9aQx+MzlDEHJQDlEoVb2GjnCf1JjbQN
         9Yx3XUT7ekBp+8smyV2uybuy0M0MwYi8liAAxskqNyn14TdVr7AxaxpXGJixiGtOZHKO
         PQf4NwSJvT594vQqrJhO1HIrAEvnjgsFXfNcmnPhJw5uE17DczKcupg2specq/KMrg6O
         BjqTQViTDZkAEnQItTabfZ80i8qPSAjAuvX7c/97zmh9K/B4IXtT6Reb7AZlj7EetJK0
         9a/3elifsw4lrIzkh+VTyozni/inQ/gAoNK3CtimMKBfldxToYnOHjMYmXWAsIcW074X
         ZTQA==
X-Gm-Message-State: APjAAAVD4XqPn9/BXMhJT23rNCQcl6Hc4BbwTMp6CnKSTMLZZRI1p1nH
        jsD+ApIAQbPB/rkS/qKaGak=
X-Google-Smtp-Source: APXvYqyK9+yOm7EZSKgP1CIAOwXYYE/RZODwwHNa9cFvR2LrqE+OdolaLn4Q9Fr4gSKqnvbUjJbFkA==
X-Received: by 2002:a05:6402:3184:: with SMTP id di4mr73253173edb.59.1577735774170;
        Mon, 30 Dec 2019 11:56:14 -0800 (PST)
Received: from localhost.localdomain ([197.254.95.38])
        by smtp.googlemail.com with ESMTPSA id ba29sm5446185edb.47.2019.12.30.11.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 11:56:13 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel: declare variable as __be16
Date:   Mon, 30 Dec 2019 22:56:09 +0300
Message-Id: <20191230195609.12386-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declare the temp variable as __be16 to address the following sparse
warning:
drivers/gpu/drm/panel/panel-lg-lg4573.c:45:20: warning: incorrect type in initializer (different base types)
drivers/gpu/drm/panel/panel-lg-lg4573.c:45:20:    expected unsigned short [unsigned] [usertype] temp
drivers/gpu/drm/panel/panel-lg-lg4573.c:45:20:    got restricted __be16 [usertype] <noident>

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/panel/panel-lg-lg4573.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-lg-lg4573.c b/drivers/gpu/drm/panel/panel-lg-lg4573.c
index 20235ff0bbc4..b262b53dbd85 100644
--- a/drivers/gpu/drm/panel/panel-lg-lg4573.c
+++ b/drivers/gpu/drm/panel/panel-lg-lg4573.c
@@ -42,7 +42,7 @@ static int lg4573_spi_write_u16(struct lg4573 *ctx, u16 data)
 	struct spi_transfer xfer = {
 		.len = 2,
 	};
-	u16 temp = cpu_to_be16(data);
+	__be16 temp = cpu_to_be16(data);
 	struct spi_message msg;
 
 	dev_dbg(ctx->panel.dev, "writing data: %x\n", data);
-- 
2.17.1

