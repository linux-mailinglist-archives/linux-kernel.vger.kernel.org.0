Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCD24D5185
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2019 20:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbfJLSGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Oct 2019 14:06:13 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33029 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728636AbfJLSGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 14:06:13 -0400
Received: by mail-pl1-f196.google.com with SMTP id d22so6022571pls.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 11:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tT24sM9T6hkRxQedrQmg31fItSCxPHO1fScVTFID4Ho=;
        b=ksbeu2/AEfGmAq8zJkbp87DWQ4AGE6KLQFuGtREb+FWns2cMXhD1fnsu47paOill+X
         DxFBieCpyg4rMipRLMyg54BcqAcXpcsyY5lcjy2jY2470m64V+powGa3brFDZfxmYOo2
         CCTKhAlqmX6O+m0x3lB/gRB6pwa00K08NjhYpQQvQjFqQ5yS9QqZ5bLXuhsCqkK7snOa
         E/bMkCWPX2PqM5sLCTmeXsqMOMqV08dH428qlHYOH89L2KC1Z1SYUWDD8/EcBAzcOWNt
         pe9G6gA2hUTM8g0AP19JXuAn7iwJq/itPeWoBwrnjkJLdWXj2xyJcO3+GLZi6wr9vf4/
         eL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tT24sM9T6hkRxQedrQmg31fItSCxPHO1fScVTFID4Ho=;
        b=Vk65Wrev/QCOZSeyAoOhEvc038S4TLwSxrEzTwzGqUaCR2vY70jqr9df1OS6R8qITC
         JlrWqJYBQnETFGdCUVt4jxRC3VIEhyeXmd611QVzlutTmneJjiCZ4JgcNlAtJuJOkIHA
         No8ZM87ll5J+0b2ETYXGScjQBKKVC2mhbu5n1dvkT2Yypt9KgRyss5KKYwJfjcS0h4eA
         67UFYkwvoC9d+V7SarfQq5JtmU6jAAn15WhDXtNGBa7W74/f7NTuE/XB25CrgIPLWYm3
         WPNCBcinFWblmBTsMhl2uIOHmL9dI6vyh1Bc7jTaSP9HPOvWdACmDYeXm1PiHtzbCvKy
         Lg9g==
X-Gm-Message-State: APjAAAUdzX0z/rmM0jUGOko+RsVgQEoJc/LAyYHxoqtZIc+oCUIS+q4c
        gURInaj6+Y8LaLA4wd1aR8M=
X-Google-Smtp-Source: APXvYqxgPC401iBfutZGKVx7G9w2ziZHOwj6b0i+4n/wvE9u5ALp4UUhFCXmKoEDnVmcFmrHjNcFfw==
X-Received: by 2002:a17:902:545:: with SMTP id 63mr16371191plf.14.1570903572632;
        Sat, 12 Oct 2019 11:06:12 -0700 (PDT)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id p17sm12183475pfn.50.2019.10.12.11.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 11:06:12 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: [PATCH v2 4/5] staging: octeon: remove typedef declartion for cvmx_pko_command_word0
Date:   Sat, 12 Oct 2019 21:04:34 +0300
Message-Id: <40bb26b250d7ba5b0d5199072e773be2fb0fed90.1570821661.git.wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570821661.git.wambui.karugax@gmail.com>
References: <cover.1570821661.git.wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes addition of new typedef declaration for
cvmx_pko_command_word0.
Also replace previous instances with new union declaration.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/staging/octeon/ethernet-tx.c  | 2 +-
 drivers/staging/octeon/octeon-stubs.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
index a039882e4f70..95bd1b5338fc 100644
--- a/drivers/staging/octeon/ethernet-tx.c
+++ b/drivers/staging/octeon/ethernet-tx.c
@@ -127,7 +127,7 @@ static void cvm_oct_free_tx_skbs(struct net_device *dev)
  */
 int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	cvmx_pko_command_word0_t pko_command;
+	union cvmx_pko_command_word0 pko_command;
 	union cvmx_buf_ptr hw_buffer;
 	u64 old_scratch;
 	u64 old_scratch2;
diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 40f0cfee0dff..db2d6f64b666 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -1137,7 +1137,7 @@ union cvmx_npi_rsl_int_blocks {
 	} cn50xx;
 };
 
-typedef union {
+union cvmx_pko_command_word0 {
 	uint64_t u64;
 	struct {
 	        uint64_t total_bytes:16;
@@ -1157,7 +1157,7 @@ typedef union {
 	        uint64_t size0:2;
 	        uint64_t size1:2;
 	} s;
-} cvmx_pko_command_word0_t;
+};
 
 union cvmx_ciu_timx {
 	uint64_t u64;
@@ -1384,7 +1384,7 @@ static inline void cvmx_pko_send_packet_prepare(uint64_t port, uint64_t queue,
 { }
 
 static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(uint64_t port,
-		uint64_t queue, cvmx_pko_command_word0_t pko_command,
+		uint64_t queue, union cvmx_pko_command_word0 pko_command,
 		union cvmx_buf_ptr packet, cvmx_pko_lock_t use_locking)
 {
 	cvmx_pko_status_t ret = 0;
-- 
2.23.0

