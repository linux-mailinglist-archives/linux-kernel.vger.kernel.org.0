Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 464D218882F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 15:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgCQOyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 10:54:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbgCQOyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:54:31 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C1DB2073E;
        Tue, 17 Mar 2020 14:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584456870;
        bh=oJnWsZoRIYQ84cqpBZqWUzVfJ3S8GVrou/XF+akXsKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WXFI8+Ey0XhfhUnZL8GgZxNRv6Tz6vJVxvJLBZE9L62pub3q4tBf5vaTTmMsf0W7N
         u/MOHeUaXrGB20fdQfI4YHJqBwbZ2op4tPXmYt2cWqUJYK8aUM9I22CSpntYagLDVI
         yOnKvaBhdCgU/+ZnYunzsEV6XQC9iRVl/r5FWwqc=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jEDbw-000AMb-I8; Tue, 17 Mar 2020 15:54:28 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        linux1394-devel@lists.sourceforge.net
Subject: [PATCH 06/17] firewire: firewire-cdev.hL get rid of a docs warning
Date:   Tue, 17 Mar 2020 15:54:15 +0100
Message-Id: <1e2af9e7b75c2d968033b5054969c2095b317b16.1584456635.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1584456635.git.mchehab+huawei@kernel.org>
References: <cover.1584456635.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This warning:

	./include/uapi/linux/firewire-cdev.h:312: WARNING: Inline literal start-string without end-string.

is because %FOO doesn't work if there's a parenthesis at the
string (as a parenthesis may indicate a function). So, mark
the literal block using the alternate ``FOO`` syntax.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/uapi/linux/firewire-cdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/firewire-cdev.h b/include/uapi/linux/firewire-cdev.h
index 1acd2b179aef..7e5b5c10a49c 100644
--- a/include/uapi/linux/firewire-cdev.h
+++ b/include/uapi/linux/firewire-cdev.h
@@ -308,7 +308,7 @@ struct fw_cdev_event_iso_interrupt_mc {
 /**
  * struct fw_cdev_event_iso_resource - Iso resources were allocated or freed
  * @closure:	See &fw_cdev_event_common;
- *		set by %FW_CDEV_IOC_(DE)ALLOCATE_ISO_RESOURCE(_ONCE) ioctl
+ *		set by``FW_CDEV_IOC_(DE)ALLOCATE_ISO_RESOURCE(_ONCE)`` ioctl
  * @type:	%FW_CDEV_EVENT_ISO_RESOURCE_ALLOCATED or
  *		%FW_CDEV_EVENT_ISO_RESOURCE_DEALLOCATED
  * @handle:	Reference by which an allocated resource can be deallocated
-- 
2.24.1

