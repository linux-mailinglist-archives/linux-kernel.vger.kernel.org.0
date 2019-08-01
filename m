Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61A847D3A1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 05:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbfHAD2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 23:28:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42755 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfHAD2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:28:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay6so31521194plb.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 20:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WoSgR/AdZyczlXd/xYalMz8sFlJXKH+Q7kNg8AVFrWs=;
        b=A0I61U+wVKE1lGi1cibvWwTSY/5rby/tqWwZx87YKIgZJvUsAIaA0bXYMBETFXlgqb
         yg/9Y3MjAeJNXrT3peYDWv1RkVK6mWdtjiotxUxosSuM6QGVuvOCNT4XR8h/4kFarfF0
         GRA+ewtKH0chS+y3uTWOPM05v31O1S1L+4Vsgb+SFrkaUPO8RhVGYZvok1Qs11BYnsep
         vX0jKlaZrNmnqvqNL23sYWeDmoQhr1fmJifXeNDMzhjfiRb/K8fHb5Yt7xDtBogZQbPP
         brVki51NQlmy6y2HmeCiRi2e6JXiEaSXOVMt5aqC4xZUY7mjjNr3IrJZfQfFLVw1xsvM
         bAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WoSgR/AdZyczlXd/xYalMz8sFlJXKH+Q7kNg8AVFrWs=;
        b=LjB46EMYR538+17AT7TsfeVFj+xdxxrpcCwAKtceZXc3Pw+01oivQhTcAxK10KThyW
         peheI7fgQW00i4ApJ/V6fSwBsme33b9qNQoxYz+R95qlZhbWSFKHD2JWpRyCB7HHBnYH
         w8dH1hHRXkdRGb/3H6HuEv/EPDH/MKEekhQ7IiZAwgRsbCf+Yt3VoGr7dpNAzaIwa03+
         o4MwFatMHix5+ATkTEXyRI/Cb7svl+AI4zSFKOJrQzN6WGJpVxetw6hztJywX3bmDhum
         zUZV9BKUuuQ6vglgzw+35rrugRw6bRjJ5G/HqXtN1I3znQGmv9DS7+WB2Gu+f6BNwWp7
         37VQ==
X-Gm-Message-State: APjAAAVq1GxWKaACcDwrwvMBuzHE0xmU9YiEyDLy2Mxq7KEXDViZzBaR
        /eKPfqORpJdTiTLJEznji34=
X-Google-Smtp-Source: APXvYqxesvhaKIuP489JoTjfh7wnyYRRTYdoDyUo4ia/JeN20kqSS6bcZTQbBZUbjgiIMCvyeafAFg==
X-Received: by 2002:a17:902:b944:: with SMTP id h4mr47014604pls.179.1564630099395;
        Wed, 31 Jul 2019 20:28:19 -0700 (PDT)
Received: from masabert (150-66-98-104m5.mineo.jp. [150.66.98.104])
        by smtp.gmail.com with ESMTPSA id x128sm109020053pfd.17.2019.07.31.20.28.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 20:28:18 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id 6F3962011DC; Thu,  1 Aug 2019 12:28:14 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] perf tools: Fix a typo in Makefile
Date:   Thu,  1 Aug 2019 12:28:12 +0900
Message-Id: <20190801032812.25018-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.23.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix a spelling typo in Makefile.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 tools/perf/Documentation/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
index 6d148a40551c..adc5a7e44b98 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -242,7 +242,7 @@ $(OUTPUT)doc.dep : $(wildcard *.txt) build-docdep.perl
 	$(PERL_PATH) ./build-docdep.perl >$@+ $(QUIET_STDERR) && \
 	mv $@+ $@
 
--include $(OUPTUT)doc.dep
+-include $(OUTPUT)doc.dep
 
 _cmds_txt = cmds-ancillaryinterrogators.txt \
 	cmds-ancillarymanipulators.txt \
-- 
2.23.0.rc0

