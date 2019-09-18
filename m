Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACB5DB6562
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 16:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbfIROCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 10:02:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33083 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfIROCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 10:02:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id n190so4190417pgn.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 07:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=9uv9WJmkyWh3Ol07uAv2gA7QZ2Mt6wbtwrT18jPSdYA=;
        b=Ij8XBoy64zJB59li8mRwfos5AZiZq/bhaMYwAFtzpw2TerX05vOBCwlLEGz/r8wmBu
         68P8I5yl5temyhrfxvfjw8mk9ivIPJYWVjUQIPyRtDdfTsjzGqHsi2jA1EM1Qm60Zh5O
         fLhzpbt7B4t3hGysjU0YzgOBS9PHZEmYz46cvmbL7a26Tuz/spnI0a6vjAGodRbgZRJN
         um95iF55LFumhhNTbBTGXKviqenv8SGgGM8UQS5VLp3OQek43mYRzKua0Dy05bldQ2KT
         O3pYdsfz3stM3BhJ5WzmaSaISON16gv4c1aI5UZJ4lIwGzwO/wNkJoRo7P+VpwyAP0fe
         tBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9uv9WJmkyWh3Ol07uAv2gA7QZ2Mt6wbtwrT18jPSdYA=;
        b=en1Xh32LTJXGTYED859ysXEN/hKd/UjZS8IrdmUFLhVsbfxBweaiT3xA1e9Q3HoIqk
         BSmtHr924RKMTCNrnB6vs3fk9kuCnjeWzb2VuTptNkwG4EBjzDJuoA46/+XUCIWBYmQp
         0p4fG9YIMmSNZNBp9kiK4Eb3b9Bu1XXG6YtrLVgibp/BsCQBdYYEAZZEsqt3eaDdLuYx
         6fKM3GCYYmUgSAGrnJ8hCy3S6DfhetXqO3pNW79TdM7/HdJViCf1KajASFsmdgnmlqsv
         UWN4LwaewlFEcE1ixts0ZEz2W2qF7VGfMNlm5T00xvU0fm7bqwPy2/JSDoLXYuqVECLp
         ZJkg==
X-Gm-Message-State: APjAAAVgyFEfa3T+5QSgzZwUmybZmNCrjy7ujhhMISlcjpHcHINpoheZ
        NajgnYw6isKRm7fOC3kYoQa7yg==
X-Google-Smtp-Source: APXvYqwRs2W2y+LsdNpF08kKHByzKPteo0HkzNstmY51s/FeXDp5kqA3g06Ou020dsUj7oXalJ973w==
X-Received: by 2002:a65:6786:: with SMTP id e6mr4196361pgr.257.1568815360240;
        Wed, 18 Sep 2019 07:02:40 -0700 (PDT)
Received: from pragneshp.open-silicon.com ([114.143.65.226])
        by smtp.gmail.com with ESMTPSA id c14sm9058590pfm.179.2019.09.18.07.02.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Sep 2019 07:02:39 -0700 (PDT)
From:   Pragnesh Patel <pragnesh.patel@sifive.com>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     Pragnesh Patel <pragnesh.patel@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] regulator: dt-bindings: Fix building error for dt_binding_check
Date:   Wed, 18 Sep 2019 19:32:20 +0530
Message-Id: <1568815340-30401-1-git-send-email-pragnesh.patel@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compatible property is not of type 'string' so replace enum
with items.

Signed-off-by: Pragnesh Patel <pragnesh.patel@sifive.com>
---
 Documentation/devicetree/bindings/regulator/fixed-regulator.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
index a78150c..8d4a7b2 100644
--- a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
@@ -29,7 +29,7 @@ if:
 
 properties:
   compatible:
-    enum:
+    items:
       - const: regulator-fixed
       - const: regulator-fixed-clock
 
-- 
2.7.4

