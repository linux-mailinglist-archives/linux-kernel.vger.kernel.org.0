Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6DB1188689
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 14:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgCQN5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 09:57:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35938 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgCQN5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:57:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id s5so25860604wrg.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 06:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R7mPWyazQzpq+QB7kvcjm1xqFg1EYXZslw7p+6l9zyk=;
        b=almf5Jtj3eNx0d/aXBR7+Oze2+ETeYjtyMlJ9OEbQmb8gMN8blXwHv2GG8cTMSG8Gb
         TqQI2NvD/8dBdMeEBmIXhIlFHwrbl/hv5ChDDsNGpnlpK5hvQzof8fIixUIUsBguIXTb
         KDN4gxBzEroJNoXlYrX/bRITTsURtbZ+0C1rc3DI0n3W0P0ylmLJ6omYznM5Mry+BHEl
         sXOc3Pq73C98/nsy0iLaajh56wLjwq7AMkYoauh0RYGnVUMCy44eNrnIGcJTSZeVDb/w
         dYQ9baRi0UO2Pr1LUpCM6HKEzgo2MXSbZM7mFSpDv3xrJ2Ax8m4VmF9IwYMZTjiNJSAG
         YvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R7mPWyazQzpq+QB7kvcjm1xqFg1EYXZslw7p+6l9zyk=;
        b=I3GMNe7TerjBsgNX6cOP351MclOf1vzOBT+L9aKy1SJyVs8tIiBsFKELmlorDKipA2
         MOf2gZz92EQc/t5qHzuk6d2Jxh5pgP0I53J2seV0Q2euYAoqKGDVc+AH64WKmXkYdjBu
         fsvnZfTFp4TDAurHOPR2AvCcObDmiq9IBHxru1VKr2g7nLKZY8kC+QVIyjIHEtvYGVl9
         XzUjqrMhRXysg/0oQ48CyzwSJFu7IjC5EmiEoIeFVYl0NQkeEWQD+hVe3TFq/B7pO6bz
         EFZNkTcIPz087/zojvt9kBhoUa7X/KHXRLMVwEeFiGnE4fPY9GPi2arnUCFWS1i9AcOe
         nJbA==
X-Gm-Message-State: ANhLgQ2pfY/D/lk16qLR28h5EluO5jLl+n1IcePiu9JNOLP1mAHPm+8O
        zyCPWXNtPRR4NekXTkbRp+GI1Q==
X-Google-Smtp-Source: ADFU+vtjVlC/k5+6U/ZJ5/Eyy3Wu7I7oB0zbdo6cV/jFpbNjcRBn/Fnh1DNmBZO9Lag7OIncCJrjOw==
X-Received: by 2002:a5d:490e:: with SMTP id x14mr6707580wrq.58.1584453470131;
        Tue, 17 Mar 2020 06:57:50 -0700 (PDT)
Received: from xps7590.local ([2a02:2450:102f:13b8:84f7:5c25:a9d8:81a1])
        by smtp.gmail.com with ESMTPSA id r3sm2976558wrn.35.2020.03.17.06.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 06:57:49 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, olof@lixom.net, maxime@cerno.tech,
        Anson.Huang@nxp.com, dinguyen@kernel.org, leonard.crestez@nxp.com,
        marcin.juszkiewicz@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [v2 0/6] Qualcomm CCI & Camera for db410c & db845c
Date:   Tue, 17 Mar 2020 14:57:34 +0100
Message-Id: <20200317135740.19412-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series depends on the Qualcom CCI I2C driver series:
https://patchwork.kernel.org/cover/10569957/

This series enables basic camera functionality on the Qualcomm db410c and
db845c (RB3) platforms.

This includes building drivers as modules, adding devicetree nodes
for camera controllers, clocks, regulators and sensor nodes.

Loic Poulain (2):
  arm64: dts: msm8916: Add i2c-qcom-cci node
  arm64: dts: apq8016-sbc: Add CCI/Sensor nodes

Robert Foss (4):
  arm64: dts: sdm845: Add i2c-qcom-cci node
  arm64: dts: sdm845-db845c: Add pm_8998 gpio names
  arm64: dts: sdm845-db845c: Add ov8856 & ov7251 camera nodes
  arm64: defconfig: Enable QCOM CAMCC, CAMSS and CCI drivers

 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi  |  76 ++++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi      |  27 +++
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 210 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi       |  92 +++++++++
 arch/arm64/configs/defconfig               |   4 +
 5 files changed, 409 insertions(+)

-- 
2.20.1

