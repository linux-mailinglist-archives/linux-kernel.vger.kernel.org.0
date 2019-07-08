Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 584D96216D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 17:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732512AbfGHPQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 11:16:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52982 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732484AbfGHPQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:16:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so16215649wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 08:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4qzR4omyvnCQwhdi4cNzf5tBSJqOSHSRkztTq96lWdM=;
        b=ZWQ8ngwo7LPXEhMtdZT3TFlPspqa4w+MolShNw779kfBrsGJ0/C1sdQGaZhBC4o/8I
         UU3+AaXTT3gDTTsn9jtXPoBzBTTP4bWuUs+59k6MYnrxLSI1xlwwtvFfXRicrCtdeXJr
         pkPOu6lW3hNB3gBgPdy7LslXdrFEtM8ac8nKrvKWR7FHZvuyXI0ZoUPmHDonKJeJVwb1
         ilruVxXuTyzcCkjc1rEzLSSw0y+RJSVAKeZ2ZpE3Ia2Lhh+6VnvnuF0VcZcIylFqcaFn
         3RRjkQyJde6ca2+i4EyAmWRH2TcW4cWD62ULOrAcBqNvHHYjbD6rePaQ8+9LPBrNEnYq
         cM7g==
X-Gm-Message-State: APjAAAVmYO0ilqRmgejCzbn3CZSDaTZbxWD1dZAOVNzxIHiNEdkl8p60
        TBqqnXKbxavitTixLGaGzZg=
X-Google-Smtp-Source: APXvYqywOHj54jipuRrIB89UjWIzmuFjRHAVKyvuqOIMMZbH3/64R80z1LqgM04DZHwRgDWxC0zuZQ==
X-Received: by 2002:a1c:5453:: with SMTP id p19mr16127157wmi.148.1562598969098;
        Mon, 08 Jul 2019 08:16:09 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id l9sm12499891wmh.36.2019.07.08.08.16.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 08:16:08 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Sven Schmidt <4sschmid@informatik.uni-hamburg.de>
Cc:     Denis Efremov <efremov@linux.com>, Arnd Bergmann <arnd@arndb.de>,
        Bongkyu Kim <bongkyu.kim@lge.com>,
        Rui Salvaterra <rsalvaterra@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] lib/lz4: remove the exporting of LZ4HC_setExternalDict
Date:   Mon,  8 Jul 2019 18:15:55 +0300
Message-Id: <20190708151555.8070-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function LZ4HC_setExternalDict is declared static and marked
EXPORT_SYMBOL, which is at best an odd combination. Because the function
is not used outside of the lib/lz4/lz4hc_compress.c file it is defined in,
this commit removes the EXPORT_SYMBOL() marking.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 lib/lz4/lz4hc_compress.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/lz4/lz4hc_compress.c b/lib/lz4/lz4hc_compress.c
index 176f03b83e56..1b61d874e337 100644
--- a/lib/lz4/lz4hc_compress.c
+++ b/lib/lz4/lz4hc_compress.c
@@ -663,7 +663,6 @@ static void LZ4HC_setExternalDict(
 	/* match referencing will resume from there */
 	ctxPtr->nextToUpdate = ctxPtr->dictLimit;
 }
-EXPORT_SYMBOL(LZ4HC_setExternalDict);
 
 static int LZ4_compressHC_continue_generic(
 	LZ4_streamHC_t *LZ4_streamHCPtr,
-- 
2.21.0

