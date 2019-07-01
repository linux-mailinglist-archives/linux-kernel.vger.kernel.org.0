Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADE7F13B8F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2019 20:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfEDSia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 May 2019 14:38:30 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44876 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfEDSi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 14:38:29 -0400
Received: by mail-lf1-f67.google.com with SMTP id n134so4700383lfn.11
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 11:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bWn+rCikB65o9r7JGHEc64KTxHxT4P0396zHFHxaSAg=;
        b=PfrrKBlO4HsiGBjXeDeLtYEd8FGoTFGqIlW4grdvhmbEm58bDrztF2rvNxojAVR4bl
         8voOeCeDHLrUjVLA9ObrKX5I4ov7QubcHTh6rTYvX5jPOqkuAK69IlDJ4Tk+aT4OGtiF
         bw82TUqZxuVUth1eXHf+P7C1uoBwTbOaYcTtxYL6MmNVKp1cIx9eCjvY71zSAiEYpjbg
         Q6tj2EDxglmE3niTxOIkLJc/2VS+jp8bqQCadlOT7u5o5KQsrCEJsJy81YVj+P3PTCuB
         53I8JgnFWxm57RW+azFwTT+48lMj1hXvUq8dqEeMYCx7uy9dvJK6SroY9XdcVznkiKiu
         9+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bWn+rCikB65o9r7JGHEc64KTxHxT4P0396zHFHxaSAg=;
        b=FzNAevGkxOKLDlvRwJZ7y04B0My11AotVctdbxivCnpHaRXTPAmVfCpZinSTygU2B/
         +3jZ5dclAKIsSA62DYkfOY0P+BLAJqB+KRUR8S64zMH92la/CnL8m0wqrfJUThS5Zw5n
         l4Tx1v7Q3597neK8FMR/eNRRpTWkNtmO6/mODTL7TSVGx2rWgOMQJABy+KE8UuvgtXlY
         Yyu/kA/DcGgxkeIdUQrvAbWuv1w5Ffrs3XMefpeI997TZzJWWc1mwNYSeRY0LQzp2RNb
         ov9/M+oKtBhxti+tIpgz73+q6eBHR8LWv+cX/2bz3XK+QqHuOyepr70kXlnjHZS+VAMB
         WIpA==
X-Gm-Message-State: APjAAAW6nRS0gt0Ry45AemuFQNn60fNFlg2vNqrOvE2rRCftX1Y3RF0m
        pPaxzAr4/gXOPkgtOj9s7BCv+A==
X-Google-Smtp-Source: APXvYqxQXlO8pXIZfIypdXJu442v9wp/WbcMghp0URagUdObSZkHZvzUaypSHo5ZwqRlxUwhKjmuMA==
X-Received: by 2002:a19:a5cc:: with SMTP id o195mr594362lfe.154.1556995107733;
        Sat, 04 May 2019 11:38:27 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id q21sm1050260lfa.84.2019.05.04.11.38.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:38:27 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 01/26] lightnvm: pblk: line reference fix in GC
Date:   Sat,  4 May 2019 20:37:46 +0200
Message-Id: <20190504183811.18725-2-mb@lightnvm.io>
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

Fixes the GC error case when moving a line back to closed state
while releasing additional references.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-gc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 26a52ea7ec45..901e49951ab5 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -290,8 +290,11 @@ static void pblk_gc_line_prepare_ws(struct work_struct *work)
 fail_free_ws:
 	kfree(line_ws);
 
+	/* Line goes back to closed state, so we cannot release additional
+	 * reference for line, since we do that only when we want to do
+	 * gc to free line state transition.
+	 */
 	pblk_put_line_back(pblk, line);
-	kref_put(&line->ref, pblk_line_put);
 	atomic_dec(&gc->read_inflight_gc);
 
 	pblk_err(pblk, "failed to GC line %d\n", line->id);
-- 
2.19.1

