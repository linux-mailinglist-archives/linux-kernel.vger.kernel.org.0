Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5BF5892B6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2019 18:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfHKQ6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Aug 2019 12:58:08 -0400
Received: from sender4-pp-o95.zoho.com ([136.143.188.95]:25517 "EHLO
        sender4-pp-o95.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfHKQ6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 12:58:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1565539978; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=k6oBNE9NWzTI+nYMITWgTOBj46cwZ0VzrYK6y7rPlKx0TLECCqui+KbkELfTPzfd+2axLJ1EI/R/RnIEN+BEgvgTUY6K6Dc4Vlfyoyi0ZlsTAXzSsRTEnqJMGofj+J0nrEYk/Br52yXOqQ9VJWbapuFuQWDZlLEFfxru9MmfSxg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1565539978; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=1aDYVhR5ua7R6QtqqYBIeriKVtf05O2LG5PFry5xJvo=; 
        b=IUT6eQ65lLKAP1tUpWXclKQM8OnRdjqL6AtGupA4BZcoZdT4/JZkZBkGDS7KASnr4fWTSsmrsgpCyJMP2mTKV+/R5qZfqSomn94dypA8TowoxZfaYQPrEMwaaoQOR34lZBlq9k86orcdJue9zw+nN4IgppY7mG211cvlgVjnbIE=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=alkQzwM8edBCu3qQZh1bHv4vZmFN9MkF2/YKq95OMrmmcSawkJdnaDw/Rlv0k8ZtlADdrdQ7JcpY
    3xrRsZ7lg/g1DepNHfZdL8GhScSGvATFnt506pRpqc9rdmk5dQ+U  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1565539978;
        s=zm2019; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=1001; bh=1aDYVhR5ua7R6QtqqYBIeriKVtf05O2LG5PFry5xJvo=;
        b=dY5bJLMwuEbg/pqA9SR9XF3DaFzkEc5HJq7nofCTPfZsKzVtkF40ydtk+TwhpFgJ
        tvux+W5IaUAn56WNIOK4fk0ZSPBMYlAixP3fga0eP7jKtB38FyPw9MzBtTI/m4mlc6r
        fODh70X1GvtAPheOnPCoGRfyRH33G18NAZpcKplU=
Received: from YEHS1XR3054QMS.lenovo.com (114.245.9.228 [114.245.9.228]) by mx.zohomail.com
        with SMTPS id 156553997678386.42888057393054; Sun, 11 Aug 2019 09:12:56 -0700 (PDT)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     mpatocka@redhat.com, snitzer@redhat.com, agk@redhat.com
Cc:     prarit@redhat.com, tyu1@lenovo.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Subject: dm writecache: add unlikely for getting two block with same LBA
Date:   Mon, 12 Aug 2019 00:12:33 +0800
Message-Id: <20190811161233.7616-2-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
In-Reply-To: <20190811161233.7616-1-yehs2007@zoho.com>
References: <20190811161233.7616-1-yehs2007@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

In function writecache_writeback, entries g and f has same original
sector only happens at entry f has been committed, but entry g has
NOT yet.

The probability of this happening is very low in the following
 256 blocks at most of entry e, so add unlikely for the result.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 drivers/md/dm-writecache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 5c7009d..3643084 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -1628,8 +1628,8 @@ static void writecache_writeback(struct work_struct *work)
 			if (unlikely(!next_node))
 				break;
 			g = container_of(next_node, struct wc_entry, rb_node);
-			if (read_original_sector(wc, g) ==
-			    read_original_sector(wc, f)) {
+			if (unlikely(read_original_sector(wc, g) ==
+			    read_original_sector(wc, f))) {
 				f = g;
 				continue;
 			}
-- 
1.8.3.1


