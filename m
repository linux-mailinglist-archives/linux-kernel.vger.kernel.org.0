Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9E0F0251
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 17:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390202AbfKEQIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 11:08:30 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:60605 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390166AbfKEQI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 11:08:29 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id B1C621A2148;
        Tue,  5 Nov 2019 16:59:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local [10.10.14.106])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 919FC1A215D;
        Tue,  5 Nov 2019 16:59:40 +0100 (CET)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net
Cc:     Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: [PATCH 3/3] docs: ioctl: Update ioctl-number.rst 'last updated' date
Date:   Tue,  5 Nov 2019 16:59:21 +0100
Message-Id: <1572969561-17591-4-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572969561-17591-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1572969561-17591-1-git-send-email-aleksandar.markovic@rt-rk.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>

Update info on the date of the last update of ioctl-number.rst.

Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
---
 Documentation/ioctl/ioctl-number.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ioctl/ioctl-number.rst b/Documentation/ioctl/ioctl-number.rst
index 799b90b..f501467 100644
--- a/Documentation/ioctl/ioctl-number.rst
+++ b/Documentation/ioctl/ioctl-number.rst
@@ -2,7 +2,7 @@
 Ioctl Numbers
 =============
 
-19 October 1999
+Last update: 5th November, 2019
 
 Michael Elizabeth Chastain
 <mec@shout.net>
-- 
2.7.4

