Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D505165A5F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 10:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgBTJm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 04:42:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:57004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbgBTJm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 04:42:56 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A018224656;
        Thu, 20 Feb 2020 09:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582191775;
        bh=2SwC4zw/8dUIq4oO6LbuFFcRT68/tfUA9DxhoKP9iQo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QN+c9THLNwmnDC0mh1575MbyEQbAoJy0uhQ/QjOYJihqeuTr+98vUtF1GhDe0ry0L
         lWfEpz5FHY/Qvj8p2uiiaVOo5Ism4W4JDnfTohVHJUh1QrnP5RdTWal2Q7eRgyHc5Z
         B7YmZ2/FxaiblbnNplQOPMx5DLkqqso90+hpS8JI=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1j4iMA-006hD7-0T; Thu, 20 Feb 2020 09:42:54 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 Feb 2020 09:42:53 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] irqchip: vic: Support cascaded VIC in device tree
In-Reply-To: <20200219153644.137293-1-linus.walleij@linaro.org>
References: <20200219153644.137293-1-linus.walleij@linaro.org>
Message-ID: <9e1e1315dd5e947407416dea8aeda359@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: linus.walleij@linaro.org, tglx@linutronix.de, jason@lakedaemon.net, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-19 15:36, Linus Walleij wrote:
> When transitioning some elder platforms to device tree it
> becomes necessary to cascade VIC IRQ chips off another
> interrupt controller.
> 
> Tested with the cascaded VIC on the Integrator/AP attached
> logic module IM-PD1.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Queued for 5.7.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
