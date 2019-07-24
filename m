Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2032A72352
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 02:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfGXALb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 20:11:31 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:46375 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbfGXAL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 20:11:28 -0400
Received: by mail-pg1-f201.google.com with SMTP id u1so27040812pgr.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 17:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q/JO0jIzFDUcBLNa0OLAVEbtuFfd8ssnFHaHdmtCpxU=;
        b=WYmp9wsxezkT2R/MikeKx4t2kiHMyW2mvw+vnqop1fKm18UGsdFrOX0WMvp0211oE5
         AenkmFgmV5Fd3/Kob7ksNJEBQ5BHl8zs1JzyycKcNyBaseoUHZcFMx6ZWsdHZU92y0E0
         Dzyw6ffhd60WvwW1dAxMzf2Bw1rXvf8tft38BNZ/9xEHqn8dkzW3wMW49PAIcMGw6eR5
         9+5VreZKwIO5czdaW+ToF0ZASnI1NQZlEzr6pNvgpH06DfFYBDVN2OyI69rdIn6kpJlu
         CQJMTpeetGIPTol0Z9tGdsf6G3WGCRMgmk5IWKNGrriIaXe6bMmUPkRQnOEodnqoyC/+
         hWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q/JO0jIzFDUcBLNa0OLAVEbtuFfd8ssnFHaHdmtCpxU=;
        b=YKAKAigKcWyrFgpUGVED6fc1oJYTGsXTaCDTWLa+yBJMrnuS5Fus7BY6l/XuXSUkp2
         0mam3QxL0XMoc5gNFCs4VbBO/7++le3cDFTT9WVbdRoxm1VyH4fygBev1ahU+PZus105
         Ozrff+/x8taAspCWMB18z+S57k/82M71MFBczIQwB+wWF6CEWK+xIYX7PCeQjNelgXfF
         qcM8bKvJ248RvVZvixDSnGPqgN50f5+wg4t3lk0b1UaJ2UC3URqNlwcqxF5lscRsLDKp
         UO2UOjYD5Wr/vnsI7i/NkiHivkrtDns9mNXLFga2wbo4uWHpiAHNvHpuxdpuEFSxc4Xl
         YlPw==
X-Gm-Message-State: APjAAAW5golK+m/XY3n7Fnz+Xqn4CsyFWaasRIwn/ly/f0i1WsCURKiK
        gU5E41kg0PjQB5/nWapvD8UF/FJM1HXtjWk=
X-Google-Smtp-Source: APXvYqyfrpfG7foa9SWIkR5PY0wl5lzzhUJJl9ryESw4iWhqCn6wdu4L8I+nTmuFAxhxJl22/uYxTDoF1Fgo0zY=
X-Received: by 2002:a65:6259:: with SMTP id q25mr38982937pgv.145.1563927087442;
 Tue, 23 Jul 2019 17:11:27 -0700 (PDT)
Date:   Tue, 23 Jul 2019 17:11:00 -0700
In-Reply-To: <20190724001100.133423-1-saravanak@google.com>
Message-Id: <20190724001100.133423-8-saravanak@google.com>
Mime-Version: 1.0
References: <20190724001100.133423-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v7 7/7] of/platform: Don't create device links for default busses
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Default busses also have devices created for them. But there's no point
in creating device links for them. It's especially wasteful as it'll
cause the traversal of the entire device tree and also spend a lot of
time checking and figuring out that creating those links isn't allowed.
So check for default busses and skip trying to create device links for
them.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 41499ddc8d95..676b2f730d1b 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -682,6 +682,8 @@ static int of_link_to_suppliers(struct device *dev)
 		return 0;
 	if (unlikely(!dev->of_node))
 		return 0;
+	if (of_match_node(of_default_bus_match_table, dev->of_node))
+		return 0;
 
 	return __of_link_to_suppliers(dev, dev->of_node);
 }
-- 
2.22.0.709.g102302147b-goog

