Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB4AF3208C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2019 20:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfFASoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jun 2019 14:44:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39436 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfFASoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 14:44:14 -0400
Received: by mail-pl1-f196.google.com with SMTP id g9so5333209plm.6
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 11:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Rl/6dScitwdypeg0n6DxuRwXm6KjrL0ouk1WDtSz0Y=;
        b=OkQxdGuV+IZVd0b3zColkHfKq8saak3FQc+5Fh3EyeDjWulfnUWyoFi02IoCg1n/I9
         Nn6NpEC+yx62Vfw+5rdsOkwGD+SNOrgVcVWYIqqrNokwW21y+8Z/RgAJDnAExkzPF+Ec
         ai1ASLTn8uywIss10Pykciiz65IeAqgckyzrOGW2LOA80Lr5lWpZQzMQPQCyhi8gOhrd
         5V+NyGTbrBptDW3jqh28GO9tDIvdOPB5IDiLUXA1IMqYNKQz2JfUsP16S3PfOxWKsG0m
         fB80TPrK8f3nokrNTIaE/HwcftAIl26C+lp+CsAJ/+3fJIAwujN+KMbKUYXQhH7PcqRE
         xPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Rl/6dScitwdypeg0n6DxuRwXm6KjrL0ouk1WDtSz0Y=;
        b=WLmcLzEBrihwsgDrgRduHe99b9o7ZD1GoSjfj7cA8brCAI8MlAgwHhGFvh/JYaEjox
         piy7/hHZyVqJH1dLy4eGG01LKnGAzRyLj7LWMrs32gRSr+VcwMAHD+oHMSkOYrmCuDmV
         4REYNA0Xr/hlgPYZN4O5nBFxTkixUDpeVCm1MKvubyz6NYbqVbydtoNtUCaOJMQcWHlx
         WkfHPhjgOhl+1SPP6dX7KTDKDOZHo00p/o4vMQ75iyRT6x0O/gnzSGR8qghF0vNAW58l
         /wsMw3JSmOVfZwwU2z2Es8Ji045Qf22vSRcuouYSBJbIZI9ukNW3dEVRIxc+lJy12zy0
         xqow==
X-Gm-Message-State: APjAAAV0VL3WOrrL67AcgN3k0eHyzv6KnsF/2Vzuxpo5NnVyXdynrID/
        ucRsKI19+Id1vjkicsjxtyhPCzzC
X-Google-Smtp-Source: APXvYqyAwQElvbd9hjpVyvd87GrKAfunToToAERCTlklkSegcs6ygoiLGrNl1h9s8wxB/7129qshhA==
X-Received: by 2002:a17:902:24d:: with SMTP id 71mr18827714plc.166.1559414653212;
        Sat, 01 Jun 2019 11:44:13 -0700 (PDT)
Received: from localhost.localdomain ([117.192.16.207])
        by smtp.googlemail.com with ESMTPSA id w187sm13287950pfw.20.2019.06.01.11.44.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jun 2019 11:44:12 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, linux.dkm@gmail.com,
        himadri18.07@gmail.com, straube.linux@gmail.com
Subject: [PATCH 4/8] staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h
Date:   Sun,  2 Jun 2019 00:13:38 +0530
Message-Id: <74eb6618908d203d86b043b037ccc788ca1b4d41.1559412149.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1559412149.git.linux.dkm@gmail.com>
References: <cover.1559412149.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes CamelCase evtThread in struct _adapter as reported by
checkpatch.pl
CHECK: Avoid CamelCase: <evtThread>

Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
---
 drivers/staging/rtl8712/drv_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index c6faafb13bdf..5360f049088a 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -153,7 +153,7 @@ struct _adapter {
 	u8	eeprom_address_size;
 	u8	hw_init_completed;
 	struct task_struct *cmd_thread;
-	pid_t evtThread;
+	pid_t evt_thread;
 	struct task_struct *xmitThread;
 	pid_t recvThread;
 	uint (*dvobj_init)(struct _adapter *adapter);
-- 
2.19.1

