Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3FA69873C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 00:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbfHUWYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 18:24:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42000 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731165AbfHUWYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 18:24:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id b16so3466823wrq.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 15:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=60yWYtJLk0Xp9SLelz+MaI60GmV6Utt18fBkUyG2qxM=;
        b=KJG2eemyCR3ZMbuekyI3MbIiJ81wrfp8NRjrwX0zZ7oMU2Tkk8yLrW3jJTGbAl/5k2
         Sm69ZxmQP0OqEps0eURzAy9Ian/sT322RExh+edk4NxWuBzMSUuwcDptsNtfsEKgPk2d
         ZB2R9eUNlO7qSm0ZNdV48+p/qivyjeW6rkY9LpWv0xsGpo01wPiPsRkkuO5xobtg9rHm
         qw7P00OFPIldzDSTTMtWryFtEyScZ0a276vYE+SqPzFM82tubBrakI/AYpizDrZcN2Fh
         tfGTvH+0bZEtkvXH3H7B9OYgmcs9pieyPM1aTXPJos47Imcr1a94Ze4xHd4liyWt35u9
         5qSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=60yWYtJLk0Xp9SLelz+MaI60GmV6Utt18fBkUyG2qxM=;
        b=TyjHVFvqkLzuQvI31ZahMDcpOdMrqNq+DO6pXoacMYtjCwuyG1vIne0IbGLT8JFwPe
         ESnK59ZcbueTppJLU/xrqD2B3xc50W+m899ZPDvhc1F21T2aNHnzPk9xdG0ixbj+9PXW
         1heg6L1J5HBa894vvbZ6SUmxctwuu0ha4osH3FAqiKMJUNr5WFQTz1jluzPcL+OSnF9s
         4sMgIkGHyRJ0Au0oEfiMPgUCtdpoykic+tdrWuGG6SRumdnU5gb/Ag6fDPlnwML/Puy7
         tU+9xnBBaiEZHjqZ17EDB7tZfVA/bnR6xO82F+NvR20obcf2oufM6oK/rm4FeLo5kIv6
         vPsg==
X-Gm-Message-State: APjAAAUME4/snpTiCbbVVN/rmylNr1HL62laWJevBwXscIfoNSGNo+vm
        h5xTyfIPMjifa9BDEx9OTuyiNA==
X-Google-Smtp-Source: APXvYqwht9LxVlp9IlMJVSETg91KaKJdV8dNDW+36WtFIIU2sF1g0DYgdyCLqNQoYIb7xJh8BnZBXg==
X-Received: by 2002:adf:c7cb:: with SMTP id y11mr36896014wrg.281.1566426270465;
        Wed, 21 Aug 2019 15:24:30 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca])
        by smtp.gmail.com with ESMTPSA id f197sm3548549wme.22.2019.08.21.15.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 15:24:30 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v4 6/6] MAINTAINERS: add entry for Amlogic Thermal driver
Date:   Thu, 22 Aug 2019 00:24:21 +0200
Message-Id: <20190821222421.30242-7-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821222421.30242-1-glaroque@baylibre.com>
References: <20190821222421.30242-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as maintainer for Amlogic Thermal driver.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fb2b12f75c37..299f27d11058 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15910,6 +15910,15 @@ F:	Documentation/driver-api/thermal/cpu-cooling-api.rst
 F:	drivers/thermal/cpu_cooling.c
 F:	include/linux/cpu_cooling.h
 
+THERMAL DRIVER FOR AMLOGIC SOCS
+M:	Guillaume La Roque <glaroque@baylibre.com>
+L:	linux-pm@vger.kernel.org
+L:	linux-amlogic@lists.infradead.org
+W:	http://linux-meson.com/
+S:	Supported
+F:	drivers/thermal/amlogic_thermal.c
+F:	Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
+
 THINKPAD ACPI EXTRAS DRIVER
 M:	Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>
 L:	ibm-acpi-devel@lists.sourceforge.net
-- 
2.17.1

