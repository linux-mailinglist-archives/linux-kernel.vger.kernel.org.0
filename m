Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0952D33749
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 19:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfFCRwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 13:52:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39872 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfFCRwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:52:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id 196so8711200pgc.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 10:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=DGoxdD5EUIGT9bBxoW5B+18v9hq8tueDEjWNmvtG0II=;
        b=ob1LuuhjIlmwK3FDWvTNjdt5OAF8gJwg61MhWz2Mx/CWZtO36JkJe2KxBFhHrd/r/6
         3NI+AAM2zh+2+hfcvuvBT5tbwG/HCWd5QAdIrLQRPFMud2AY0NKW9/CI14FNeeqlAOV4
         ZjKEbiFClDENsZ8mC6zmO28eFhmmKZ3QL/NrNRjUD+MNT3IHEjHGPxvb+3wCdEWZN80m
         CLAdQdImWDFk8LKVgvMMKvHI+yaYfsnGwIKIcwQJYBAv1I500HiDj8iCSLvrnLmoy7A0
         5Bhg4qqM+iTEHPXsJlZIL8Z+x28aJFhCq7QdGpQOC4uKbUeGZ7oFpdBt1QbkZCCptcSo
         e00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DGoxdD5EUIGT9bBxoW5B+18v9hq8tueDEjWNmvtG0II=;
        b=hrATWORgMyzYV7IR2NgqFpU3EzvuWly4Z1vUjs0ewcEpZChKOtUxOXvgPT3LJABSVE
         d3wYMQ5h/EFB9ulaaKGdczhEkQwldEio4MtHrf7fvBhe4Yqr5s/OIbbDTp1Xq1heLSd+
         +n94DSkl22Asig1Lx7xFpQ3qs4z2y2E/U4kMimqsAg7haGupMdKFJopVwtXoNlD61Ft5
         YqQkUuWLgJWNWuO+pk8wYJxvbZ18BcGkDS72gs+yS3Q77i/ce08KhMxVYnXP8PuCXIrQ
         Vl7lpy/WiF8aZ5iHTPzyo0HN/lc1mUhZd4kim3ShSCJyGurN4nA5EOlvDvDJeb4X1Yr7
         R7jQ==
X-Gm-Message-State: APjAAAXIzaerefMyDZUeB6LshBnV00o4ThQgSLLuV4/WWCaRUnu8dBtp
        EPV/0xiD5NWU1wRb0Ab/iTo=
X-Google-Smtp-Source: APXvYqyzlJBE8dZ2W7VdzNCe0CNxLtYKrIcDjILqD3pD1BNSm89pIOihJmk7uZXlhG7hqgMlJhHiTA==
X-Received: by 2002:a63:d504:: with SMTP id c4mr21542620pgg.20.1559584350790;
        Mon, 03 Jun 2019 10:52:30 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id 127sm15459038pfc.159.2019.06.03.10.52.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 10:52:29 -0700 (PDT)
Date:   Mon, 3 Jun 2019 23:22:24 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Himadri Pandya <himadri18.07@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: hal: fix error "do not initialise
 globals to 0"
Message-ID: <20190603175224.GA4969@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch fixes below Errors reported by checkpatch

ERROR: do not initialise globals to 0
+u8 g_fwdl_chksum_fail = 0;

ERROR: do not initialise globals to 0
+u8 g_fwdl_wintint_rdy_fail = 0;

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index caa8e2f..21f2365 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -217,7 +217,7 @@ void _8051Reset8723(struct adapter *padapter)
 	DBG_8192C("%s: Finish\n", __func__);
 }
 
-u8 g_fwdl_chksum_fail = 0;
+u8 g_fwdl_chksum_fail;
 
 static s32 polling_fwdl_chksum(
 	struct adapter *adapter, u32 min_cnt, u32 timeout_ms
@@ -262,7 +262,7 @@ static s32 polling_fwdl_chksum(
 	return ret;
 }
 
-u8 g_fwdl_wintint_rdy_fail = 0;
+u8 g_fwdl_wintint_rdy_fail;
 
 static s32 _FWFreeToGo(struct adapter *adapter, u32 min_cnt, u32 timeout_ms)
 {
-- 
2.7.4

