Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5714F12284
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 21:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfEBTQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 15:16:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfEBTQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 15:16:06 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD0CB20C01;
        Thu,  2 May 2019 19:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556824565;
        bh=LhNYXfe4zOWYZBa7odxryiZv0JhrJtxrhhNF3bcbJmI=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=HdSIomsOrR/YtQFu+YTpB7UcZSQN5CYN3OcSihyyUXNpg8dI717D1vJRO41/aiWaO
         EEoHmFPwBOf2pdu1LzzREfvG7DK9DQi1PPl4BZUHsf1KhR5ak4JZdScXSHR1d66+il
         ZmRiOMSjNfvpOtrquZ9aWUqwenB4/lJG/TPJo2lI=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 4/4] Linux 3.18.138-rt116-rc1
Date:   Thu,  2 May 2019 14:15:39 -0500
Message-Id: <f0b31190556bc9dee60350acef811af6dda34c70.1556824516.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1556824516.git.tom.zanussi@linux.intel.com>
References: <cover.1556824516.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1556824516.git.tom.zanussi@linux.intel.com>
References: <cover.1556824516.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

v3.18.138-rt116-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index f2aa035883e8..7cd9a55e8702 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt115
+-rt116-rc1
-- 
2.14.1

