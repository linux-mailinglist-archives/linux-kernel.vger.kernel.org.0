Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC1F1988D0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 02:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbgCaAWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 20:22:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50502 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbgCaAWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 20:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=0XSOCNbZBTXdqn/rb3amNpNjr6ohLZ0RVhcF9AIbeko=; b=i4r5JQDiNS06ztVk7eavaykG8U
        ssq6JeKzZ5xcIuNvowQvHD6n92jmqG6JuAZoAt7v3V3WJbYMRo/zXgFRCi8fKZ8ZnPoy+QSrMarZf
        3XOvcBwuL/vXWe3Xt9TEu7nXN5STpSfbvAmZp4qYg8X9PN1MBMs4wzsyQOA17PYZNvLzIgXDIeE91
        CcVLK78ZttlXpWzV2UyiQLosDMZpO4M6t67OLIdXUEJNB27OP4WSRI0dPFr3JApJrY+e+MWR3Jl2v
        tdNunT7XvW1dPhWHoRrQDX0wyyYyf8vE1iR8fGMKtHV4xl2+olJHMGCX/urbznT0Bikbmv7QGApJK
        9w5TfwNA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJ4fU-0000sL-7a; Tue, 31 Mar 2020 00:22:12 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH trivial] lib/bitmap.c: fix spello
Message-ID: <532afb44-6827-81cc-b1e2-7c5c1454d3a3@infradead.org>
Date:   Mon, 30 Mar 2020 17:22:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix typo/spello for whitespaces.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jiri Kosina <trivial@kernel.org>
---
 lib/bitmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200330.orig/lib/bitmap.c
+++ linux-next-20200330/lib/bitmap.c
@@ -551,7 +551,7 @@ static inline bool end_of_region(char c)
 }
 
 /*
- * The format allows commas and whitespases at the beginning
+ * The format allows commas and whitespaces at the beginning
  * of the region.
  */
 static const char *bitmap_find_region(const char *str)

