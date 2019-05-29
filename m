Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE4B2E947
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 01:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfE2XZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 19:25:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49114 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbfE2XYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=L/KP7KtqGaaaZ8mlQ/XMLM6HWoK8YMA1PHFDlloUkgo=; b=MOOKPUeO+LTuutF6OVA+jK9SHX
        6P4dAHjIordM9yPqhEbOp6QAbSTEyWSs5JBx59FZHOxoNqFRhpxA7GLPamO1N4ZfBJS9xCIP1N2Rt
        6qWDQMo4SpWawPWUfZ8E0yJl/mteYkPZcwY3hDr/R35ddvYPqFV0zhrKkx2bGQu8ZkHfGbEHMQ6/l
        Zevs3KdSkY1PXCgam3SVor1plwIUqOVmRL6smq1AxU5W+G9z3bg3hHzmSFeTrgI0iHfNSCtYbZ1gP
        aPST8V1jEXmbH9LYehX+lFG8FEZZTwBCuS20HibMza5ypwg/nSuzUHgAmnBDyD0j+mI1xvCNCzI7q
        CxaLecNA==;
Received: from 177.132.232.81.dynamic.adsl.gvt.net.br ([177.132.232.81] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW7vL-0005Rl-3t; Wed, 29 May 2019 23:23:59 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hW7vI-0007wj-Go; Wed, 29 May 2019 20:23:56 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jon Masters <jcm@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 01/22] ABI: sysfs-devices-system-cpu: point to the right docs
Date:   Wed, 29 May 2019 20:23:32 -0300
Message-Id: <557b33a4ed53fb1cd5da927c533e7fe283629869.1559171394.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559171394.git.mchehab+samsung@kernel.org>
References: <cover.1559171394.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpuidle doc was split on two, one at the admin guide
and another one at the driver API guide. Instead of pointing
to a non-existent file, point to both (admin guide being
the first one).

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 1528239f69b2..87478ac6c2af 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -137,7 +137,8 @@ Description:	Discover cpuidle policy and mechanism
 		current_governor: (RW) displays current idle policy. Users can
 		switch the governor at runtime by writing to this file.
 
-		See files in Documentation/cpuidle/ for more information.
+		See Documentation/admin-guide/pm/cpuidle.rst and
+		Documentation/driver-api/pm/cpuidle.rst for more information.
 
 
 What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/name
-- 
2.21.0

