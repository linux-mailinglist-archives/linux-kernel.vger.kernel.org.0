Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3562A78E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2019 03:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfEZBTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 May 2019 21:19:47 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:41330 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfEZBTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 21:19:38 -0400
Received: by mail-ua1-f68.google.com with SMTP id l14so5152549uah.8
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 18:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Thiz24oLUJjnwJssddGA50jJAZJH3Ux+9Q55q5uwhW0=;
        b=VGZVE/0Wr+aN2rA6mptgptwPqtXIBa2qt+WBvdGKoU9zYEmd17iXQy7+0jqHBhWxDg
         VOmbIRwtQXYy43JFpQC9wbxTQiXUL1lZ2z0J+RGkfx7Bi571I3RmAtkhO1TMeVVfeZus
         iJAcBITC17AJQ0F4HL7igiOZKRB/TtbLLy0pYjHYXGq8Sa2tTpH1Ssi0UxJqNysz1t7L
         9SwG40bwcxmyR9zfcxqeR5C665gWM4twXJsOHRMFcmR4SiwCIvM1LOgawav0bsNLSzX5
         oUp0U3nfK3y4GeKvT/cXz0PGhiBAP1liSzUwBmzNE7+NnS74NFe3xqzIcHtmHn/UiG/h
         Nl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Thiz24oLUJjnwJssddGA50jJAZJH3Ux+9Q55q5uwhW0=;
        b=sRkAeBjdjEMDoNsOfP94CXvElo+IJuz53ecK1vZ2l6WQS3oeHcAl6cutEDi5WPj5QH
         SzpXOtDnOvS8ObeY6Ho1V1EHQGFr6xlSzNVFeIxKiUTkmUBKDtwfLx4BJCcI5Ntqg/K1
         bE6V/jZJf+O6pWlfHMatjmPKI5cci9RBqhyyBGr62H1vIMLpPK9ft+yJO4dj+He9YjEo
         H8HOwsvkithR5nuXPe/NMX/T3IsrbylK4y/0O6VcirINyPlN9VUrxGzgMiiqZQXr6bJz
         Ia4xRt0K0f6ih43mTv/zSZrGBrYZM0CThyvY+H//iug/s3BCBWc8/XEUg9PAO5QN28x+
         v7sg==
X-Gm-Message-State: APjAAAVl3pVuMCua/kDQKjJcNtb8gCUiN2xQkBOa2W+WNeaHf0bJwEc2
        DRRHRH6Fp3O/RtueOnJcCthFwEBnCzk=
X-Google-Smtp-Source: APXvYqwnwrXkH7CwOPUNJhDtaRdQB/OmkfvVyI/UJZRIHTsjN3llyG2PvL3Ed12nNTelUeW6mkN8Sw==
X-Received: by 2002:ab0:53cd:: with SMTP id l13mr29517179uaa.101.1558833577432;
        Sat, 25 May 2019 18:19:37 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.md.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id 9sm4593181vkk.43.2019.05.25.18.19.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 25 May 2019 18:19:36 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Geordan Neukum <gneukum1@gmail.com>
Subject: [PATCH 7/8] staging: kpc2000: kpc_i2c: fail probe if unable to map I/O space
Date:   Sun, 26 May 2019 01:18:33 +0000
Message-Id: <313d7ff86c2bdc4ef42629baa26a8eef893c89c8.1558832514.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558832514.git.gneukum1@gmail.com>
References: <cover.1558832514.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kpc2000 driver does not verify whether or not mapping the I/O
space succeeded during probe time. Make the driver verify that the
mapping operation was successful before potentially using that area
in the future.

Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
index 452052bf9476..51e91653e183 100644
--- a/drivers/staging/kpc2000/kpc2000_i2c.c
+++ b/drivers/staging/kpc2000/kpc2000_i2c.c
@@ -591,6 +591,8 @@ static int pi2c_probe(struct platform_device *pldev)
 		return -ENXIO;
 
 	priv->smba = (unsigned long)ioremap_nocache(res->start, resource_size(res));
+	if (!priv->smba)
+		return -ENOMEM;
 
 	platform_set_drvdata(pldev, priv);
 
-- 
2.21.0

