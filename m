Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5871627FB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 15:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgBROU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 09:20:26 -0500
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:39382 "EHLO
        9.mo68.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgBROUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 09:20:25 -0500
X-Greylist: delayed 3599 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Feb 2020 09:20:25 EST
Received: from player779.ha.ovh.net (unknown [10.110.208.89])
        by mo68.mail-out.ovh.net (Postfix) with ESMTP id CC2AA159157
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 14:01:09 +0100 (CET)
Received: from sk2.org (cre33-1_migr-88-122-126-116.fbx.proxad.net [88.122.126.116])
        (Authenticated sender: steve@sk2.org)
        by player779.ha.ovh.net (Postfix) with ESMTPSA id 35FCDF77769C;
        Tue, 18 Feb 2020 13:00:57 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH v2 8/8] docs: sysctl/kernel: remove rtsig entries
Date:   Tue, 18 Feb 2020 13:59:23 +0100
Message-Id: <20200218125923.685-9-steve@sk2.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218125923.685-1-steve@sk2.org>
References: <20200218125923.685-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16146812041506475397
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrjeekgdegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecukfhppedtrddtrddtrddtpdekkedruddvvddruddviedrudduieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjeelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These have no corresponding code in the kernel.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 Documentation/admin-guide/sysctl/kernel.rst | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 3d21e076aea4..ba4b51bb1f3e 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -902,16 +902,6 @@ ROM/Flash boot loader. Maybe to tell it what to do after
 rebooting. ???
 
 
-rtsig-max & rtsig-nr
-====================
-
-The file rtsig-max can be used to tune the maximum number
-of POSIX realtime (queued) signals that can be outstanding
-in the system.
-
-rtsig-nr shows the number of RT signals currently queued.
-
-
 sched_energy_aware
 ==================
 
-- 
2.20.1

