Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A622716B56C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 00:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgBXX1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 18:27:06 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50284 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbgBXX1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:27:03 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so1111953wmb.0;
        Mon, 24 Feb 2020 15:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8NVlvzE3Tm6P+gLHVWoR+a8t0nwDLWG0p5mfxUKacM8=;
        b=RsqzdoQe89nHPyKET3qT33aLg5yAxbgQswsmIDvzPvSW7D6bHtfMRpm0nbYYuP4Gtt
         B9UsEgE7n86ChF4Dm6CIHlaSOhB5/4iMGOzhwM49ofX6YupnwF+7Qvhl4TF4+CiJr4S4
         gLAuRlDJS6BS6BWZVUrvXnLV2pIPM2RinXRL5M1SyZqy5zoNxw4qPmPH1IXpoy0Avgcd
         JMoKZKKULwgWohALQ2Y4RnbO6yAUZ6ozphw0I7QDihAmUW7SiDK56UfXHlbjAOsdsiuF
         ipYwR+jDXaNnHyRfHBAu5Hs5SLJZaactWOr2h572/bjV0WUAH+P8DGZ6D9Y0pXgz8coa
         rg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8NVlvzE3Tm6P+gLHVWoR+a8t0nwDLWG0p5mfxUKacM8=;
        b=D5iotJNP3zLFJQ0xnxCNUUm7xYMcO2lssrHNCDQhO1+7gW6DYeSVdIX1Mb7fN+IF9G
         xIJ9xXeLNUvJkXSe1089NcnaxRPXhE8aVRtkMBTgYvaeDeAQqorB98bmRoN4JVPVDIAO
         ix5Ty7O0kIejFyiddP+5y4qaZZv+RwAt+v7BxeMPTb/+wjVBNk2R044Et9/2+q4ZTRA4
         uX7NEODcmFEfSCEh1+l6VEx9DibUxo1+EHlnK2DiwjGm3VkL2EfJzYjM9Y7/0EFz5+de
         gSGZKDsSDyZ564H2uAtsZgdsCUwNp8DAx1w/Az150yjRV48TyKzGi+G+3SlfymZ8e0sJ
         n5yA==
X-Gm-Message-State: APjAAAVkd/hCDxzYCr35S+rQ0kEcHpDkhj3ZPHMxU2Pk5FtOTEITfkax
        JRm99z97G+MXFJwVKAjeeYo=
X-Google-Smtp-Source: APXvYqwLkmHUUFun+m9+BvTzVsQnD+kGQ4DuAT8WzcyXQYxIMaZPQS9XVg5KG8cUpMT9brJIkdK1/w==
X-Received: by 2002:a1c:a952:: with SMTP id s79mr1369235wme.83.1582586820935;
        Mon, 24 Feb 2020 15:27:00 -0800 (PST)
Received: from buildbot.home (217-149-167-12.nat.highway.telekom.at. [217.149.167.12])
        by smtp.googlemail.com with ESMTPSA id g25sm1971099wmh.3.2020.02.24.15.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 15:27:00 -0800 (PST)
From:   Franz Forstmayr <forstmayr.franz@gmail.com>
To:     forstmayr.franz@gmail.com
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: hwmon: Add compatible for ti,ina260
Date:   Tue, 25 Feb 2020 00:26:45 +0100
Message-Id: <20200224232647.29213-1-forstmayr.franz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support for power/current monitor INA260

Signed-off-by: Franz Forstmayr <forstmayr.franz@gmail.com>
---
 Documentation/devicetree/bindings/hwmon/ina2xx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ina2xx.txt b/Documentation/devicetree/bindings/hwmon/ina2xx.txt
index 02af0d94e921..92983a224109 100644
--- a/Documentation/devicetree/bindings/hwmon/ina2xx.txt
+++ b/Documentation/devicetree/bindings/hwmon/ina2xx.txt
@@ -8,6 +8,7 @@ Required properties:
 	- "ti,ina226" for ina226
 	- "ti,ina230" for ina230
 	- "ti,ina231" for ina231
+	- "ti,ina260" for ina260
 - reg: I2C address
 
 Optional properties:
-- 
2.17.1

