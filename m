Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD8A511E6E8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 16:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfLMPq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 10:46:28 -0500
Received: from mx2.freebsd.org ([96.47.72.81]:54510 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727693AbfLMPq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 10:46:28 -0500
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 1A5088C6E8;
        Fri, 13 Dec 2019 15:46:27 +0000 (UTC)
        (envelope-from emaste@freebsd.org)
Received: from freefall.freebsd.org (freefall.freebsd.org [IPv6:2610:1c1:1:6074::16:84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "freefall.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 47ZFQB5z05z497Q;
        Fri, 13 Dec 2019 15:46:26 +0000 (UTC)
        (envelope-from emaste@freebsd.org)
Received: by freefall.freebsd.org (Postfix, from userid 1079)
        id A3963303F; Fri, 13 Dec 2019 15:46:26 +0000 (UTC)
From:   emaste@FreeBSD.org
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ed Maste <emaste@freebsd.org>
Subject: [PATCH v2] perf tools: correct license on jsmn json parser
Date:   Fri, 13 Dec 2019 15:46:25 +0000
Message-Id: <20191213154625.41064-1-emaste@FreeBSD.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191212151244.26324-1-emaste@freefall.freebsd.org>
References: <20191212151244.26324-1-emaste@freefall.freebsd.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed Maste <emaste@freebsd.org>

This header is part of the jsmn json parser, introduced in 867a979a83.
Correct the SPDX tag to indicate that it is under the MIT license.

Signed-off-by: Ed Maste <emaste@freebsd.org>
Acked-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/pmu-events/jsmn.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jsmn.h b/tools/perf/pmu-events/jsmn.h
index c7b0f6ea2a31..1bdfd55fff30 100644
--- a/tools/perf/pmu-events/jsmn.h
+++ b/tools/perf/pmu-events/jsmn.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: MIT */
 #ifndef __JSMN_H_
 #define __JSMN_H_
 
-- 
2.24.0

