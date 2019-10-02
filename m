Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 826C7C9010
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 19:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfJBRk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 13:40:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33542 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbfJBRk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 13:40:56 -0400
Received: by mail-pg1-f194.google.com with SMTP id q1so4225815pgb.0;
        Wed, 02 Oct 2019 10:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3B+j3JqzIPiwRwXNo1J8LATwL3AzjaBnib1ySfRTIoc=;
        b=Av1ir+Ao+x17YdibrMWnEgNmaJJCUHEvAu20IEqcps5c8MeVSADHxFvmsBzSUxg8O3
         GrxFw+usqScrNh1RQeYIyVpUHv1uGf2t+gF5cMY1aDgIeqEGoPSS1sJa1ZdCg/jh7f1o
         FDME/pZMBiIg0wTkqKlqHts4elcX0nU2s4SEJMM2AIRD6owXrrNz4GKDmsCuJURi2adL
         IsbAoptvFMsA+SxovgTgVg00Kh0d+lKIrmMAOcWlTysteia/deAgLmcEq5Vf1yCd/ic0
         yTjpebKbubBmWzk6gPONH0UYT7Hlv95mqI482xgU5rIyA6V0+rHw3M2v7LFsRoCcVsGi
         JCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3B+j3JqzIPiwRwXNo1J8LATwL3AzjaBnib1ySfRTIoc=;
        b=BnKW+4KESsbDCac10o2S78zHirKMgI7kL87Ngs6jZjwJMI3TxBwVMugWhH+iHimeF0
         vISlvPQLkGUcp244AgNp6FNRr/12vDAfkt9WmbLjUmYQKAQVzjTSHW2q8YDX89C0u7V4
         I33RuTiLhEwY+iJsoWfhE1Nh++Ho0chgrcyfDfw0EMVirCEjh2qoE/WK3Iv/FtnxWEVK
         sWTwevifZGh86PPyYX+P3/h7wB1s56KVBGKdbp2jzofJtqkZAj7L7rkMfknzlUWLMcTG
         RscvVCPlmC0nb5AjMYRmd23eOBXLM9yNRFKGwZdMfZ1yfi/d3MvqvHcSEH98ivqY5sRu
         cb2w==
X-Gm-Message-State: APjAAAVmdtmMq72cnLYiF1kK5Az1hgGVWMG6dYDmz1W+j8sXiiULlgWZ
        4anQk1oP02berfR/LlG5Zzg=
X-Google-Smtp-Source: APXvYqxqcW/QajeJaU/n0ZHFqEjZnuYDGy8tJZXfiBOcltu+XczbqQp5CCKZ30jAlQDR3FdJRVEMzg==
X-Received: by 2002:a63:f20d:: with SMTP id v13mr4862571pgh.175.1570038055634;
        Wed, 02 Oct 2019 10:40:55 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id r1sm15310pgv.70.2019.10.02.10.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 10:40:54 -0700 (PDT)
Date:   Wed, 2 Oct 2019 10:40:52 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Azael Avalos <coproscefalo@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: toshiba_acpi: do not select INPUT_POLLDEV
Message-ID: <20191002174052.GA37723@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver does not use polling mode of input devices, and this config
option is going away, so let's not reference it.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 8690e311f407..9ecb02226be8 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -830,7 +830,6 @@ config ACPI_TOSHIBA
 	depends on ACPI_VIDEO || ACPI_VIDEO = n
 	depends on RFKILL || RFKILL = n
 	depends on IIO
-	select INPUT_POLLDEV
 	select INPUT_SPARSEKMAP
 	---help---
 	  This driver adds support for access to certain system settings
-- 
2.23.0.444.g18eeb5a265-goog


-- 
Dmitry
