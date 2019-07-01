Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8FF345532
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 09:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfFNHCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 03:02:51 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37009 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfFNHCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 03:02:51 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hbgEc-0001r8-4O; Fri, 14 Jun 2019 09:02:50 +0200
Date:   Fri, 14 Jun 2019 09:02:49 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
cc:     Jonathan Corbet <corbet@lwn.net>
Subject: Documentation: Remove duplicate x86 index entry
Message-ID: <alpine.DEB.2.21.1906140902050.1791@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 got added twice to the index via the RST conversion and the MDS
documentation changes. Remove one instance.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 Documentation/index.rst |    1 -
 1 file changed, 1 deletion(-)

--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -112,7 +112,6 @@ implementation.
 .. toctree::
    :maxdepth: 2
 
-   x86/index
    sh/index
    x86/index
 
