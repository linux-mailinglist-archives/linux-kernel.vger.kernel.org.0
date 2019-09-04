Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC358A9432
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 22:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbfIDU4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 16:56:16 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41903 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfIDU4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 16:56:16 -0400
Received: by mail-qt1-f196.google.com with SMTP id j10so104620qtp.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 13:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1QaddsCLQh46Q9EX1SzXxpSpkDTuxvATR1ZZECPWevo=;
        b=cpEY8onH+66PmROo6FfSYd2t9qhQqTUCfB8ecNbQ0QrLmY+XMYybIMnsSgqmWKi0t/
         I4tsokd+CnAbDflDCj8iS95whEKAEvs0qZ/ebVNJQEbJOceh+u9+jHi1XDEmuIoRpogR
         WF0teQBi924p/laP6m1LY0Rkb0YiFnU0Pdxheusy0X3QDdN78UMz07ZlzQM2YiJwM5LB
         QAAoCny2YbP8UtaB4PgHCOUAzGCO5EgKBttnUmc8LHcYoqog2y69Cwbsg1y6xrBG2HVA
         6Ggu3PiWUHJ9ElxI2RSgGmAyUkPj7oo1mz6KnYXDRtSxozmOhJAKLe/ppOa39YrDY21p
         eCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1QaddsCLQh46Q9EX1SzXxpSpkDTuxvATR1ZZECPWevo=;
        b=uGG8htp5B3dg48zhC3Sq7Sym/oVutlhJ0Jec3D/OBuKa7VaxKN1jfyF5X3e+500Ko/
         vZVIbu3c42pGKHBIK/H2S6oa8t9YsOdBhIFSbtX2L1IARG3wKpVQbtqKLTlBK3Bd/jV9
         JgCZ17KF3deUP3HXX4j4WUdA3fY8D+iv9PxAxUhdT5ktWlO1vJl34P62tsF016wg0zr+
         AxyNWjGcb9cSJvtNfHaY/iznbNjwuFSgza594fhWIDpeRwtmbgopMCEWKgIzBoVoB8rl
         0BJR3zgHXj5ENXv9Df0I5gpaZiNhnD8rDIdqCYR4OgrLfwJMrgoCJsecaT0fYgfmb97r
         a2OA==
X-Gm-Message-State: APjAAAVIkmYJ7DyG1Mmih8TgeYEj5plILvTwu6UOxZouNQDFHFuVcPVN
        svYT5TEQrboN1UVEkqjcdp0=
X-Google-Smtp-Source: APXvYqzmSUjeBY0HCsAUxhBjx6Rf12lCd77aY1C0yZnkwSV/0fmWgXiCTIX6FfsZuohn9DAN1QFwww==
X-Received: by 2002:ad4:5048:: with SMTP id m8mr27389919qvq.134.1567630575468;
        Wed, 04 Sep 2019 13:56:15 -0700 (PDT)
Received: from 389b3b377db9.ic.unicamp.br (wifi-177-220-85-178.wifi.ic.unicamp.br. [177.220.85.178])
        by smtp.gmail.com with ESMTPSA id g194sm95382qke.46.2019.09.04.13.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 13:56:14 -0700 (PDT)
From:   joahannes <joahannes@gmail.com>
To:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        jevsilv@gmail.com, joahannes@gmail.com
Subject: [PATCH] staging: greybus: remove blank line after an open brace '{'.
Date:   Wed,  4 Sep 2019 20:55:58 +0000
Message-Id: <20190904205558.27666-1-joahannes@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch error
"CHECK: Blank lines aren't necessary after an open brace '{'"
in loopback_test.c:742.

Signed-off-by: joahannes <joahannes@gmail.com>
---
 drivers/staging/greybus/tools/loopback_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/greybus/tools/loopback_test.c b/drivers/staging/greybus/tools/loopback_test.c
index ba6f905f2..251b05710 100644
--- a/drivers/staging/greybus/tools/loopback_test.c
+++ b/drivers/staging/greybus/tools/loopback_test.c
@@ -739,7 +739,6 @@ static int wait_for_complete(struct loopback_test *t)
 		ts = &t->poll_timeout;
 
 	while (1) {
-
 		ret = ppoll(t->fds, t->poll_count, ts, &mask_old);
 		if (ret <= 0) {
 			stop_tests(t);
-- 
2.20.1

