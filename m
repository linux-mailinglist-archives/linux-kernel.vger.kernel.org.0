Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60162D7672
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 14:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbfJOMZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 08:25:40 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:45826 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfJOMZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 08:25:40 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKLtR-0001Vn-7s; Tue, 15 Oct 2019 13:25:37 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKLtQ-0001QU-JP; Tue, 15 Oct 2019 13:25:36 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Marek Behun <marek.behun@nic.cz>, linux-kernel@vger.kernel.org
Subject: [PATCH] bus: moxtet: declare moxtet_bus_type
Date:   Tue, 15 Oct 2019 13:25:35 +0100
Message-Id: <20191015122535.5439-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The moxtet_bus_type object is exported from the bus
driver, but not declared. Add a declaration for use
and to silence the following warning:

drivers/bus/moxtet.c:105:17: warning: symbol 'moxtet_bus_type' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Marek Behun <marek.behun@nic.cz>
Cc: linux-kernel@vger.kernel.org
---
 include/linux/moxtet.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/moxtet.h b/include/linux/moxtet.h
index 490db6886dcc..b76231cb60e4 100644
--- a/include/linux/moxtet.h
+++ b/include/linux/moxtet.h
@@ -94,6 +94,8 @@ struct moxtet_device {
 	unsigned int			idx;
 };
 
+extern struct bus_type moxtet_bus_type;
+
 extern int moxtet_device_read(struct device *dev);
 extern int moxtet_device_write(struct device *dev, u8 val);
 extern int moxtet_device_written(struct device *dev);
-- 
2.23.0

