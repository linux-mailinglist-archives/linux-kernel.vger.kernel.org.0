Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A28EF153A57
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 22:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgBEVg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 16:36:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:42402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbgBEVg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 16:36:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A9142072B;
        Wed,  5 Feb 2020 21:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580938587;
        bh=J8KWbx5Vd1+BCY+HDf4P/4Zw1QpVWI9/qZ+2elqkuqY=;
        h=From:To:Cc:Subject:Date:From;
        b=jRkD8jEyCjYQ3rjRtgw0rVD55GWMxdN7lba9jBInCUKifAfitr3kKXdUkvaIbERAy
         IVe8bBVJWylBOkFGXY+SP2kITGNyF1Ehjqp9CG6avkAU9iaRwWePTQXXG4tb+nA/Sx
         5vseyhaod5LzrK+jyvTkoDloEzn8x5aJTRbuw2f8=
From:   Sasha Levin <sashal@kernel.org>
To:     gregkh@linuxfoundation.org, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, kys@microsoft.com,
        jamorris@microsoft.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH] Documentation/process: Change Microsoft contact for embargoed hardware issues
Date:   Wed,  5 Feb 2020 16:36:21 -0500
Message-Id: <20200205213621.31474-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove Sasha Levin as the Microsoft contact. A new contact will be
assigned by Microsoft.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/process/embargoed-hardware-issues.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
index 33edae654599..a6f4f6e5c78b 100644
--- a/Documentation/process/embargoed-hardware-issues.rst
+++ b/Documentation/process/embargoed-hardware-issues.rst
@@ -250,7 +250,7 @@ an involved disclosed party. The current ambassadors list:
   Intel		Tony Luck <tony.luck@intel.com>
   Qualcomm	Trilok Soni <tsoni@codeaurora.org>
 
-  Microsoft	Sasha Levin <sashal@kernel.org>
+  Microsoft
   VMware
   Xen		Andrew Cooper <andrew.cooper3@citrix.com>
 
-- 
2.20.1

