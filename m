Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6530218E95B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Mar 2020 15:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgCVORk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Mar 2020 10:17:40 -0400
Received: from mr85p00im-zteg06021501.me.com ([17.58.23.183]:45100 "EHLO
        mr85p00im-zteg06021501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725997AbgCVORk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 10:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1584886070; bh=0bf0boBl6+WiqF/tkyebjgPSbA4EbGvKPFn8GKnl33A=;
        h=From:To:Subject:Date:Message-Id;
        b=v7JOYLCZmpqBkMp6sh9V2/yZ03FN4N5BvQYB5zw9jNlbhIUl0Fjf1GL09ZVH5uwt4
         QT/RUwLQ5tmmX5XV/i3qi4sYjmx9ozbqNOQYxAuRLvkpvUMUw86HcrdiUkGXec+y5p
         zFNDMMZr1ERCh/Ga6UApiMQwPBSEVRvAYU0HgaDYHt9VID45N0KmgSHO0u/lEkBxab
         ZsgOt3crFunhe1ZiOm/PNSH7gT9WwQixfqtZfz5bOGESdGEerG/jEHrAzRHVgBqSSK
         pHO8pYHyz8NPi0ioTxxhHtsBsXgIyFZyA1c03/aO0JkWwKKoIsE+Tog20y61O9depA
         4tBSNIvIOciag==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by mr85p00im-zteg06021501.me.com (Postfix) with ESMTPSA id B432738031E;
        Sun, 22 Mar 2020 14:07:49 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, lee.jones@linaro.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     patrice.chotard@st.com, avolmat@me.com
Subject: [PATCH] clk: clk-flexgen: fix clock-critical handling
Date:   Sun, 22 Mar 2020 15:07:40 +0100
Message-Id: <20200322140740.3970-1-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-03-22_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2003220086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes an issue leading to having all clocks following a critical
clocks marked as well as criticals.

Fixes: fa6415affe20 ("clk: st: clk-flexgen: Detect critical clocks")

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 drivers/clk/st/clk-flexgen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/st/clk-flexgen.c b/drivers/clk/st/clk-flexgen.c
index 4413b6e04a8e..55873d4b7603 100644
--- a/drivers/clk/st/clk-flexgen.c
+++ b/drivers/clk/st/clk-flexgen.c
@@ -375,6 +375,7 @@ static void __init st_of_flexgen_setup(struct device_node *np)
 			break;
 		}
 
+		flex_flags &= ~CLK_IS_CRITICAL;
 		of_clk_detect_critical(np, i, &flex_flags);
 
 		/*
-- 
2.17.1

