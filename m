Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD491149A6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 00:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfLEXE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 18:04:58 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:43878 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfLEXE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 18:04:58 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 47TWWs1wBkz9vBtJ
        for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2019 23:04:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZvfQ0rRgg_V0 for <linux-kernel@vger.kernel.org>;
        Thu,  5 Dec 2019 17:04:57 -0600 (CST)
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com [209.85.219.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 47TWWs0j8hz9vBsW
        for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2019 17:04:57 -0600 (CST)
Received: by mail-yb1-f199.google.com with SMTP id x186so3780328yba.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 15:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MO10ke4bfA3Py2gapxPNJKqGZHjnWV9jw2bft4Kl1Hw=;
        b=B7gtMaEsF7Gm1FvHzVvdDonAn4mJJufpl+R6jt6JwtloKhiJ2BTcl4HXrVKOWhaX2J
         RzhOI9pXAhvHTojPFUzsuiN38kaBDjGpVWv0cM91qOpGlpDBXSIQIQv5VM2gsWDwplyH
         5V9wlLATp57c4WRZa4Etk8ylhUTa4US0bNXyCTdGaXNB65jnlXyhMJz5EryAVeLUWPZk
         h35YybOW4aeq+/fTPr5nh9es/lP2e8uxTEW+Fs4VSlKkVw7Em6tWWMoZeoc1NhAtXEwk
         Lx0OUm3R3zm7rCYIUWXpch7UOaBj6MWZdomcE59iPm8mi4rQYhzHsnQ8/nUcnrkiM/qo
         8Ccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MO10ke4bfA3Py2gapxPNJKqGZHjnWV9jw2bft4Kl1Hw=;
        b=QvWkXhZtFpinVUXf4mEas+UprgY2gD0/UMv3xzFQC6ebZZd/rr6tCiusqKuiDyrzaw
         PKx6Mga06VrOIYOX+Fz4bV+38UGUh3+x1FhKou1nfbwPJLlTwITPRHpnL9lhyAdB+TKM
         uPfHxvXxWrIi25tnAKxQNOZTCQS0KfuVoaGEbngd1r0WnaEEJDtaOmW73FFbP8rF6c/M
         z1Eoor0TaRAHLCXpP/3dt0bsdSaqC+0jNKJWtodL9Lp0BQO5yakEOShpY6rheUpfw4GO
         YyXINFpGDhNHzLo1FHhG2YA73qlbvKgftHbVcAtlIqk0pJRbPR+yIxiW/6RO1Wymg/VR
         Erfw==
X-Gm-Message-State: APjAAAVKge8b84nbj54qDb/iBCDc4SrirdBTIzAaMbnWq5Gooq1Ebtdo
        8R+aICMLZMHmKYZcLpP1P/53+IR/OjLSl6Q1s2A1hadufFtuMvEyPpBoNoWZ6J8FX28ykB8o12N
        vcHncmsqSpxWGtiZR5pFdh5s7jm+r
X-Received: by 2002:a81:9243:: with SMTP id j64mr8238803ywg.513.1575587096447;
        Thu, 05 Dec 2019 15:04:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqwg4ZN3+3krbx0S3IP2LY3Snyl3L4I6iUCuEMzgHmgR9YsTyF09HdZ2EYtDKvwy4ASNs5xVfQ==
X-Received: by 2002:a81:9243:: with SMTP id j64mr8238786ywg.513.1575587096210;
        Thu, 05 Dec 2019 15:04:56 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id u136sm5057802ywf.101.2019.12.05.15.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 15:04:55 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Michal Ostrowski <mostrows@earthlink.net>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pppoe: remove redundant BUG_ON() check in pppoe_pernet
Date:   Thu,  5 Dec 2019 17:04:49 -0600
Message-Id: <20191205230450.8614-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing NULL to pppoe_pernet causes a crash via BUG_ON.
Dereferencing net in net_generici() also has the same effect. This patch
removes the redundant BUG_ON check on the same parameter.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/net/ppp/pppoe.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index a44dd3c8af63..d760a36db28c 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -119,8 +119,6 @@ static inline bool stage_session(__be16 sid)
 
 static inline struct pppoe_net *pppoe_pernet(struct net *net)
 {
-	BUG_ON(!net);
-
 	return net_generic(net, pppoe_net_id);
 }
 
-- 
2.17.1

