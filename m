Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE7A8108F59
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 14:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfKYN7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 08:59:15 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37740 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbfKYN7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:59:14 -0500
Received: by mail-lj1-f193.google.com with SMTP id d5so15982237ljl.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 05:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1FQEFOP8k3SAXbImBIiqpJfmOdRRtRiacZt1f1LEqok=;
        b=E3TYauW4TPVtlpWpGNXnLdNMHfBBvPHEF/LwwlTf7OZlTcJs7jAMSgBLABLVt5PnL+
         HyQmbi9//rm6IdZN2fqORsmYqZqvnoh9wCoOBTEb4NKsB49CBGWc/PEXIQvarDJu1Hz/
         8cryvUe5/vf5R/kkJr1K6RrFV1VTIswF/l9LMCjIt87CWzPTyJ8Cvad3ehuamgYjSnsR
         IuRVmZ5Lu8RVNOJdeIjvALjUXXJdigAtIvBuGjCpcMrN6Fyvg0udAkykiAFb3+70GTTU
         IzahDBAnmlRYjE0pdqAJbwPWRE5hGQFCbiegt47/5qZYm0vlAqzQaAU/Sj1qTeL2V4v5
         frxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1FQEFOP8k3SAXbImBIiqpJfmOdRRtRiacZt1f1LEqok=;
        b=paEBvp0Gx5eqNdTz714bhV+XvnfSP1SqcH3G0rgTU5dK4fuyc3H36/sfb+1ZMF19v9
         KnbJhyWCVXua2xqKCZ1F/Op7SlFsJdnqjiGpZ649jo6t3JWIWObatRDisdZRSSzcQyyx
         2ToBO/F9dtP/YGkwzBq9idSKdl2LbuQQqmTSR0UW53uXa/1WdpaLjo6bJUhZko6NUFlU
         WNX0cHm9O8D4EiZHX2+86xH6WAhxIEzF2b7jVpB8RBSEpFNJ/LuNKS45mGaGM98BagAH
         CTuUquIrClYu2vMwAvG1E7I16+EmN6lQbromFcejZUFBajh6naq7gPbNEbetj6UOhJU3
         S3Pw==
X-Gm-Message-State: APjAAAWo8DUb8UtpB/ZtkXbY8lQoxa4nteEenZmP15Moii+X7GYqP+K9
        v5EfdgMzDUbni+h1zVrmFNgCBg==
X-Google-Smtp-Source: APXvYqy+vTpb4+HCLB7KdfFc3jtA6JL7ae0EIjboDWKhsxQ4bU4M2hS4PqfhXanx6PJ5pjpmGLU9yg==
X-Received: by 2002:a05:651c:1053:: with SMTP id x19mr22406217ljm.39.1574690352732;
        Mon, 25 Nov 2019 05:59:12 -0800 (PST)
Received: from centauri.lan (ua-84-217-220-205.bbcust.telenor.se. [84.217.220.205])
        by smtp.gmail.com with ESMTPSA id w71sm4189705lff.0.2019.11.25.05.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 05:59:11 -0800 (PST)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     amit.kucheria@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v3 0/7] Clock changes to support cpufreq on QCS404
Date:   Mon, 25 Nov 2019 14:59:02 +0100
Message-Id: <20191125135910.679310-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following clock changes are required to enable cpufreq support on
the QCS404.

Changes since v2:
-Addressed Stephen Boyd's comment regarding apcs-msm8916
should use new way of specifying clock parents.
-DT binding now has "pll" as first clock, in order to
not break DT backwards compatibility (in case no clock-names
are given).
-Moved EPROBE_DEFER error handling to its own patch.

Jorge Ramirez-Ortiz (6):
  dt-bindings: mailbox: qcom: Add clock-name optional property
  clk: qcom: gcc: limit GPLL0_AO_OUT operating frequency
  clk: qcom: hfpll: register as clock provider
  clk: qcom: hfpll: CLK_IGNORE_UNUSED
  clk: qcom: hfpll: use clk_parent_data to specify the parent
  clk: qcom: apcs-msm8916: silently error out on EPROBE_DEFER

Niklas Cassel (1):
  clk: qcom: apcs-msm8916: use clk_parent_data to specify the parent

 .../mailbox/qcom,apcs-kpss-global.txt         | 24 ++++++++++++++---
 drivers/clk/qcom/apcs-msm8916.c               | 26 ++++++++++++++-----
 drivers/clk/qcom/clk-alpha-pll.c              |  8 ++++++
 drivers/clk/qcom/clk-alpha-pll.h              |  1 +
 drivers/clk/qcom/gcc-qcs404.c                 |  2 +-
 drivers/clk/qcom/hfpll.c                      | 21 +++++++++++++--
 6 files changed, 70 insertions(+), 12 deletions(-)

-- 
2.23.0

