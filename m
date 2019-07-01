Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF1091AF29
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 05:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfEMDfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 May 2019 23:35:50 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:55163 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727202AbfEMDfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 23:35:50 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4FF9422136;
        Sun, 12 May 2019 23:35:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 12 May 2019 23:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=IWWUUKQi6OBmjXErF
        SkhIaMM+KOX6vf11cpQeCEFglA=; b=Ri2ZQRsEcQiG9fdh2dbALeoFQejH9F8ev
        6C/KPORarnj5gSQECfmKJgc9Myzm/FzA0ZDd4NHzhB8NJtQPOTfISM+U6XTDx8eO
        w4zEBxStlzJNVEwKOnzbg8gMk4poS+ChVhPSt8jvYJkurTybx4ovBsJydQtEWZ06
        /pHUJIPtFsP2lKxnfLX1YGeAig8WM4p+5llpLGh5SQnpQGP2VK1LXj3LFsEP0hV0
        jJjST7syJIqDBs4Q1M3xj5HrrhE2Rrj+eNN0mGNdJvNaimBFPy+wx7oyvhT/WpPC
        IjFatASHFWKHK5zCJC76c6fiJeZf3FHYXkq/fa3jgC90HqHWATpGw==
X-ME-Sender: <xms:FObYXGwDALMRbXhxwkySYU4hS4q75gOl_crtWCKu3p5BeibXnYhz0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrleefgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhnucev
    rdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkphepud
    dvgedrudeiledrudeirddukeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgsihhn
    sehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:FObYXDBMGnDpp_-OVAoSwdM6lUzGOz0GgarjlVlyPdA0M2DsJLeVnQ>
    <xmx:FObYXEevFceP0ym2GAsQS-QQxaEz-PUc0kWLkJcYue55k0j23bPU3A>
    <xmx:FObYXNnhMXXB-UVK8NBBYM-nTQ44RhBcOhts034KRQmh0HxW9qdx5w>
    <xmx:FebYXJ37BZ1pgmHFZT6d6TgzW81ZuOSDgts9CbNhFo5hQkd0eLkWbQ>
Received: from eros.localdomain (124-169-16-185.dyn.iinet.net.au [124.169.16.185])
        by mail.messagingengine.com (Postfix) with ESMTPA id 66DB08005C;
        Sun, 12 May 2019 23:35:46 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Cc:     "Tobin C. Harding" <tobin@kernel.org>
Subject: [PATCH] ocfs2: Fix error path kobject memory leak
Date:   Mon, 13 May 2019 13:34:58 +1000
Message-Id: <20190513033458.2824-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a call to kobject_init_and_add() fails we should call kobject_put()
otherwise we leak memory.

Add call to kobject_put() in the error path of call to
kobject_init_and_add().  Please note, this has the side effect that
the release method is called if kobject_init_and_add() fails.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---

Is it ok to send patches during the merge window?

Applies on top of Linus' mainline tag: v5.1

Happy to rebase if there are conflicts.

thanks,
Tobin.

 fs/ocfs2/filecheck.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ocfs2/filecheck.c b/fs/ocfs2/filecheck.c
index f65f2b2f594d..1906cc962c4d 100644
--- a/fs/ocfs2/filecheck.c
+++ b/fs/ocfs2/filecheck.c
@@ -193,6 +193,7 @@ int ocfs2_filecheck_create_sysfs(struct ocfs2_super *osb)
 	ret = kobject_init_and_add(&entry->fs_kobj, &ocfs2_ktype_filecheck,
 					NULL, "filecheck");
 	if (ret) {
+		kobject_put(&entry->fs_kobj);
 		kfree(fcheck);
 		return ret;
 	}
-- 
2.21.0

