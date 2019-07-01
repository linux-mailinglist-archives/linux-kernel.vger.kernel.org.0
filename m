Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B506813BA8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2019 20:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfEDSio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 May 2019 14:38:44 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36670 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbfEDSie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 14:38:34 -0400
Received: by mail-lf1-f67.google.com with SMTP id u17so6530431lfi.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 11:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4F8WeLtygmkHaRNyG44s6a3jySfehUltNliwBSf+M7I=;
        b=poFms3OoHIZ7PDf7AcMggrXiPPAh59WkpmIF2VbxFE7gTfz4WKBU7bxZdH1UzD4OXs
         oT4Np4UiPDYkTk2tfUM1AJtNfDkHp6ufjC26vz8IxSYxcp0Pl2CnxK4+Bg8QOek9WcEJ
         y0pKxFEqD6JpZoPSEmoNNd97TG5pituizKE52/uujD65zx8mODr4o7vZgq3M4POm/zTL
         Od8RatYkTVxVmYgfKQ7gKGLM1sUKUDOqS1WSzPPYfniHEl0rH6ctVslsgt7jecofHms4
         2SqAYuhI1vhSNZwSl3XPCnrZ37qjeeTVkO2mqXqXA5myow+ssHzhl5U5TRQOrQughVcT
         h2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4F8WeLtygmkHaRNyG44s6a3jySfehUltNliwBSf+M7I=;
        b=V/9xSGG3n3SkoS87oWRm69Dim9W07Al0Yr6NR1PA+1y2T+FyQE8gQRKm36sukw33kj
         MMfSWhWatE+lzRb0H1uBURbpMfGOE3M3IHlOv8LT7+Ex91bgllc/MmoYXJLMyNN0muOI
         dtSQhsnjC9+06TDPRQS+OcUoghWCoV8ZGHwqSHrU6Ullzk8Tc5xFdEyLkjQkrthZ8ZNa
         FfmDHYR0v0jilLVH54m4bBP1QTCGIYY39iKB3sXpzPLY+pFMkzl+S/aomb0Z1ZF+MDNh
         qn5iKJIp7KY4/1CUMYvsroNiLPFgbn+VBneD2k2XU+7yoDa8xlaffJWguJotVNGJmI2K
         kOMQ==
X-Gm-Message-State: APjAAAVO+3low8Y7iasqD13hlisjsEt176j97ovAAmX3+MbDrmNWjmUb
        tiHyy6pQPVUXAG9vANQZRC7HCw==
X-Google-Smtp-Source: APXvYqzDN1JoftxMCs2EYI3TFANu6Q6uv8AuBwVW8Mwi5t8BldhwlSNeh0R0Z0jTZUQcYtOWeGyfvQ==
X-Received: by 2002:a19:4a04:: with SMTP id x4mr8407373lfa.124.1556995113131;
        Sat, 04 May 2019 11:38:33 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id q21sm1050260lfa.84.2019.05.04.11.38.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:38:32 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 07/26] lightnvm: pblk: ensure that erase is chunk aligned
Date:   Sat,  4 May 2019 20:37:52 +0200
Message-Id: <20190504183811.18725-8-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190504183811.18725-1-mb@lightnvm.io>
References: <20190504183811.18725-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

The sector bits in the erase command may be uninitialized are
uninitialized, causing the erase LBA to be unaligned to the chunk size.

This is unexpected situation, since erase shall always be chunk
aligned based on OCSSD the 2.0 specification.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Javier González <javier@javigon.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-map.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
index 7fbc99b60cac..5408e32b2f13 100644
--- a/drivers/lightnvm/pblk-map.c
+++ b/drivers/lightnvm/pblk-map.c
@@ -162,6 +162,7 @@ int pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 
 			*erase_ppa = ppa_list[i];
 			erase_ppa->a.blk = e_line->id;
+			erase_ppa->a.reserved = 0;
 
 			spin_unlock(&e_line->lock);
 
-- 
2.19.1

