Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 058A745AD8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 12:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfFNKpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 06:45:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36548 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbfFNKpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 06:45:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id u8so1836594wmm.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 03:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M7TbSumAgRBdakEE0RH2h70YxQ0sN1NeoR8pORJvTqI=;
        b=ZIKYa2CQPuD06mwcr376HaetoRETRAJwxmJoSazagTrJgOHL71hjLaP/042Fb0128I
         OWo7/1cQ81G5SysUSsBZEDLgM2rdscja9mRTElgI7RNC9j9CQ863TrXIHlxBuP+a4Uq6
         p6XEtbQhIz7LNKoVvtVaB5n5kC0DFV20yt6C5LUtf6RnPYI5lZXweCA9ms3GAqLj4U2V
         jx9AFvh3YpZoJ5kSwKN3uvFid/d83D/hrUMGw4eVOPhPQpbVzeepM73HwwwNHAhTAC3X
         9YYwoaKo1qClqfE8aZ7zca2b1H6Fo81ib54RJAgwnai78R+b1vHZt1IUaFvoreWlX59T
         Q+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M7TbSumAgRBdakEE0RH2h70YxQ0sN1NeoR8pORJvTqI=;
        b=mL7Jw4TSJI3GQCbg7zgBJ7AiZKSI0/33SFq/n3+nkDnnjJNaIXmzOxR8YBj/6Vdfc4
         sy3hel5pr2ge10wYKvtTK9TSxX39Db2eNSDmvzo9bR1l3EYTDz2jG3/HFXNfgOYiJrec
         jnCAOiDQtDrSwneYy92zVUpEkLdrpU4xOloLcgTNgpwYNgRh7ntHO5iSD3VfsgFBr7a+
         2DtTFmZX6mJMDnTMx/mcLrnIF8re4SXoT/yUyXReYUFINUO81hhBkuLyEao5j+oY2UNg
         qi/ohqvR9koloSUl6CiP6XeFlLdk7NN007udAbWk3dN4tOkZyIkKYnw6bp4BWQjjKDf/
         0QuQ==
X-Gm-Message-State: APjAAAWrkLCOAFBfqfaXfNqaiS8UeOUN1GqQ+ts9DrEYQV6S9dNuzlOX
        974wOLUgM5gyMOAPIg0ED28=
X-Google-Smtp-Source: APXvYqwHY5Ac2gEgrYvYkIGTMKfrXaZyTh9xeiQ09gQlqd/Wz1iB+5rxbLIlU06afnlwUl1IZmaVbg==
X-Received: by 2002:a7b:c455:: with SMTP id l21mr7628235wmi.114.1560509113108;
        Fri, 14 Jun 2019 03:45:13 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id n1sm2268037wrx.39.2019.06.14.03.45.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 03:45:12 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] clocksource: Extract clocksource lookup code
Date:   Fri, 14 Jun 2019 12:45:09 +0200
Message-Id: <20190614104510.19360-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Move the clocksource lookup code into a separate function. This will
allow subsequent patches to reuse this code.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 kernel/time/clocksource.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 3bcc19ceb073..467b36d2f9f8 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -453,6 +453,18 @@ static inline void clocksource_watchdog_unlock(unsigned long *flags) { }
 
 #endif /* CONFIG_CLOCKSOURCE_WATCHDOG */
 
+static struct clocksource *clocksource_lookup(const char *name)
+{
+	struct clocksource *cs;
+
+	list_for_each_entry(cs, &clocksource_list, list) {
+		if (strcmp(cs->name, name) == 0)
+			return cs;
+	}
+
+	return NULL;
+}
+
 static bool clocksource_is_suspend(struct clocksource *cs)
 {
 	return cs == suspend_clocksource;
@@ -1110,14 +1122,14 @@ static ssize_t unbind_clocksource_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	ret = -ENODEV;
 	mutex_lock(&clocksource_mutex);
-	list_for_each_entry(cs, &clocksource_list, list) {
-		if (strcmp(cs->name, name))
-			continue;
+
+	cs = clocksource_lookup(name);
+	if (cs)
 		ret = clocksource_unbind(cs);
-		break;
-	}
+	else
+		ret = -ENODEV;
+
 	mutex_unlock(&clocksource_mutex);
 
 	return ret ? ret : count;
-- 
2.21.0

