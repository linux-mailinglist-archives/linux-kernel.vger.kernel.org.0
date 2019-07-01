Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E064144F1C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 00:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfFMWbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 18:31:05 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46729 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfFMWbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 18:31:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id e5so109143pls.13;
        Thu, 13 Jun 2019 15:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pn6FoQj1OV+3veGcFFuI7q+QIhanANL13Ea2EhicKdc=;
        b=tDAAA9SolkB8v/oQKfNQ7t4VItoqGQohn6jP+x/n3pBnyAHAprJ+/IyM118W4fGX3v
         mK2gETGo6syJWy2tjwtp5zGTHQcUm2NcynTwvV3D5GNS8+j8A66/e+JTdRIOLrqfoDFz
         kSal6iVATIoQUv9ur8BcCNJo1qgZ64DoA34unsHFHycJDAuQjR5HrUcSUdgRjmPd1+yK
         xv0HtOtmrB+qOLL/GMz35DpBkY3oDa9j0ATlZ/yTztjTNBAIn3ic6UnaMPPorS/Y0L9C
         +w39487+Cpx/36NaT4rcfTKgv1BqUqDJ935hfAd3tGDCwlA1nUafBET7P1CYwKAgG3kv
         2EPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=pn6FoQj1OV+3veGcFFuI7q+QIhanANL13Ea2EhicKdc=;
        b=p8R/8ikFuF4YjGawE1FUBetZN2HLPTvT+yIPoP2KKo3ODv5iSo0cx2MZ7ojSVlecj7
         x/dXczPXo1EL6w8ArsD2ii6RhJrdJMS+bFJu1z/sDH9IVI9xk52bwmjLaTpb3a2KteTu
         sQnYbIoUuETqko9SRvNP/6y7ng25ZTZMoUhSre5MxAG0ZLZH8Ui82ahTpwWqwnddBG57
         hU3RlWHxzcYF8n6+jK+ZaL+0w29HFXlJs8CJnESenq+Y3GxF2DQsrpllxPd2OtPxqM3M
         GwRToS4Y8BGs23ChBnEFQVjIiNr5Hh35zZcNcegjheggh+JuqFa3qBXhCkZ/Ud0NmnlP
         3kww==
X-Gm-Message-State: APjAAAVtDyi5M5oNhdnZMwPLr6ERkEzLM0TYj8vCcZEY1sbTbHeL7g4G
        dhklTgmIVkjfxcQcSEp7cIk+S8li
X-Google-Smtp-Source: APXvYqzHp7kwq8cKJu/ri6EQs4IyPKGsNOnNM+CAqSIoaRYwx42mfdrLi2XckORtM/2X666CADD3EA==
X-Received: by 2002:a17:902:7591:: with SMTP id j17mr90628227pll.200.1560465062493;
        Thu, 13 Jun 2019 15:31:02 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:9d14])
        by smtp.gmail.com with ESMTPSA id x6sm778796pgr.36.2019.06.13.15.31.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 15:31:01 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, jbacik@fb.com
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, dennis@kernel.org, jack@suse.cz,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/5] blkcg, writeback: dead memcgs shouldn't contribute to writeback ownership arbitration
Date:   Thu, 13 Jun 2019 15:30:41 -0700
Message-Id: <20190613223041.606735-6-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190613223041.606735-1-tj@kernel.org>
References: <20190613223041.606735-1-tj@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wbc_account_io() collects information on cgroup ownership of writeback
pages to determine which cgroup should own the inode.  Pages can stay
associated with dead memcgs but we want to avoid attributing IOs to
dead blkcgs as much as possible as the association is likely to be
stale.  However, currently, pages associated with dead memcgs
contribute to the accounting delaying and/or confusing the
arbitration.

Fix it by ignoring pages associated with dead memcgs.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index e41cbe8e81b9..9ebfb1b28430 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -715,6 +715,7 @@ void wbc_detach_inode(struct writeback_control *wbc)
 void wbc_account_io(struct writeback_control *wbc, struct page *page,
 		    size_t bytes)
 {
+	struct cgroup_subsys_state *css;
 	int id;
 
 	/*
@@ -726,7 +727,12 @@ void wbc_account_io(struct writeback_control *wbc, struct page *page,
 	if (!wbc->wb)
 		return;
 
-	id = mem_cgroup_css_from_page(page)->id;
+	css = mem_cgroup_css_from_page(page);
+	/* dead cgroups shouldn't contribute to inode ownership arbitration */
+	if (!(css->flags & CSS_ONLINE))
+		return;
+
+	id = css->id;
 
 	if (id == wbc->wb_id) {
 		wbc->wb_bytes += bytes;
-- 
2.17.1

