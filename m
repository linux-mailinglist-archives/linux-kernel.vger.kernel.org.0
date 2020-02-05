Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57873153BA6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 00:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgBEXIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 18:08:44 -0500
Received: from namei.org ([65.99.196.166]:43568 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbgBEXIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 18:08:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 015N8YLU023763;
        Wed, 5 Feb 2020 23:08:35 GMT
Date:   Thu, 6 Feb 2020 10:08:34 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Greg KH <greg@kroah.com>
cc:     Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, KY Srinivasan <kys@microsoft.com>
Subject: [PATCH] Documentation/process: Change Microsoft contact for embargoed
 hardware issues
Message-ID: <alpine.LRH.2.21.2002061006350.22130@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update Microsoft contact from Sasha to James.

Signed-off-by: James Morris <jmorris@namei.org>
---
 Documentation/process/embargoed-hardware-issues.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
index 33edae654599..5916d76f0d6b 100644
--- a/Documentation/process/embargoed-hardware-issues.rst
+++ b/Documentation/process/embargoed-hardware-issues.rst
@@ -250,7 +250,7 @@ an involved disclosed party. The current ambassadors list:
   Intel		Tony Luck <tony.luck@intel.com>
   Qualcomm	Trilok Soni <tsoni@codeaurora.org>
 
-  Microsoft	Sasha Levin <sashal@kernel.org>
+  Microsoft	James Morris <jamorris@linux.microsoft.com>
   VMware
   Xen		Andrew Cooper <andrew.cooper3@citrix.com>
 
-- 
2.21.1

