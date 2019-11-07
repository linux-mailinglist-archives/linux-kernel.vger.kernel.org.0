Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE7CF3BE8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 00:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfKGXB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 18:01:27 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37882 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKGXB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 18:01:26 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so2912173lfp.4;
        Thu, 07 Nov 2019 15:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lygHo06DKrsil2Vyz7Ew+JAMSQw384+AKCwoQzmbUts=;
        b=SizpfCNig8TVyAYJvh4CSIKPYnsH9QQh/hCejsjGbaF1s+5MfEyU6u/ErmTfdOkjRO
         ZIpcz5pAGOEEQT0yc00UQYi+oasGLoJYKqAp71IseaBBwqVxuSR0XGlf7TTXT3mMHnch
         Awz6PV8gb27ebOsO2ne0qKADELqTD18UCBc6qjki7iOyS5nrwD72yKA0NbNZrPbBy+8Z
         QhHogzdblMlbZANoI3ks2H6XRolJjqtby4nVCJ0GsqARSwDt0nu8IRTJXFU/Cm4rRSth
         WG9kol8F0d1PiMRtdbo112Lu3UeWQ21yGCkClYFhWpk2JIg5CEK70bR0oHEbU8mwJ8qT
         Vk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lygHo06DKrsil2Vyz7Ew+JAMSQw384+AKCwoQzmbUts=;
        b=J6uBb8duoaMayNXpxQsnRA8kuDdDArPcPtDdk5r0Hiaf5m2fzpy+6DY2M5hJY4biYl
         fD3Wr3h4VhxTtXrBQ64hahfvvbd7F9AYwCkTENPOftMjLz7jhodZcDL4/zmQCmfFHjT3
         ggGke8yPzvGAjpd6TQna1wKl7r9yyyVXdL2Zy6hj5vh48a/JxiCIbh1SW7NCxHU0JpkM
         diVwFvH5v3Rj5N0juIIpgiVbpuWvpXfT0Z32saIMtiK02EozcrTInF3Kxmr9qfJe017g
         KW7yDkmC0zeFX9QItST0dQOHLYdLOXGBduRJ5XTfzosKtZJwPnRFsNLEama8Bwom6BQq
         bgaw==
X-Gm-Message-State: APjAAAUrLK8Ich3Pte5tWrSR4aox6QWt+yFuctIBBZRGGuEn8c+vR1Pj
        lA7mEF4TrYL4DIylkweC/gW+3dYQIa0=
X-Google-Smtp-Source: APXvYqwpIMj37XM+Nc/NqDuHentI54sZtouQIJHXgKGiXEni+mjLiNasBAXdO+jRX0+0IUIT0eH+fw==
X-Received: by 2002:ac2:4651:: with SMTP id s17mr4237880lfo.46.1573167684188;
        Thu, 07 Nov 2019 15:01:24 -0800 (PST)
Received: from localhost.localdomain ([91.237.107.85])
        by smtp.googlemail.com with ESMTPSA id j8sm1554338lja.32.2019.11.07.15.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 15:01:23 -0800 (PST)
From:   Leonid Maksymchuk <leonmaxx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, chiu@endlessm.com,
        yurii.pavlovskyi@gmail.com, kristian@klausen.dk,
        andy@infradead.org, dvhart@infradead.org, corentin.chary@gmail.com,
        Leonid Maksymchuk <leonmaxx@gmail.com>
Subject: [PATCH v3 0/3] asus_wmi: Support of ASUS TUF laptops on Ryzen CPUs
Date:   Fri,  8 Nov 2019 01:01:05 +0200
Message-Id: <20191107230105.30574-1-leonmaxx@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch series adds support of ASUS TUF laptops on Ryzen CPUs to existing
asus_wmi platform driver and also fixes minor bug.

v2: fixed indentation.
v3: patches 2/3 and 3/3 are refactored.

Leonid Maksymchuk (3):
  asus_wmi: Fix return value of fan_boost_mode_store
  asus_wmi: Support fan boost mode on FX505DY/FX705DY
  asus_wmi: Set default fan boost mode to normal

 drivers/platform/x86/asus-wmi.c            | 55 ++++++++++++++++------
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 42 insertions(+), 14 deletions(-)

-- 
2.23.0

