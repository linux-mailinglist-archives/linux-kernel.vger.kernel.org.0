Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17267154870
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 16:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgBFPsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 10:48:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:32908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbgBFPsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:48:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96655214AF;
        Thu,  6 Feb 2020 15:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581004083;
        bh=WYopBR6PbX79E3JKfKMLDsKyMH5Mfjs/7FgPJZc0Qdo=;
        h=Date:From:To:Cc:Subject:From;
        b=bt0ybylQgAP2QTO7XKU58JTbdUcRrk01UlPDyRdZv6ZXzDADBo8P5ElyZ7+dl1Mfv
         Qv18jMF+1snA3+mOJ1lz56PwQFqixOCUwp3/psV4NUIENH7QphJXpAxDXxY8Hnl/P4
         aC1TDEcnW5F28bl805Nz+jvwY/iK2F1JzyGH15e4=
Date:   Thu, 6 Feb 2020 16:48:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] COPYING: state that all contributions really are covered by
 this file
Message-ID: <20200206154800.GA3754085@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly state that all contributions to the kernel source tree
really are covered under this COPYING file in case someone thought
otherwise.  Lawyers love to be pedantic, even more so than software
engineers at times, and this sentence makes them sleep easier.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 COPYING | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/COPYING b/COPYING
index da4cb28febe6..a635a38ef940 100644
--- a/COPYING
+++ b/COPYING
@@ -16,3 +16,5 @@ In addition, other licenses may also apply. Please see:
 	Documentation/process/license-rules.rst
 
 for more details.
+
+All contributions to the Linux Kernel are subject to this COPYING file.
-- 
2.25.0

