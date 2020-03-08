Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1238217D441
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Mar 2020 15:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgCHOut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Mar 2020 10:50:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgCHOut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 10:50:49 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 294B9206D7;
        Sun,  8 Mar 2020 14:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583679049;
        bh=jiZUgiw903J+DUCfstjQGsTKFWuURmSCeObVb6QzvwQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uXpsIzGSKSlV6AelEtdj1xsUi/uGKF7drKMTXcDF8miOsYcQTu5aqM2bPxG4sKGLT
         eqqNc9eqEJMssSSWPPaVIy1SzgZGQaxSWnZJNeKDYi++lV6vdRzVxfv4JC8uTk6mig
         R7g1QF7x7mjBcsyUmqsAJRjxXGC4ol2tFvhHRBOA=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jAxGR-00B3Ed-9U; Sun, 08 Mar 2020 14:50:47 +0000
Date:   Sun, 8 Mar 2020 14:50:45 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     luanshi <zhangliguang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqdomain: Fix function documentation of
 __irq_domain_alloc_fwnode
Message-ID: <20200308145045.20ff820d@why>
In-Reply-To: <87o8t69agn.fsf@nanos.tec.linutronix.de>
References: <1583200125-58806-1-git-send-email-zhangliguang@linux.alibaba.com>
        <20200308135610.379db6da@why>
        <87o8t69agn.fsf@nanos.tec.linutronix.de>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tglx@linutronix.de, zhangliguang@linux.alibaba.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 08 Mar 2020 15:40:08 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> Marc Zyngier <maz@kernel.org> writes:
> 
> > On Tue,  3 Mar 2020 09:48:45 +0800
> > luanshi <zhangliguang@linux.alibaba.com> wrote:
> >  
> >> The function got renamed at some point, but the kernel-doc was not
> >> updated.
> >> 
> >> Signed-off-by: luanshi <zhangliguang@linux.alibaba.com>  
> >
> > Queued for 5.7.  
> 
> It's already in tip. You got a tip-bot mail telling you :)

That's the problem, I don't. Somehow, tip-bot dropped me from the cc
list (see [1]). How sad! ;-)

	M.

[1] https://lore.kernel.org/lkml/158322302088.28353.3499023675334636073.tip-bot2@tip-bot2/
-- 
Jazz is not dead. It just smells funny...
