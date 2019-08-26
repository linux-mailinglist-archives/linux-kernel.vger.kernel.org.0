Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 354079C7C8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 05:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbfHZDSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Aug 2019 23:18:50 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39787 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfHZDSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 23:18:50 -0400
Received: by mail-pl1-f196.google.com with SMTP id z3so9296722pln.6;
        Sun, 25 Aug 2019 20:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NrmwNN1a7FGUuY5qZRKkyXWwIR2YCcfzZoksPdLin0A=;
        b=TlmzPxPucUxy5LwBsS7cLyW0JyboB7rRDlpCi3bqxUn8WWIUEcVhXfevJw8y+ngh5o
         ABS6ViPcpC5pbIzJEG+5InBrdHHZG4QxkfB//kP8BUE0mP6Nk5NlUvOrHXpgFx2O7lzC
         Zm8EUvDqXjPmgT+89CzdmY9b3RnY2i0TcSgPZLDM3gu8obw64BQTiSTlOhm96NwE2H9C
         PaTHppJAQ1JOk0sYsasSGX/as+2dwAHOLkqb9kGmsfXPFNEEhfZCs0Jlrg3/UC2dGICn
         ThWYOWzD3USGp59rwbvDpRwfvvwLbMTxozpmirBDOF7d/N5uRY/8u0xNdcUPyXV5HkhE
         GEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NrmwNN1a7FGUuY5qZRKkyXWwIR2YCcfzZoksPdLin0A=;
        b=t0H+l4h4RxoA43zgauFz6MhqPplDNmH+H55FMKwjWVXeovZAS11VbayuQBEunKXZj2
         jagJXaLIgnIUBnGiV2Ss7iJbPJDAUGXoGDpqOJOmtqCUbU1YEECxlb0KL1Ki/FvoGP1r
         VUEQ7/c7oOXMIJgf/JGFKcUh/h/Eq0MPl1S/xPjWgDq5MRN+S8SgqMyhw8ZtnUKsH6uQ
         JH57J7UEnZXi8lHwx7A8nFnMXB7fxTlt3WfHLUnbJvWSTQ2pOplVuwTL3AOmAxLHnGmo
         lhhxLuKJLVIZ0Q/9Au/RFav8fWSsoKnDBFzxuOLuBugy63GYJn9CsF5222nrSc+pY6k/
         aRBQ==
X-Gm-Message-State: APjAAAXt/nFGnNv/dOItbF5dLjzywhG1LaDtJU3X6SjFTFGwusP8MIEr
        WwFnFWmAMEMSIacXN8fWOqk=
X-Google-Smtp-Source: APXvYqxMYZuZCrmRgtjqP5oL6VKke8iabzvZGj6YOxl8t7JDWy+bH+CiS8SA0I4byANXZmgBLG/uvQ==
X-Received: by 2002:a17:902:b115:: with SMTP id q21mr16077835plr.76.1566789529424;
        Sun, 25 Aug 2019 20:18:49 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y23sm12565905pfr.86.2019.08.25.20.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 20:18:48 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 0/5] a few fixes for sprd's sd host controller
Date:   Mon, 26 Aug 2019 11:18:25 +0800
Message-Id: <20190826031830.30931-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

With this patch-set, both sd card and mmc can be setup.  This patch-set was
verified on Unisoc's Whale2 and another mobile phone platform SC9863A.

Chunyan Zhang (5):
  mmc: sdhci-sprd: fixed incorrect clock divider
  mmc: sdhci: sprd: add get_ro hook function
  mmc: sdhci: sprd: add SDHCI_QUIRK2_PRESET_VALUE_BROKEN
  mms: sdhci: sprd: add SDHCI_QUIRK_BROKEN_CARD_DETECTION
  mmc: sdhci: sprd: clear the UHS-I modes read from registers

 drivers/mmc/host/sdhci-sprd.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

-- 
2.20.1

