Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFC8146F8A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 18:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgAWRXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 12:23:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:44108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgAWRXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 12:23:05 -0500
Received: from linux-8ccs (x2f7fea8.dyn.telefonica.de [2.247.254.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30AB1207FF;
        Thu, 23 Jan 2020 17:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579800184;
        bh=vdad4h34opYp5igmK3XVwdbMOblM1qfChkC2aQ7dLVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cs0hz3m7UAqKvsQ5oNLIQzdgRdSQjGmU0cMUw27DzycVvzfHfNH/nQ5z7PAO+W+5U
         c8OCWz5tPzB3HrmhpkQXB7fqizYL1b/ISqQRHpfOs1cEi7w0DDQRoFwjn5tUZsuRsX
         uDd89xMAqcCAODFElxaBDSxEYsTQskn/YEXoPMG0=
Date:   Thu, 23 Jan 2020 18:22:58 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     madhuparnabhowmik10@gmail.com
Cc:     linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        frextrite@gmail.com, rcu@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org
Subject: Re: [PATCH] module.h: Annotate mod_kallsyms with __rcu
Message-ID: <20200123172257.GA14784@linux-8ccs>
References: <20200122170447.20539-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200122170447.20539-1-madhuparnabhowmik10@gmail.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ madhuparnabhowmik10@gmail.com [22/01/20 22:34 +0530]:
>From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>
>This patch fixes the following sparse errors:
>
>kernel/module.c:3623:9: error: incompatible types in comparison expression
>kernel/module.c:4060:41: error: incompatible types in comparison expression
>kernel/module.c:4203:28: error: incompatible types in comparison expression
>kernel/module.c:4225:41: error: incompatible types in comparison expression
>
>Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

Hi Madhuparna,

Thanks, I can confirm this patch fixes the sparse warnings. I've
applied it to modules-next.

Jessica

>---
> include/linux/module.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/include/linux/module.h b/include/linux/module.h
>index bd165ba68617..dfdc8863e26a 100644
>--- a/include/linux/module.h
>+++ b/include/linux/module.h
>@@ -429,7 +429,7 @@ struct module {
>
> #ifdef CONFIG_KALLSYMS
> 	/* Protected by RCU and/or module_mutex: use rcu_dereference() */
>-	struct mod_kallsyms *kallsyms;
>+	struct mod_kallsyms __rcu *kallsyms;
> 	struct mod_kallsyms core_kallsyms;
>
> 	/* Section attributes */
>-- 
>2.17.1
>
