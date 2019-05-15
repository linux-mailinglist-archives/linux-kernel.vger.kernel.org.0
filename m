Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71D881F53C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 15:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfEONOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 09:14:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47304 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfEONOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 09:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qShoqLt0JmHyoHgAq3sjRJ0pBZKTFY+W/Ie1+Gslfcs=; b=rYCXmxJt7WIVkj4UyET3hLn4H
        OmfbIB7jIAwSa9Jv4QvcOVmdEuLtr4hR6GYVoIViMZ7bWW94ldFI3s2GeCcXaveKviEIC88Yi5364
        90FxvdcJw6lodstcqCiNE2IioHmGFIGm1uVuP+hLxOXY/UrQHLUWMASdv6psi37jJPfIip/Wxz3Xc
        BTzsy2JNdKHNbhpUAFNeSMPGbiElM4NDeYb8AH1+3ZiU8nrOih5wfVNc1BQUc3TgRe7/4oBj52ZV3
        FJPXQm7UWb0JuyMa2ZJNdmKpwTqgwGQEB9yNibzD05AHHDBxIA4D78Dc377GEBv4O6nuBOghgN5kd
        Y8Kp+Ki5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQtk1-0000z1-RR; Wed, 15 May 2019 13:14:41 +0000
Date:   Wed, 15 May 2019 06:14:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: silence a -Wcast-function-type warning in
 dawr_write_file_bool
Message-ID: <20190515131441.GA3072@infradead.org>
References: <20190515120942.3812-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515120942.3812-1-malat@debian.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 02:09:42PM +0200, Mathieu Malaterre wrote:
> In commit c1fe190c0672 ("powerpc: Add force enable of DAWR on P9
> option") the following piece of code was added:
> 
>    smp_call_function((smp_call_func_t)set_dawr, &null_brk, 0);
> 
> Since GCC 8 this trigger the following warning about incompatible
> function types:

And the warning is there for a reason, and should not be hidden
behind a cast.  This should instead be fixed by something like this:

diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index da307dd93ee3..a26b67a1be83 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -384,6 +384,12 @@ void hw_breakpoint_pmu_read(struct perf_event *bp)
 bool dawr_force_enable;
 EXPORT_SYMBOL_GPL(dawr_force_enable);
 
+
+static void set_dawr_cb(void *info)
+{
+	set_dawr(info);
+}
+
 static ssize_t dawr_write_file_bool(struct file *file,
 				    const char __user *user_buf,
 				    size_t count, loff_t *ppos)
@@ -403,7 +409,7 @@ static ssize_t dawr_write_file_bool(struct file *file,
 
 	/* If we are clearing, make sure all CPUs have the DAWR cleared */
 	if (!dawr_force_enable)
-		smp_call_function((smp_call_func_t)set_dawr, &null_brk, 0);
+		smp_call_function(set_dawr_cb, &null_brk, 0);
 
 	return rc;
 }
