Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55A03192B05
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 15:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgCYOWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 10:22:34 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41262 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbgCYOWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 10:22:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id b1so1205655pgm.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 07:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pcFRyCnL2SJ7lsWb00Ktgfpiha1T6QVZTxHpgve0HfA=;
        b=IBvMOXic3QYDgQSRZGPtISAPOTYAbBG+IPlPXOuv8W5fiiD/2joX9ypEKZDeqzeXtR
         9hv8+1RDYXz/f0teGPl8n/iRkNmc7DMFBw6PpIJ29ObnRdulDiQB9oz0xG2tz6jqMUXp
         cfNHYHvZPQVuVfWaa93mk4GzBZ/ynzZbbl4OwI2Pt+lARObkyRoCkY0JcZy0y8cq5u8F
         RkTgMPqCwAyUj/JuNLaeHL57azs0LRCeL12fOcQb8KK4dMmRY2sVY80+L1JsUZeYigx3
         qbNYX7PL1yYalalmDh8yUsrxxnR4f6kTkc/jcu3VtRtbXItJy3KqVugRDo6VH7/R1OKo
         talw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pcFRyCnL2SJ7lsWb00Ktgfpiha1T6QVZTxHpgve0HfA=;
        b=QNzvjSHbYqY+5ztP/x1FEUvr0lvtkWciY7gXcANJmlHM/lU8U1M/ZCBTSSNlEwI0Fk
         U6HH1yY630EVLDhPwwJubQnzVbMJFMH/KcUn4NUfnrNf2zY5Mfp2AcEuSZnUJm9HR2nc
         jeKeEP7KZpDftMn7nVFh45ZnvFEs+KiqYid2eYHtAr5WeD+uubG8FcOhctLbzZkcY26n
         O8TWs/aiQTXnIvTdMRLl/0Nax/zAT4fAQD6r1ucDgzl/HQmQyqz+aQTsAngtAnuaNfZF
         kHhi7asKz2G5f13YxJPdi36fEPj6EHAhPWafZqKQUJVHtLJOWxsJESJdXk2uzTpFW7/9
         eGow==
X-Gm-Message-State: ANhLgQ09HipX3sV/41ERCv3+nMtc18xJCt4uvyez+a/5+8RYNdYRfTPV
        1OpvJHmL9pGqPSIkK2rlxr4=
X-Google-Smtp-Source: ADFU+vsRMsStWrusCqvyO22VEA+D9RFGOgQSEUQ7ZI4dwMat4P6s70DROLp/Vz5sQI0aOgfCkLinXw==
X-Received: by 2002:a63:7359:: with SMTP id d25mr3285349pgn.2.1585146152947;
        Wed, 25 Mar 2020 07:22:32 -0700 (PDT)
Received: from simran-Inspiron-5558 ([2409:4052:78f:bb47:8124:5e4b:ea06:7595])
        by smtp.gmail.com with ESMTPSA id x4sm16570514pgi.76.2020.03.25.07.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 07:22:32 -0700 (PDT)
Date:   Wed, 25 Mar 2020 19:52:26 +0530
From:   Simran Singhal <singhalsimran0@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel <outreachy-kernel@googlegroups.com>
Subject: [PATCH] staging: rtl8723bs: Remove multiple assignments
Message-ID: <20200325142226.GA14711@simran-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove multiple assignments by factorizing them.
Problem found using checkpatch.pl:-
CHECK: multiple assignments should be avoided

Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 61a9bf61b976..744b40dd4cf0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -194,7 +194,9 @@ int rtw_init_cmd_priv(struct	cmd_priv *pcmdpriv)
 
 	pcmdpriv->rsp_buf = pcmdpriv->rsp_allocated_buf  +  4 - ((SIZE_PTR)(pcmdpriv->rsp_allocated_buf) & 3);
 
-	pcmdpriv->cmd_issued_cnt = pcmdpriv->cmd_done_cnt = pcmdpriv->rsp_cnt = 0;
+	pcmdpriv->cmd_issued_cnt = 0;
+	pcmdpriv->cmd_done_cnt = 0;
+	pcmdpriv->rsp_cnt = 0;
 
 	mutex_init(&pcmdpriv->sctx_mutex);
 exit:
@@ -2138,7 +2140,8 @@ void rtw_setassocsta_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *
 		goto exit;
 	}
 
-	psta->aid = psta->mac_id = passocsta_rsp->cam_id;
+	psta->aid = passocsta_rsp->cam_id;
+	psta->mac_id = passocsta_rsp->cam_id;
 
 	spin_lock_bh(&pmlmepriv->lock);
 
-- 
2.17.1

