Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28E44187976
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 07:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgCQGPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 02:15:37 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:53258 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgCQGPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 02:15:37 -0400
Received: by mail-wm1-f54.google.com with SMTP id 25so20103423wmk.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 23:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=vOZIH8F64Sc67v6hbXriJW6HY6fOk7Q348T3idirB4M=;
        b=YyhSSbWQBWDhXSE1PRpQe0l/+QCff5YLfGrRYiwyHSWTP9uzdyypVAuIaL3qq+d/8g
         EwGiMWAQY8JCvMsT2WRTUojwHYvcRIJ/24WnscisMMIg1RJyqq9TbNjZ4I04D/fyuDv9
         hIm9SQ/K9BxOvGftfllOejo78+TeiFAXl5vyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vOZIH8F64Sc67v6hbXriJW6HY6fOk7Q348T3idirB4M=;
        b=leB8nc5oatCZL1V7FltUtLUV14IQrGMkSAWym0g97r7icXmRbBX9XITQB6xuyKsmQC
         1SpPMdZtgH62AtFopETs5DxFkZoSN/pb8QkVHhWSsxNGvcArGBUs/Ql2w4Eb1gsjL3gh
         i7J93bJBH/lU2ocB0den1fSqnEdR3zuUonDeFWNiePKvAqW456cLPrEAdp4hFo1aF3Py
         ypoL9vuqeWPsyrUtUcm0E4aFgyzNrjUThOK+vbLOxCRESJgr/zYf8LmRwJ+3KhvnwAt2
         oVvI1UCa0DbC5GV0kAoBwmzbYLU30hTwgMcyB9UAZcxr8BECFi8DELTLLHV2vGeelatD
         mDDg==
X-Gm-Message-State: ANhLgQ0pAllK1JVLmOQ1fpsTGhc3IltuW0JyBWRKVqhmYf6LK4vUg0++
        ZFOawBvxQ/UW7ZVG4Gdo81Vt7w==
X-Google-Smtp-Source: ADFU+vvucMygb6X8ybeNHfpyaKgLW4A2wZEKLDOJaOFxYC/dcJt5rDLyWtRw4B1KkrV4YWIN9JdRHA==
X-Received: by 2002:a1c:ba85:: with SMTP id k127mr3091197wmf.63.1584425734805;
        Mon, 16 Mar 2020 23:15:34 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id o5sm2658096wmb.8.2020.03.16.23.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 23:15:34 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Allison Randal <allison@lohutok.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v1 0/2] Remove BUG_ON() and fix -ve array indexing 
Date:   Tue, 17 Mar 2020 11:45:20 +0530
Message-Id: <20200317061522.12685-1-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series contains following changes,

1. Avoid use of BUG_ON to prevent kernel crash and return error instead.
2. Fix possible negative array indexing

Rayagonda Kokatanur (2):
  async_tx: return error instead of BUG_ON
  async_tx: fix possible negative array indexing

 crypto/async_tx/async_raid6_recov.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
2.17.1

