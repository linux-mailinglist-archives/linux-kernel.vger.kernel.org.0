Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C44C118021C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 16:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgCJPoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 11:44:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37445 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgCJPoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 11:44:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id z12so6474282pgl.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 08:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xni0YMnXezsFGTeUgEf4M3Fw4UAep4znIhY5+89pc7c=;
        b=NmvS7ouPivSfaeLyNoamlTqUAre20DSjviVyELT04fVLTqJY+cqtT+C4DIrjB5EdOh
         x7xmi17GzzdPu6q3nJ20O62xo8MRLSMyZeKJfPZdzHGz57nSj/bpUdASitiwhBPvjo7I
         5ChfRRTRp3Ver3FLKPIspYIhbZiArEUViDYos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xni0YMnXezsFGTeUgEf4M3Fw4UAep4znIhY5+89pc7c=;
        b=Z1tloB0QNj0BavxoKetglpUCWoD2WUkLNLu0JLUuoqZnLjgWqM97vZifH8JaIvXxHM
         nByBUs8MWHMMoWL/yVL0tEodmreCH0nNIUA13tJEq1G6tq+BLD4D45tfDXl4VdACwooA
         Z81IvnH3blLO0W/ctlfU+NZ0PFVer8Sz3QaJgPDp8Ux8Z7IDfRIOV/nn9wfVQ5N1uba2
         61h8z7hBITlxRSglbQaON+XH093t2LJE0ciMEXI99jX0Zd/LBl6sUm/NVRGmIdAYkJ3p
         B8p0GLmQ4RL4RvqAD8au8l+qjX4u2mavIQ3HdDEdi6HlWT/XjPS7BgRQ9Jeyw9rvku64
         Nlww==
X-Gm-Message-State: ANhLgQ1EQF4ke8AmvIoa/s4EW8yIsvByyL6fMBDPC5rsHoLiN+4f1F6d
        M7xa1Fu01nFzRzCKwc1X89xWHA==
X-Google-Smtp-Source: ADFU+vtm1q7lynSdly97Ecu4eD8ZY1rhs3jLKZ2SwYbl+1M/Bh8cn86sOV0C5VfaIx8al2st5nrmgw==
X-Received: by 2002:a63:d18:: with SMTP id c24mr21557269pgl.218.1583855040357;
        Tue, 10 Mar 2020 08:44:00 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id m12sm2731090pjk.20.2020.03.10.08.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 08:43:59 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 0/3] Misc qcom geni i2c driver fixes
Date:   Tue, 10 Mar 2020 08:43:55 -0700
Message-Id: <20200310154358.39367-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a small collection of qcom geni i2c driver fixes that
simplify the code and aid debugging. 

Changes from v1;
 - Simplified code some more and commented about platform_get_irq()
   in commit text for patch 2
 - Picked up reviewed by tags
 - Fixed first patch to use &pdev->dev so it keeps compiling
 - Rebased to v5.6-rc5

Stephen Boyd (3):
  i2c: qcom-geni: Let firmware specify irq trigger flags
  i2c: qcom-geni: Grow a dev pointer to simplify code
  i2c: qcom-geni: Drop of_platform.h include

 drivers/i2c/busses/i2c-qcom-geni.c | 58 ++++++++++++++----------------
 1 file changed, 26 insertions(+), 32 deletions(-)


base-commit: 2c523b344dfa65a3738e7039832044aa133c75fb
-- 
Sent by a computer, using git, on the internet

