Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8451AC00
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2019 14:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfELMTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 May 2019 08:19:31 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36598 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfELMTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 08:19:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id d21so5029350plr.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 05:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XnvQJc31NkYJDKHGe2ZPAaF9BNwwW3ZlTSoXFk3nhO4=;
        b=Qni6gC2qcHVxnGYXbzGXFA9Yp5N6QGoVnRMAzbqDpG5X4dbAjsX3knozjJcOCcsecR
         GOzEjXGzJkgzewVsUxOpYfTjVOHxBedYDgI2eB//Qw4tqPeHpxAUq1/yEzzt/plXutlS
         1OMRMgzbAZErJJbiqmvqlTytA3mDI5Tz3t6eZw3Tq1YK65C6kZRu75Wa+dLFhGsxf254
         dwFRqJRyR9jVVMoJpS49BSe5kt6wfvu2Yx1w3c9JTX8DH9mUCj9I5Oqfiqh+fjEfrNmi
         F0U/wosSM5aAlfjQSKX6ATNwB8/GzzNFXMpxmvujMUU0J0xDVoSe75ZRGYSD3fjOaQWN
         105w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XnvQJc31NkYJDKHGe2ZPAaF9BNwwW3ZlTSoXFk3nhO4=;
        b=kd26TP+h8cbdqrXrhjWFF4whYHFiOwPmRihizJ04Vvw/5xwU32Qp8H00icH4EkiwEM
         oEURNb2RL8S/ouBHArq/mHffQgqcuOuRWNHp6ynVxKsldB9SjV8SY0+20+ApL/OEvq4q
         SHbUoFCyDRFRfw9n/A36Xlz7v+7gfEa0o2gpsuuExFOZ11wME81FTeLq9HQYVkQW7VyF
         4jlarQMoX+GmviLPJ6fNLMWp03QKln9AkKooJ2ebIswLwvD3z0s18NnqETb0bea+MhS5
         v4ZQ+IBST5E/HgRKX1IjvGhInXcIZxvaZutzyIzt2Wz+3Ftlh46kFUTIRpngqcmiujXL
         0djg==
X-Gm-Message-State: APjAAAU6mOA38QMdt0GiNidI13+SLYBtw+lO9chlVcKcJp5JUbOV9bov
        1Toie5pU5TA4uwEf5FlgRPc=
X-Google-Smtp-Source: APXvYqyC83gg6Ai8bfXkwZua15B6U4OweOWKPKmYAfnGwlo5mj9QUpnoGiMZe3g8HkfI0XukjYdO9g==
X-Received: by 2002:a17:902:2827:: with SMTP id e36mr24196393plb.45.1557663570546;
        Sun, 12 May 2019 05:19:30 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id k6sm9195910pfi.86.2019.05.12.05.19.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 05:19:29 -0700 (PDT)
Date:   Sun, 12 May 2019 17:49:23 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        viswanath.barenkala@gmail.com
Subject: [PATCH] staging: rtl8723bs: core  fix warning  "Comparison to bool"
Message-ID: <20190512121923.GA28044@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below issue reported by coccicheck
drivers/staging/rtl8723bs/core/rtw_cmd.c:1741:7-17: WARNING: Comparison
to bool

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index ecaa769..fcd26e1 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -1738,7 +1738,7 @@ static void rtw_chk_hi_queue_hdl(struct adapter *padapter)
 			pstapriv->tim_bitmap &= ~BIT(0);
 			pstapriv->sta_dz_bitmap &= ~BIT(0);
 
-			if (update_tim == true)
+			if (update_tim)
 				update_beacon(padapter, _TIM_IE_, NULL, true);
 		} else {/* re check again */
 			rtw_chk_hi_queue_cmd(padapter);
-- 
2.7.4

