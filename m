Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAD8A153089
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 13:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgBEMZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 07:25:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:60058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbgBEMZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 07:25:54 -0500
Received: from localhost (unknown [212.187.182.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89712218AC;
        Wed,  5 Feb 2020 12:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580905554;
        bh=BGUSK/7uLL7BOkAM9NLzAh6niDlDzSg/iI22QPLfcMc=;
        h=Date:From:To:Cc:Subject:From;
        b=zaKbhDCmBBEiZx7ly4AWYRsGbVH9TUORNVzBQ8m5G4y2e297nIZ7etGKZd1GCqD+1
         Vabp2NxYEi1wI5XX8Wl1kl6Ze2325+rJthUOgLkyAf4kwg4Wtje+RHkmJzeJy0W9ty
         26scb73vffIkOQjR6F/aNU//O7uhLKLOSpPyVmmU=
Date:   Wed, 5 Feb 2020 12:25:51 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        pzb@amzn.com
Subject: [PATCH] embargoed-hardware-issues: drop Amazon contact as the email
 address now bounces
Message-ID: <20200205122551.GA1185549@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter's email address bounces, so remove him as the contact for Amazon.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/process/embargoed-hardware-issues.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
index 33edae654599..3bc44a7932ee 100644
--- a/Documentation/process/embargoed-hardware-issues.rst
+++ b/Documentation/process/embargoed-hardware-issues.rst
@@ -260,7 +260,7 @@ an involved disclosed party. The current ambassadors list:
   Red Hat	Josh Poimboeuf <jpoimboe@redhat.com>
   SUSE		Jiri Kosina <jkosina@suse.cz>
 
-  Amazon	Peter Bowen <pzb@amzn.com>
+  Amazon
   Google	Kees Cook <keescook@chromium.org>
   ============= ========================================================
 
-- 
2.25.0

