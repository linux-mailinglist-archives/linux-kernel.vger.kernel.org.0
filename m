Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C17490D89
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2019 08:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfHQGym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Aug 2019 02:54:42 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44942 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfHQGym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 02:54:42 -0400
Received: by mail-qk1-f194.google.com with SMTP id d79so6549134qke.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 23:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6o2+JSXds68bprEsRDEVqYhdKp3AppBPWDxje+LgeTY=;
        b=ZPfaMsN3udqVwEDw6ipvkSS6e092wV6fECX6v1EZOKhaVsxklEG9dKgLQNzNblEzNk
         dibeunDIiTWaifNdtGAI8+qH3r0Nm/WSRjilBZ/7u3HKbNAWNdadsdy9bzu2MwBGrIRt
         FHuCRNB/3Oc3VtANjTIW30qumQXPJfmj8B0OQ/weyEyPnBaypWXRPeLjjbnfeO7RY4b8
         V0/WqkDHfWQ0hx3FGFzPUb728AvcIh9kFG0fyKUsrMytJdd8my/uc8Vu82Y/qUr5dqjc
         4a6xCv6lf810wnBxaxLp9GzdJMIXZRBi//FwPYELsowMSgfupYL/KnmZCLiXW12uPnXX
         +VjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6o2+JSXds68bprEsRDEVqYhdKp3AppBPWDxje+LgeTY=;
        b=bDUXleYe4oDKb9++3PHiPrDSIP0TmIGXtkbwHkesJnfsWAYleoQAw97ZGNSBf0Uekt
         vT2GVxBAPpRg4R6NBf+jBeRbvIgkpHNrXniLF73abGaLz4q/k9eyei80Wf5r+u8suY61
         aC1BHP5IDgzqKQLs+rVla/2U6sStkwR9BSqlnG9fk16BBJeDK9iDr5/xTXP4zb0lPyhX
         IId1l6hD0DaRJwOW1/RdJt+UwtgQW+L5pvZAC47QK/6F7G23doZr9+OfgfcOjqMhXdLY
         PDy6yjCpapkjoowIQW9wvXJVsw3+mSgjcNiKTZkAJSv1t6RfWaqh8L3myqbZOBqMDLGv
         cEbQ==
X-Gm-Message-State: APjAAAVko+wpGycs7UeHIVeOJXnP7+387wmIlj4lLOWR3lmLGz6G7biw
        gETLDXHqjX2YAidxtr02KY0=
X-Google-Smtp-Source: APXvYqxMuzXXUdCjadT9IfE8zHyC0XvB2r3jkdbP7897HHQTvCDrMXzmwW4N+JQ7po3MDIWGXf6LYw==
X-Received: by 2002:a37:4e13:: with SMTP id c19mr12561507qkb.370.1566024881406;
        Fri, 16 Aug 2019 23:54:41 -0700 (PDT)
Received: from matthew-linux.home (pool-71-244-100-50.phlapa.fios.verizon.net. [71.244.100.50])
        by smtp.gmail.com with ESMTPSA id e7sm3631196qtp.91.2019.08.16.23.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 23:54:40 -0700 (PDT)
From:   Matthew Hanzelik <matthew.hanzelik@gmail.com>
To:     w.d.hubbs@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Matthew Hanzelik <matthew.hanzelik@gmail.com>
Subject: [PATCH] Staging: speakup: spk_types: fixed an unnamed parameter style issue
Date:   Sat, 17 Aug 2019 02:54:26 -0400
Message-Id: <20190817065426.2090-1-matthew.hanzelik@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed an unnamed parameter style issue.

Signed-off-by: Matthew Hanzelik <matthew.hanzelik@gmail.com>
---
 drivers/staging/speakup/spk_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/speakup/spk_types.h b/drivers/staging/speakup/spk_types.h
index a2fc72c29894..afa64eb9afb4 100644
--- a/drivers/staging/speakup/spk_types.h
+++ b/drivers/staging/speakup/spk_types.h
@@ -189,7 +189,7 @@ struct spk_synth {
 	void (*flush)(struct spk_synth *synth);
 	int (*is_alive)(struct spk_synth *synth);
 	int (*synth_adjust)(struct st_var_header *var);
-	void (*read_buff_add)(u_char);
+	void (*read_buff_add)(u_char *add);
 	unsigned char (*get_index)(struct spk_synth *synth);
 	struct synth_indexing indexing;
 	int alive;
--
2.22.0

