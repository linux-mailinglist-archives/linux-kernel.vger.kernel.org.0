Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A04A10D9E3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2019 20:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfK2TFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Nov 2019 14:05:54 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:46885 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfK2TFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 14:05:54 -0500
Received: by mail-pj1-f68.google.com with SMTP id z21so2057813pjq.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 11:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Tput1dndwwpf2AerG7ygIFUf2lPuIOL1u2Rfqh3NfVk=;
        b=BvzraM8CKAkmCxfYac7IabmSaA3XEhDd8HpdyMp+V6oEIXnvMQ0HYoaW8qLnxl1Bu5
         tdCjjxeqp+1ojRgWyB0OoM6qU9D3D0jDR5RlY+o2UwpnG6igqT/FSRv/uIULFVtUuJh2
         WiNVnZbAIkyKXHxwBgcJl+Fj1e8+EOuOTj/BkpzkuFND2LlNyHcbjVO64ij5AALRU+g/
         Lt87Iaq2d5y1Xc0iUzbnFBU+13p//CszEE0d7yQaHTNAOFN7PAwEpfnLtOcR6ZpP1ZnE
         7lw7T3rVc1h4Wr6Icxk0y38/JpYdb2+oFC2z+C/Fa2bP7ew8XXKD4FJH4jWle+BK1vX3
         eSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Tput1dndwwpf2AerG7ygIFUf2lPuIOL1u2Rfqh3NfVk=;
        b=n4w2kIPtY6SmrJSVNU9LXEQ1QLHcB4zKapVA5VzYesZPWbSu5YrBvj80+kjh/gS3ch
         bHPe0+l8F8ort68KSXp9Ica0BqF3dB5bMz1H9XrSrh0a0HcUmX0JAlVcKzKnyy3pGIla
         QkGgR92zsuHBVPn0ty5hmRWOuO9Wh079qcPZWkBrxF9U6tptxuWIIV2LnBQNJ55jkBAB
         qgNzATGeklEKieDbch5zdffHyZqe6TSQfgPyyX1u1Iobp5n3hAa/062MLsAx/7OUoJgu
         cBzW/OB07DXnpgQG2wVYXrPfwlRijedIAC9NB6WOC54IhjTQrIrkH1VKDRxmXBfswdI3
         FpNA==
X-Gm-Message-State: APjAAAU0MW+mhm8iBtW1EV93NElYXAj527/VRCaOQeg8TYIy75puCklC
        tIdBCA1GMaDRhbLPIWnReNYP
X-Google-Smtp-Source: APXvYqzeLaLk5/vOg6eNz6870rE+kdGHOlazQZ3zrqxCvca4ydWQaL+eH7v+1YZ7kIhaW1TedvQLdg==
X-Received: by 2002:a17:902:fe06:: with SMTP id g6mr15355459plj.52.1575054353473;
        Fri, 29 Nov 2019 11:05:53 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:638d:cc55:d006:f721:cde2:1059])
        by smtp.gmail.com with ESMTPSA id h9sm25159974pgk.84.2019.11.29.11.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 11:05:52 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mchehab@kernel.org, sakari.ailus@iki.fi
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com, peter.griffin@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/5] Improvements to IMX290 CMOS driver
Date:   Sat, 30 Nov 2019 00:35:36 +0530
Message-Id: <20191129190541.30315-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds improvements to the existing IMX290 CMOS driver from
Sony. The major changes are adding 2 lane support, test pattern generation,
RAW12 mode support and configurable link frequency & pixel rate.

The link frequency & pixel rate combinations depend on various factors like
lane count, resolution and image format as per the datasheet.

Thanks,
Mani

Manivannan Sadhasivam (5):
  media: i2c: imx290: Add support for 2 data lanes
  media: i2c: imx290: Add support for test pattern generation
  media: i2c: imx290: Add RAW12 mode support
  media: i2c: imx290: Add support to enumerate all frame sizes
  media: i2c: imx290: Add configurable link frequency and pixel rate

 drivers/media/i2c/imx290.c | 328 +++++++++++++++++++++++++++++++------
 1 file changed, 277 insertions(+), 51 deletions(-)

-- 
2.17.1

