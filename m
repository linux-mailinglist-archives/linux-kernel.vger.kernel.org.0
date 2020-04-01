Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4268A19B5ED
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 20:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbgDAStP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 14:49:15 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.161]:35232 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727541AbgDAStO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 14:49:14 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id AD9EA7DF7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Apr 2020 13:25:13 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Ji37jriQTEfyqJi37joWU6; Wed, 01 Apr 2020 13:25:13 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gnjG3Cjg1W4Jhy4V+ZuGT3Ocg2dyV9Ka7zvFl8JmdDE=; b=EYOeNZexYs8sceG4s4RZtHLh/i
        2AaB++N8/ZmBvDCs/327eDM4FTMMGo/O8bNuw9CHdNGPIbshUZ+3LvVRTvPhgdsxDYXdjUNqFx6i6
        PfiBchPugIO8O3ldVl5sYwywzOgckbQWBDtuDm0MiRYfa5mdmmjiqagcF0Jxo70zZdjg97ENYuelY
        NHBu58THhepj6rUWsKYIgLs8rGL39Sv2X4KShB5quliQB7KDlPJD0Y24Pc6nAwoSNk4raWENRU9A+
        MPJ9oZ/YAIZPVkPmmv7jKW3S0iistgH6dfp0UFQaiQXxGEK45JWQIUdGA7PUXrHePomvgt31U0TLd
        Krtfcrsw==;
Received: from cablelink-189-218-116-241.hosts.intercable.net ([189.218.116.241]:58494 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jJi34-001vCl-Qc; Wed, 01 Apr 2020 13:25:10 -0500
Date:   Wed, 1 Apr 2020 13:28:55 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] lkdtm: bugs: Fix spelling mistake
Message-ID: <20200401182855.GA16253@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.218.116.241
X-Source-L: No
X-Exim-ID: 1jJi34-001vCl-Qc
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink-189-218-116-241.hosts.intercable.net (embeddedor) [189.218.116.241]:58494
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spelling mistake s/Intentially/Intentionally

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/misc/lkdtm/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 886459e0ddd9..736675f0a246 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -208,7 +208,7 @@ void lkdtm_OVERFLOW_UNSIGNED(void)
 	ignored = value;
 }
 
-/* Intentially using old-style flex array definition of 1 byte. */
+/* Intentionally using old-style flex array definition of 1 byte. */
 struct array_bounds_flex_array {
 	int one;
 	int two;
-- 
2.26.0

