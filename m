Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C86569C97
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 22:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732822AbfGOUUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 16:20:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45577 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732717AbfGOUUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:20:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id r1so7928319pfq.12;
        Mon, 15 Jul 2019 13:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UVGDbnDZoiJbze/gsED6nUiGqLN0PdSlW4EjZ/iEn8Y=;
        b=Bs6KDxjMwwKo9sMDuaIaCzeCmMopb97Wg59oJk83xQOuXvepgI1Mz8VTdtp9eGbmSn
         7uAy3xtcveS8ZJWLK2iwmuPMM6KOjaQ7LZ4USAAVsB0j/G4e9u/3XUsQbDK7q/4to8nV
         bRHySKognbcYLUmeD7IQi7a+fvKjmPB+Mm5Y42iHC6QHQNzRYqlFZfEbAi0XFD9SxH8J
         31JRhhIfxT+4g17/bWSNSQ53JZQjVu1QlFpokyN9xjY/UeRB8hUCBkSc5EIITPFVH2ak
         8aRRQu+70g3to6odeMink2/jqoFg4fBxCgKyr5ER1Jq7kaiNY8Eoiow7AWpFaQTtdeju
         mutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UVGDbnDZoiJbze/gsED6nUiGqLN0PdSlW4EjZ/iEn8Y=;
        b=OgBiuHTgdEtzHxEQNSVbXQfnQKOaafGbs5WYwMVjiaxR5dYNBbrA7K/stfu8SIaVpu
         2mSOVcgUhF3uV9vdXQ5iZ5m+XZ02P3/nEf9bFsIyYOrYUyemhd3jbG64WWBPkdASIH+E
         gAAnNufv//b1bdyv8SbRQfq4SjSknSvxSC1p0eXBKs9MqezkG8tY6Mcs1CrXY7Jw0oi5
         qInZXJ/P0uII0h7U97EPyoZjbIVLlt8oPg2y5AMP3W13MPBWpCJ6p/5dp1iieK/dF/19
         +i1APdjUTkI1zaLknRyuZDelt0O4VQQFuoTizXV2NE0PT4B1RPt4C/VN2rHLE0vi9NDP
         G5zw==
X-Gm-Message-State: APjAAAVVErj7X7p+2EjLwY9bRVgCnrr0FQ+/EePFwzDrch6KvVPRhnKi
        RKB2PZDzAAm7RMbLSofnDCb0vxwe
X-Google-Smtp-Source: APXvYqyMxK3+wHuKzD0wQsLzOEBTynHBpoPadS9g+K9lkLUbh1rJaZC35neZ9fgA4+HemSuELlTfuQ==
X-Received: by 2002:a17:90a:8b98:: with SMTP id z24mr31684666pjn.77.1563222008265;
        Mon, 15 Jul 2019 13:20:08 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id h1sm22730534pfg.55.2019.07.15.13.20.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 13:20:07 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Spencer <christopher.spencer@sea.co.uk>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 14/14] crypto: caam - add clock entry for i.MX8MQ
Date:   Mon, 15 Jul 2019 13:19:42 -0700
Message-Id: <20190715201942.17309-15-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190715201942.17309-1-andrew.smirnov@gmail.com>
References: <20190715201942.17309-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock entry needed to support i.MX8MQ.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Spencer <christopher.spencer@sea.co.uk>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Horia Geantă <horia.geanta@nxp.com>
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/crypto/caam/ctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index ad6ff4040bab..6f3b4405dcba 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -527,6 +527,7 @@ static const struct soc_device_attribute caam_imx_soc_table[] = {
 	{ .soc_id = "i.MX6UL", .data = &caam_imx6ul_data },
 	{ .soc_id = "i.MX6*",  .data = &caam_imx6_data },
 	{ .soc_id = "i.MX7*",  .data = &caam_imx7_data },
+	{ .soc_id = "i.MX8MQ", .data = &caam_imx7_data },
 	{ .family = "Freescale i.MX" },
 	{ /* sentinel */ }
 };
-- 
2.21.0

