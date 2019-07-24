Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88EE4723DA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 03:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbfGXBmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 21:42:31 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:56486 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbfGXBma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 21:42:30 -0400
Received: by mail-pf1-f201.google.com with SMTP id x10so27446739pfa.23
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 18:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vXNliUMoL+aTyYjmgAfXHEWaeVBL//kUql7DwnW99Io=;
        b=TQyP8wM5LBSf+xD8urLumC9WYG3t8lQgn1LkYsM04Wptn7xQMX5zYiuJw16QwCh+Kh
         kRWaudqqkrFuGsI+udvANDDtFR3plqgBGPGH1O/KnDmCanVwoLPdLUEKMi6R/+0XCMX2
         mfACw0vXNduzaZ5xbLfD0m6e8d7irEbR18s+tTDH5p/WFXhqzunLI/bYZ1uB2TY27lpy
         ptoMsdSGrPe/V80K4JI+Uo/dmIMoemMCN5Ue+jzbCC9zLOeOw0yEXhNxrhX8HRLyBaAR
         vNORbSjejJ3WILMX9Zp86bk5qADkwCPMp5hTUwBlyj16vocyn+5ygHhSqudx6sjQJhHo
         3qYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vXNliUMoL+aTyYjmgAfXHEWaeVBL//kUql7DwnW99Io=;
        b=tswW8bzd06ISe1s7DXOls19x25xJUDXV8Z/LdQdSHIrhTQGqbGw/Hg05oLch6khwpe
         xrfHns3zyjbFiaQAWvy1h5GSeWRR5OAhYMp2PwedVuPEGihgAhiSLPUMG4TDCgm2B0UO
         yHBk8TLZkMDiJvhpxwU2YZznH66u8qumpsuOpHtXkDpkYZEBmzcoDM9lVYwq+klsP3Am
         wsDpZ0KVTL5M5QG0uC28JBheBxzHGrj2hG45FMqguOlj9JzBf0wxtkjd9Tur5//tF+XB
         zI5dbDpZMiT6MkZD7ixI642vD9S5KeLWh4v+S9lhUQRM11IgJPy8wa4DkJYrHnX5LEtE
         LDag==
X-Gm-Message-State: APjAAAWvC3ZMLeSe58SzeWZxKkhqenpaWv9a2F1eKZKXtnK7e/+RYg3u
        RYSZhM42Ch0WMFoqjfm8mUa1SQTbLUq9HBk=
X-Google-Smtp-Source: APXvYqxFVrPokl3G/8hclEsKHvyfxZWl8jfKlkacsPygXvPGCv2kbbdjIyqnY6FypqtZ01y48+WLz6HQPEJweQk=
X-Received: by 2002:a63:394:: with SMTP id 142mr4772310pgd.43.1563932549513;
 Tue, 23 Jul 2019 18:42:29 -0700 (PDT)
Date:   Tue, 23 Jul 2019 18:42:17 -0700
In-Reply-To: <20190724014222.110767-1-saravanak@google.com>
Message-Id: <20190724014222.110767-2-saravanak@google.com>
Mime-Version: 1.0
References: <20190724014222.110767-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v4 1/5] OPP: Allow required-opps even if the device doesn't
 have power-domains
From:   Saravana Kannan <saravanak@google.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>,
        Sibi Sankar <sibis@codeaurora.org>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A Device-A can have a (minimum) performance requirement on another
Device-B to be able to function correctly. This performance requirement
on Device-B can also change based on the current performance level of
Device-A.

The existing required-opps feature fits well to describe this need. So,
instead of limiting required-opps to point to only PM-domain devices,
allow it to point to any device.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/opp/core.c |  2 +-
 drivers/opp/of.c   | 11 -----------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index c094d5d20fd7..438fcd134d93 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -707,7 +707,7 @@ static int _set_required_opps(struct device *dev,
 		return 0;
 
 	/* Single genpd case */
-	if (!genpd_virt_devs) {
+	if (!genpd_virt_devs && required_opp_tables[0]->is_genpd) {
 		pstate = likely(opp) ? opp->required_opps[0]->pstate : 0;
 		ret = dev_pm_genpd_set_performance_state(dev, pstate);
 		if (ret) {
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index b313aca9894f..ff88eaf66b56 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -197,17 +197,6 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 
 		if (IS_ERR(required_opp_tables[i]))
 			goto free_required_tables;
-
-		/*
-		 * We only support genpd's OPPs in the "required-opps" for now,
-		 * as we don't know how much about other cases. Error out if the
-		 * required OPP doesn't belong to a genpd.
-		 */
-		if (!required_opp_tables[i]->is_genpd) {
-			dev_err(dev, "required-opp doesn't belong to genpd: %pOF\n",
-				required_np);
-			goto free_required_tables;
-		}
 	}
 
 	goto put_np;
-- 
2.22.0.709.g102302147b-goog

