Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4253F130A30
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jan 2020 23:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgAEWVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jan 2020 17:21:12 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:53410 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726851AbgAEWVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 17:21:12 -0500
Received: from [81.174.41.21] (port=58378 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.92)
        (envelope-from <luca@lucaceresoli.net>)
        id 1ioEGG-00GHUv-Dh; Sun, 05 Jan 2020 23:21:09 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH] scripts/spelling.txt: add "issus" typo
Date:   Sun,  5 Jan 2020 23:19:50 +0100
Message-Id: <20200105221950.8384-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "issus" and correct it as "issues".

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 scripts/spelling.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 672b5931bc8d..19cffc4fcedb 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -791,6 +791,7 @@ ireelevant||irrelevant
 irrelevent||irrelevant
 isnt||isn't
 isssue||issue
+issus||issues
 iternations||iterations
 itertation||iteration
 itslef||itself
-- 
2.24.1

