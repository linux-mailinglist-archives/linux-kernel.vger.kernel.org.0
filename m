Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1468E3A448
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 10:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfFIIIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jun 2019 04:08:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42360 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfFIIIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 04:08:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id l19so773730pgh.9;
        Sun, 09 Jun 2019 01:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-description
         :content-disposition:user-agent;
        bh=IojbENL8XN+NI9qFu6Ly3yajllnRzK7oNQnSNp6xNQg=;
        b=ZYho7So9bgZDRHi1ryq8+7iDr9AFpBi7NzAsJNmxm/jcw5S1a+VhlIzlhefrN1ZsKG
         lfS6qAT2VSD0EADybP6DQbyQwQ/BGixTuAHHrQYJHhTF686PqLVnAQ0BjxoivY4dEucv
         aH3amRLMWomsbLQ+cKy2La6sEzL8F4gyFeGQDI4p4OrzHeleoVDN+31S1qwYw7kStk7u
         Nq8tLY41AmHRtT36dirtHF+1f4uHdCdgEGjGnO4pM+XLvmFylXWbWLUN0JBL1UVwtYMi
         uuPP8vZ3yoPzovBAKLHCjTnNmf0qEb5pJdYTkQTNo+XwQz7t1KQMfxJunqy9tJ9ui8uu
         HbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-description:content-disposition:user-agent;
        bh=IojbENL8XN+NI9qFu6Ly3yajllnRzK7oNQnSNp6xNQg=;
        b=lO8Z1X8kObGd5/mgA+PKyF/i/Hmv+Xh8tCSRQWl/ZTLG/C4ni9FQPlTQNK6lq1G5Dk
         TVso6KByOa2vxXhrWx3jlz+u6QWMHQ95DcJUpd5d9RcoE3eQYfcTSS6UBEDI0isel+pD
         Ckv5iqvKPuLH1IO5VNo9EeoDGsY8+KQBxZgXJdDSZ3GeBBIp/isk775U5s3GeMUei9s9
         t7fSJl4dJrcAV/NkLtJbjS3JWSarUqr19ZSHvJ4ss6PQiFW2BL7abx2D1stlVyt6uWDQ
         sMjd3KfoCBx8qixTrXhaEDkAeqk80/Q+wjrbxBleR/w5y1qwcOhn/jWglSSbF0VGC804
         +iYg==
X-Gm-Message-State: APjAAAU7awzUo3TQV0lI10MksVEm5dreFgpNHJNtuU3JWQAASEuVvS4l
        wve6WT8XHAUvCVtOdjWWMUk=
X-Google-Smtp-Source: APXvYqx85K4bYEpmAgjECy+zZy5TlMfi0v6GND7kOy2dXU/bj7aI9EiFv5w1eiYyvw7n92316IgH6A==
X-Received: by 2002:a65:620d:: with SMTP id d13mr10806665pgv.109.1560067688122;
        Sun, 09 Jun 2019 01:08:08 -0700 (PDT)
Received: from saurav ([203.187.233.29])
        by smtp.gmail.com with ESMTPSA id b6sm4466183pgd.5.2019.06.09.01.08.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 09 Jun 2019 01:08:07 -0700 (PDT)
Date:   Sun, 9 Jun 2019 13:38:02 +0530
From:   Saurav-Girepunje <saurav.girepunje@gmail.com>
To:     b-liu@ti.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] Updated the function description for musb_stage0_irq
 Signed-off-by: Saurav-Girepunje <saurav.girepunje@gmail.com>
Message-ID: <20190609080753.GA7735@saurav>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: Updated the function description of musb_stage0_irq
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/usb/musb/musb_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 9f5a4819a744..2451e0ee2d01 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -909,7 +909,6 @@ static void musb_handle_intr_reset(struct musb *musb)
  * @param musb instance pointer
  * @param int_usb register contents
  * @param devctl
- * @param power
  */
 
 static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
-- 
2.20.1

Updated the function description of musb_stage0_irq.

a.
