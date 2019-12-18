Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4A5124242
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 09:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfLRIyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 03:54:04 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:41325 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726090AbfLRIyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 03:54:04 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TlG4OWV_1576659203;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TlG4OWV_1576659203)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 18 Dec 2019 16:53:24 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Harry Wei <harryxiyou@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] docs/zh_CN: add translator info for embargoed-hardware-issues
Date:   Wed, 18 Dec 2019 16:53:10 +0800
Message-Id: <1576659191-75904-2-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576659191-75904-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1576659191-75904-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the people know where to complain... ;)

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../translations/zh_CN/process/embargoed-hardware-issues.rst         | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst b/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst
index 5bc583a41188..a0b956946ebf 100644
--- a/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst
+++ b/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst
@@ -1,3 +1,8 @@
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: :ref:`Documentation/process/embargoed-hardware-issues.rst`
+:Translator: Alex Shi <alex.shi@linux.alibaba.com>
+
 被限制的硬件问题
 ================
 
-- 
1.8.3.1

