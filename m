Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A92A1154C7F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 20:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgBFT54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 14:57:56 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:34153 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727479AbgBFT5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:57:55 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581019074; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=KAk+1eC9itPXZeutRqzTUsBlRAN96ExD8xZCnIhug5M=; b=U7IgvuJWrSzT+54qdApOkCjhteeXBTdYTngB2eKvDW3fv6A+v2VFBpG0Op6cZMJhwjAbcFLa
 7Y7o8hPUBf5BqdUOOxP2Usg9gDpXX8uR424yO6g30Z1W54j3DtSiGoa0R00QETi/wzPodwZH
 XkAuiF9zP01PBrTwbRITAJhB5Bc=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3c6fc1.7f5ebbbe9960-smtp-out-n01;
 Thu, 06 Feb 2020 19:57:53 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D8359C4479C; Thu,  6 Feb 2020 19:57:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1A733C43383;
        Thu,  6 Feb 2020 19:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1A733C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Thu, 6 Feb 2020 12:57:52 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Maulik Shah <mkshah@codeaurora.org>
Subject: Re: [PATCH v2] genirq: Clarify that irq wake state is orthogonal to
 enable/disable
Message-ID: <20200206195752.GA8107@codeaurora.org>
References: <20200206191521.94559-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200206191521.94559-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06 2020 at 12:15 -0700, Stephen Boyd wrote:
>There's some confusion around if an irq that's disabled with
>disable_irq() can still wake the system from sleep states such as
>"suspend to RAM". Let's clarify this in the kernel documentation for
>irq_set_irq_wake() so that it's clear that an irq can be disabled and
>still wake the system if it has been marked for wakeup.
>
Thomas also mentioned that hardware could work either way and probably
should not be assumed to work one way or the other.

>Cc: Marc Zyngier <maz@kernel.org>
>Cc: Douglas Anderson <dianders@chromium.org>
>Cc: Lina Iyer <ilina@codeaurora.org>
>Cc: Maulik Shah <mkshah@codeaurora.org>
>Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>---
>
>Changes from v1:
> * Added the last sentence from tglx
>
> kernel/irq/manage.c | 7 +++++++
> 1 file changed, 7 insertions(+)
>
>diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
>index 818b2802d3e7..e1e217d7778c 100644
>--- a/kernel/irq/manage.c
>+++ b/kernel/irq/manage.c
>@@ -731,6 +731,13 @@ static int set_irq_wake_real(unsigned int irq, unsigned int on)
>  *
>  *	Wakeup mode lets this IRQ wake the system from sleep
>  *	states like "suspend to RAM".
>+ *
>+ *	Note: irq enable/disable state is completely orthogonal
>+ *	to the enable/disable state of irq wake. An irq can be
>+ *	disabled with disable_irq() and still wake the system as
>+ *	long as the irq has wake enabled. If this does not hold,
>+ *	then either the underlying irq chip and the related driver
>+ *	need to be investigated.
>  */
> int irq_set_irq_wake(unsigned int irq, unsigned int on)
> {
>-- 
>Sent by a computer, using git, on the internet
>
