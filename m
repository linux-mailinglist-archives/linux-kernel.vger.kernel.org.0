Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06083166936
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 21:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgBTU50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 15:57:26 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46755 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729351AbgBTU5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 15:57:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so6108991wrl.13;
        Thu, 20 Feb 2020 12:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2f3uV3RWKbMqCO2QFYzkPoEF8LM6TNVDI/Gi9TBUfHI=;
        b=MXSn1rgdt7P3tH8KZP0tFbRW6901b2HrvP3o9gUFzYQW2YGGn1fvKWV5NbQR8QnUEm
         VVPdxU2ZVBFz09WF9nLh6Th61kWM5IYt2PHvpZ5fMlsHe/S4YDfA6kqHtd6/bzu3Vctd
         gzuBSqpJ865xupjulzXrZpNZs2zBp6Sqbey6Yp7xpAaCm9ojA3Y3OBWgDOVD1pYeL9hi
         RiQQYprFLTNE0iABe1B0lPQOJWgYGIyYrFrBQy6rH9OSpUKysGYV2sC3AEo7pVGr0q7g
         +1d/YnfZyo9if35mQTuIQqcesG72SynQdXGtogTKJuXOSrLvOxVNtZr3BG6YaVnJgxUA
         5L8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2f3uV3RWKbMqCO2QFYzkPoEF8LM6TNVDI/Gi9TBUfHI=;
        b=kU1NvkuxBLv5elfuhskevxdvAJA6SOtMx43//rEWNj6JKuHk4iGMG+P2ATvsazcgTZ
         pCxuiTnWaPT1ZgAqp5VwAShxGelUeSfFeXg/SizWu8hIZfTQSYh4lyi8pK4vM2lkBVlk
         K7vdeHqv4A6q94fQt9xP5apOg+fpNi6ZGrlMbhgDomTrFBU5my719wF+i23sjkorDV0c
         pcFyNWBl0MC85y94V+CcTqxVUXJ2EzluAQQHpQLYr1Gg5HAF74fND9xUr21N9lrwvIEe
         xxZDXnrv16D9vqRM4Jkdb9JFTmdyO0S0/LIZC9scFiWO9FCMMWCgscngQZc9XMU6Zdd3
         oVYg==
X-Gm-Message-State: APjAAAXUzG4XSAcnQujEZfjHMmQyPv30yIjnvvcqpqWMdHKTnv+Y6hDN
        cfg/PKVNnxYZnDiV0cyRD6U=
X-Google-Smtp-Source: APXvYqxE6O1xRP/s3Eex8+uTAabiof5+67V1QlISYwfPiFGVMeLM+jOyIb3TGVjHrpRx4Ny1OfKZJQ==
X-Received: by 2002:adf:f787:: with SMTP id q7mr44114421wrp.297.1582232239167;
        Thu, 20 Feb 2020 12:57:19 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id a184sm695039wmf.29.2020.02.20.12.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 12:57:18 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jbrunet@baylibre.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/3] ASoC: meson: aiu: Document Meson8 and Meson8b support in the dt-bindings
Date:   Thu, 20 Feb 2020 21:57:09 +0100
Message-Id: <20200220205711.77953-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200220205711.77953-1-martin.blumenstingl@googlemail.com>
References: <20200220205711.77953-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AIU audio output controller on the Meson8 and Meson8b SoC families
is compatible with the one found in the GXBB family. Document the
compatible string for these two older SoCs.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/sound/amlogic,aiu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/amlogic,aiu.yaml b/Documentation/devicetree/bindings/sound/amlogic,aiu.yaml
index 3ef7632dcb59..a61bccf915d8 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,aiu.yaml
+++ b/Documentation/devicetree/bindings/sound/amlogic,aiu.yaml
@@ -21,6 +21,8 @@ properties:
       - enum:
         - amlogic,aiu-gxbb
         - amlogic,aiu-gxl
+        - amlogic,aiu-meson8
+        - amlogic,aiu-meson8b
       - const:
           amlogic,aiu
 
-- 
2.25.1

