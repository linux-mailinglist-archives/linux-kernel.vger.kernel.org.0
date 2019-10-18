Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC479DCA32
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 18:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409125AbfJRQC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 12:02:58 -0400
Received: from ms.lwn.net ([45.79.88.28]:36802 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408951AbfJRQC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:02:58 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AC26C2CA;
        Fri, 18 Oct 2019 16:02:57 +0000 (UTC)
Date:   Fri, 18 Oct 2019 10:02:56 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC] Docs: mark admin-guide/iostats.rst as needing updates
Message-ID: <20191018100256.75bb5c60@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file tells us all about how 2.4 reported I/O statistics, which is less
than fully useful.  Put a note at the top advising of this fact and
requesting some kind soul to bring things up to date.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---

I'm thinking about beginning to sprinkle these around Documentation/ in
the hope that they inspire helpful people to improve the situation.  It
works (I think?) for wikipedia, maybe we should give it a try...

 Documentation/admin-guide/iostats.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/iostats.rst b/Documentation/admin-guide/iostats.rst
index 5d63b18bd6d1..2d1b1c15fd91 100644
--- a/Documentation/admin-guide/iostats.rst
+++ b/Documentation/admin-guide/iostats.rst
@@ -2,6 +2,11 @@
 I/O statistics fields
 =====================
 
+.. note::
+
+   This document contains a great deal of outdated information; please
+   consider helping out by updating it to match current reality.
+
 Since 2.4.20 (and some versions before, with patches), and 2.5.45,
 more extensive disk statistics have been introduced to help measure disk
 activity. Tools such as ``sar`` and ``iostat`` typically interpret these and do
-- 
2.21.0

