Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 402C01543B8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 13:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgBFMFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 07:05:04 -0500
Received: from foss.arm.com ([217.140.110.172]:57676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbgBFMFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 07:05:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2753730E;
        Thu,  6 Feb 2020 04:05:03 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 52D193F68E;
        Thu,  6 Feb 2020 04:05:02 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infread.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH] MAINTAINERS: remove myself from DT bindings entry
Date:   Thu,  6 Feb 2020 12:04:57 +0000
Message-Id: <20200206120457.9054-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For quite a while Rob has been handling DT binding maintenance, and I
haven't had the time to review bindings outside of a few targetted
cases. Given that, I think being listed in MAINTAINERS is more
misleading than helpful.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 56765f542244..85adf4735193 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12287,7 +12287,6 @@ F:	Documentation/ABI/testing/sysfs-firmware-ofw
 
 OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
 M:	Rob Herring <robh+dt@kernel.org>
-M:	Mark Rutland <mark.rutland@arm.com>
 L:	devicetree@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 Q:	http://patchwork.ozlabs.org/project/devicetree-bindings/list/
-- 
2.11.0

