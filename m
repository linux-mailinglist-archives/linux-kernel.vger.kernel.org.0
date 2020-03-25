Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0589192AB2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 15:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgCYOCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 10:02:54 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45692 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbgCYOCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 10:02:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id b9so821831pls.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 07:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hPei7KKSdldCeCCsKO5OWNthcsFfdP9+OayFNsIx/2U=;
        b=Gk1sq/UJs8brD9KtcK2Ggj9/1+LHC7Rc7ObOoo4MbaTZB28viRL5bKcXESZK6p3mDF
         wklCCsF7b2+0pmrix3I0KYDKDP2zp65JzLItfn7UHmfis8J2Yl090nnmqV/QFFs29IlM
         RIlcRH6Ucgf45velQiOnaAX5/8RqmIUqtxXsG0Lpqvf8nqT1/mL323xUo0Qli5SyvdNp
         crlJiEMzFhTeGWBlFRccYuUMnOb1Iyt1K9z7a+v+WgQnni/mI+QFl8Sg73Lp4EhlHZs3
         ZxTgOxJl/EFHRH3TLDPnnGjXfBOPGrI21dG3v8rYXpjSDaipdbHm1jmx7sk0xIS7/0qe
         29IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hPei7KKSdldCeCCsKO5OWNthcsFfdP9+OayFNsIx/2U=;
        b=rWxAnVf6nVJZVmxZp7FolEvHzpUnsbvGcABO2Z3U7JgjPU91FIhQMLJOMTDHi4AeVQ
         /A9q7gAxV8JynmxjdSpXzR4wnyGRvtHAeUHAS5HEi/itzaieGbdHpKG2Y0HXlugj8yhu
         nGLrTm22xSFlfvMjk7Ve2MoDRpnLf7xdKSaJoS3qClKdXJorEN3wUaPG/gODnoZRstx+
         xkcKLTfTfmtkXJ6bWyr7gvZ/gLBEwf6CXvTFOda7aacmFARpF3cCX3JwVaWpT2x4I3Sy
         QYeh5aJGm2MM5Qld2jQFsxRht5IXsMhmx33/H24FSXKlxpHIRmwybuBv3jwFufoRIDht
         Auhg==
X-Gm-Message-State: ANhLgQ3Q8WvTa3shwoz7ZhYrU51YiOCNxzB3BlZzTQol0NnOApEBjTT9
        T18Bh9DHQKlSH+wYkWPHJPpWLRZyFm0=
X-Google-Smtp-Source: ADFU+vuCDtacPWakvILyOWambzGgVeVvCnBOdFdO7oVQqymfM8huy9lkpkaZSI6cr1yw71rm9Tukqg==
X-Received: by 2002:a17:902:b68b:: with SMTP id c11mr3254418pls.186.1585144972528;
        Wed, 25 Mar 2020 07:02:52 -0700 (PDT)
Received: from simran-Inspiron-5558 ([2409:4052:78f:bb47:8124:5e4b:ea06:7595])
        by smtp.gmail.com with ESMTPSA id r186sm19048448pfc.181.2020.03.25.07.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 07:02:51 -0700 (PDT)
Date:   Wed, 25 Mar 2020 19:32:45 +0530
From:   Simran Singhal <singhalsimran0@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel <outreachy-kernel@googlegroups.com>
Subject: [PATCH] staging: rtl8723bs: Remove unnecessary braces for single
 statements
Message-ID: <20200325140245.GA11949@simran-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up unnecessary braces around single statement blocks.
Issues reported by checkpatch.pl as:
WARNING: braces {} are not necessary for single statement blocks

Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index bdb6ff8aab7d..de7d15fdc936 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -43,9 +43,8 @@ Efuse_Read1ByteFromFakeContent(
 	u16 	Offset,
 	u8 *Value)
 {
-	if (Offset >= EFUSE_MAX_HW_SIZE) {
+	if (Offset >= EFUSE_MAX_HW_SIZE)
 		return false;
-	}
 	/* DbgPrint("Read fake content, offset = %d\n", Offset); */
 	if (fakeEfuseBank == 0)
 		*Value = fakeEfuseContent[Offset];
@@ -65,14 +64,12 @@ Efuse_Write1ByteToFakeContent(
 	u16 	Offset,
 	u8 Value)
 {
-	if (Offset >= EFUSE_MAX_HW_SIZE) {
+	if (Offset >= EFUSE_MAX_HW_SIZE)
 		return false;
-	}
 	if (fakeEfuseBank == 0)
 		fakeEfuseContent[Offset] = Value;
-	else {
+	else
 		fakeBTEfuseContent[fakeEfuseBank-1][Offset] = Value;
-	}
 	return true;
 }
 
-- 
2.17.1

