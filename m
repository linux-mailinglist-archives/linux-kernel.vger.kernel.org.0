Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26DDA34A14
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 16:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfFDOTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 10:19:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52530 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbfFDOSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nUtpajCtj97wPHuOj/zKTNziiUpSH4053jytFacwfJk=; b=QZqINWPBf2UBMlbZSvdhT6AK0h
        hMPbqk7q+ANApC+w0ofOiFQodski//utGvD+352TGXo4fG9yHDQ+yFNUi/g6+GLWV5CQMgzk+XvCD
        smRBIwbywgKTHiMxnIolHJnN65e2f3EnW915kLrUU6uihOW2eR4jsrlgwGXg4sFCHQ9BfNs+UhWpt
        BErDtjkH4kf/K5Agp6E5utTVOGw4NhqK2BIbvOWV5byA7RapXhmYU0TfAt9Apox6m6r4/eMQbLnwT
        1xoLR/FuWj0d79xLnQeprzu3fBCqtsuD1lns3xms/5aaFJpVZPqBPHy8tLKDCP4/qEV6CL2niA+jQ
        V3RMp+Hg==;
Received: from [179.182.172.34] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYAGH-0001Rm-UO; Tue, 04 Jun 2019 14:18:01 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hYAGE-0002kf-H9; Tue, 04 Jun 2019 11:17:58 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Masters <jcm@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH v2 01/22] ABI: sysfs-devices-system-cpu: point to the right docs
Date:   Tue,  4 Jun 2019 11:17:35 -0300
Message-Id: <0e474dfbb0784f8a985716ae1d080eadc083970a.1559656538.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559656538.git.mchehab+samsung@kernel.org>
References: <cover.1559656538.git.mchehab+samsung@kernel.org>
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
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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

