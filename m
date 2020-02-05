Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7ACD15331D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 15:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgBEOeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 09:34:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:35396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgBEOeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:34:10 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80E27217BA;
        Wed,  5 Feb 2020 14:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580913249;
        bh=Itaszvd+CGRsoa3oRTb6Hv7hU7etzy6AGLUBM/kaay0=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=0QqJqszAs8SwpfM3Ll3F1k1VCwSmvvvzX+0VGgzaOYRD5IaWEvA557c+KmvoX7qIH
         j7XZCHxtVuvEuKG1nZhSrh7823RDSoTnwPhElttrXukUOU5nhoRIm//kvF0Iuvxklg
         TR3co75344OJyAGoXpiF4T5XI/mmBRpRJPtY4KLs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 50D8635227F3; Wed,  5 Feb 2020 06:34:09 -0800 (PST)
Date:   Wed, 5 Feb 2020 06:34:09 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, tglx@linutronix.de, gregkh@linuxfoundation.org,
        rmk+kernel@armlinux.org.uk, nico@fluxnic.net
Subject: [PATCH UP] Make smp_call_function_single() match SMP semantics
Message-ID: <20200205143409.GA7021@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In CONFIG_SMP=y kernels, smp_call_function_single() returns -ENXIO when
invoked for a non-existent CPU.  In contrast, in CONFIG_SMP=n kernels,
a splat is emitted and smp_call_function_single() otherwise silently
ignores its "cpu" argument, instead pretending that the caller intended
to have something happen on CPU 0.  Given that there is now code that
expects smp_call_function_single() to return an error if a bad CPU was
specified, this difference in semantics needs to be addressed.

This commit therefore brings the semantics of the CONFIG_SMP=n version
of smp_call_function_single() into alignment with its CONFIG_SMP=y
counterpart.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 up.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/up.c b/kernel/up.c
index 862b460..a504e81 100644
--- a/kernel/up.c
+++ b/kernel/up.c
@@ -14,7 +14,8 @@ int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
 {
 	unsigned long flags;
 
-	WARN_ON(cpu != 0);
+	if (cpu != 0)
+		return -ENXIO;
 
 	local_irq_save(flags);
 	func(info);
