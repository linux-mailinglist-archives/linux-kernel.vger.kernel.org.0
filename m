Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19521E800E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 07:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732276AbfJ2GGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 02:06:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38824 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbfJ2GGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 02:06:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id w3so8768903pgt.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 23:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XSl5Mq1aXdP9mDitN2B9984N8enXsTbudBuTAQpDf4A=;
        b=mBF1kW9k32AH+Uq/epZa5VJuVFAV+dfxNcwQ+SvNSmYsIj3Yrfc5N4llW2d5WV5nQ7
         UvA/WyFn3AGdLV/5PW2ekn4U/OC5DzmUQc2u7QTeQA/KQl7iKJ3WXBSoP6HW8Zu4Na7q
         LrcIg3+TYu3J/F8X2UCGM/CyRoI0bTXy2pENLHP83ycUVwP98SLntHn2JN2Ah4YkNiay
         aRvs1X9uHQ2VMZhWnC15Ag0he920kmenq3c/Tx+adBBy1CS1VDTF+P408U8Sr7bjItQn
         MHDSjKW38AWmZqj/FvbGeQcDZkrSbkN+u5PoW9ftVLODGHaYUxVUnJMKN971VHaqUDdF
         JHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XSl5Mq1aXdP9mDitN2B9984N8enXsTbudBuTAQpDf4A=;
        b=kepvF+Ac+yK4ZJj95ieiWWj7/2YJF7turToNV1atTWCLNfJNOD3IAvcFWznbaQQvPV
         ddxU8eWdifWPQZBNTeuUxFmpnHS6te4ow7Y2oObeu83H4V4Bkir3xcKfKI15dDodmHG5
         148BVxbqqUzVcr2MAXdiiOgx1mFyJ8Zp341gKIfJu2W6FGe4awO2XNKll8hfS2Sxrqn3
         duxO9oG5Z+EERPGiXaWhEQ1Hs+Hv/mFb96vaar2ZMpph9S+NrXI4HWqQU7AR2ZMeR4o0
         EirB5eEILMTWHv6UZtXOILqtXvgI53tQzrjYcmpY/tdY/Jqib+1vNqxwKIp8A83lE5Xu
         fckQ==
X-Gm-Message-State: APjAAAU2m2FZcfRSPdSUu0vW3uuiKNW1mNUlfnY83ZDeZULbXpRG7wy4
        Pt0J8HbgR43nZci0JnGnkVg/fQ==
X-Google-Smtp-Source: APXvYqxGfypuwDtLCryzyPWbVGJu9TbSRAaq10XpCWBppzPp0GXUWgtvRhIXDneTOqs9Smyi9ODnmg==
X-Received: by 2002:a62:62c2:: with SMTP id w185mr25609223pfb.6.1572329168008;
        Mon, 28 Oct 2019 23:06:08 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s14sm12132145pfe.52.2019.10.28.23.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 23:06:07 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] arm64: cpufeature: Enable Qualcomm Falkor errata 1009 for Kryo
Date:   Mon, 28 Oct 2019 23:06:04 -0700
Message-Id: <20191029060604.1208925-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kryo cores share errata 1009 with Falkor, so add their model
definitions and enable it for them as well.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/include/asm/cputype.h | 4 ++++
 arch/arm64/kernel/cpu_errata.c   | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index b1454d117cd2..8067476ea2e4 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -84,6 +84,8 @@
 #define QCOM_CPU_PART_FALKOR_V1		0x800
 #define QCOM_CPU_PART_FALKOR		0xC00
 #define QCOM_CPU_PART_KRYO		0x200
+#define QCOM_CPU_PART_KRYO_GOLD		0x211
+#define QCOM_CPU_PART_KRYO_SILVER	0x205
 
 #define NVIDIA_CPU_PART_DENVER		0x003
 #define NVIDIA_CPU_PART_CARMEL		0x004
@@ -109,6 +111,8 @@
 #define MIDR_QCOM_FALKOR_V1 MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_FALKOR_V1)
 #define MIDR_QCOM_FALKOR MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_FALKOR)
 #define MIDR_QCOM_KRYO MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO)
+#define MIDR_QCOM_KRYO_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_GOLD)
+#define MIDR_QCOM_KRYO_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_SILVER)
 #define MIDR_NVIDIA_DENVER MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_DENVER)
 #define MIDR_NVIDIA_CARMEL MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_CARMEL)
 #define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_A64FX)
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index cdd8df033536..315780e7bee7 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -627,6 +627,8 @@ static const struct midr_range arm64_harden_el2_vectors[] = {
 static const struct midr_range arm64_repeat_tlbi_cpus[] = {
 #ifdef CONFIG_QCOM_FALKOR_ERRATUM_1009
 	MIDR_RANGE(MIDR_QCOM_FALKOR_V1, 0, 0, 0, 0),
+	MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_GOLD),
+	MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_SILVER),
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_1286807
 	MIDR_RANGE(MIDR_CORTEX_A76, 0, 0, 3, 0),
-- 
2.23.0

