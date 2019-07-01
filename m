Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2A4713BBE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2019 20:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfEDSkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 May 2019 14:40:22 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43081 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfEDSig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 14:38:36 -0400
Received: by mail-lf1-f65.google.com with SMTP id u27so6251525lfg.10
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 11:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0lUEIM6HxDnO0WA4JO+7E8AtWBSweRsdO5Jk/5jbRNk=;
        b=eirepp7rCDa4s4xp9B9alMSTJW8zT3BZDnviazcRBoQtnmPVWmbHWx/MKyMKZfzniH
         lCbbp14h3V5zZ6/pxwX3qaUxuybRn+rsSGzH5s7azheoJNHuA+bKeSHXPMjt0QY0qUgd
         z3DSyplKba5KP3lYnBIJNJCe3mFH/VozvNOa58iHAkppdDhZvaaaK62tN3n8WTkXunrg
         NOfTB7TbeClqosR8YYRn/Ih3zeMsGJIU0YF+aCgzfMm5RwCsNHesir599y05Ojpyk/ft
         s8O++kiMtbe6vSo5WuvLmjIgQ/Xfk+z6+IqMzcgu9tV8L1H9TQCJIoe9vEaxbqzgBpFP
         EM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0lUEIM6HxDnO0WA4JO+7E8AtWBSweRsdO5Jk/5jbRNk=;
        b=KDxSrgtwfuands23y0q/B4A0CaAWxkI8o4qS4WDpceAqXkma0sJEgMqeSgPNIwn1wt
         XwnLIBDpOFCybpcl2V5BjsMETH13mHpp8ADABVWyd+ung/ZFqUZECEejf7PoJG+dhEHC
         oHkyMia9gu5VDjDLmxom7CGpRaIe8/kXAIPHlUpU5Lh6DC7FVuT/fV/zQ0vcjCpZEwy0
         H5aQi7Qk5EjWnIAJYbhuXbvwt+SEWEcAtE0hkL9hvgMyysJMlNEQoiTTMyeZD2BoLwTF
         +qGidwJTXGqBDjwzzGsXXWExoYhG0rNyIXUZlXM4Y3UI0p7hOSzqL9qh+OjqbIka2xr0
         uR5g==
X-Gm-Message-State: APjAAAWKPQNliw7hIRCexHMaqvtDpmTZ3SUhTPjhOz+q2JQnH9/iSrQj
        mZkF7lIRKiwkFHGjk123eXo18A==
X-Google-Smtp-Source: APXvYqwbJccRkqhPgXwF38teXbsvsMsVyU3UOO3SbQBiPhc3j3Gja4qxPs2Eg02/ToEQp9jf90JfZg==
X-Received: by 2002:a19:4811:: with SMTP id v17mr8039906lfa.10.1556995114808;
        Sat, 04 May 2019 11:38:34 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id q21sm1050260lfa.84.2019.05.04.11.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:38:34 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 09/26] lightnvm: pblk: set proper read status in bio
Date:   Sat,  4 May 2019 20:37:54 +0200
Message-Id: <20190504183811.18725-10-mb@lightnvm.io>
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

Currently in case of read errors, bi_status is not set properly which
leads to returning inproper data to layers above. This patch fix that
by setting proper status in case of read errors.

Also remove unnecessary warn_once(), which does not make sense
in that place, since user bio is not used for interation with drive
and thus bi_status will not be set here.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Javier González <javier@javigon.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-read.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index b8eb6bdb983b..7b7a04a80d67 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -175,11 +175,10 @@ static void pblk_read_check_rand(struct pblk *pblk, struct nvm_rq *rqd,
 	WARN_ONCE(j != rqd->nr_ppas, "pblk: corrupted random request\n");
 }
 
-static void pblk_end_user_read(struct bio *bio)
+static void pblk_end_user_read(struct bio *bio, int error)
 {
-#ifdef CONFIG_NVM_PBLK_DEBUG
-	WARN_ONCE(bio->bi_status, "pblk: corrupted read bio\n");
-#endif
+	if (error && error != NVM_RSP_WARN_HIGHECC)
+		bio_io_error(bio);
 	bio_endio(bio);
 }
 
@@ -219,7 +218,7 @@ static void pblk_end_io_read(struct nvm_rq *rqd)
 	struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
 	struct bio *bio = (struct bio *)r_ctx->private;
 
-	pblk_end_user_read(bio);
+	pblk_end_user_read(bio, rqd->error);
 	__pblk_end_io_read(pblk, rqd, true);
 }
 
@@ -298,7 +297,7 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
 	rqd->bio = NULL;
 	rqd->nr_ppas = nr_secs;
 
-	bio_endio(bio);
+	pblk_end_user_read(bio, rqd->error);
 	__pblk_end_io_read(pblk, rqd, false);
 }
 
-- 
2.19.1

