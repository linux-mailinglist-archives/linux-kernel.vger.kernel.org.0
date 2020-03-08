Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C394F17D3EF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Mar 2020 14:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgCHNpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Mar 2020 09:45:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgCHNpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 09:45:00 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C6DD20848;
        Sun,  8 Mar 2020 13:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583675099;
        bh=RBjZPGsUiQKMAYuCVc9l3M8rUSO+5QKpF3FnNFmV69Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kMD8MttDVLiX3hA3MfRHVv5qnHIj82BuiW9zyDU0N9kIUBn18YRIocVffjTyk6jSL
         xA7TmOVqT+smgBO85YN9LCnqi2NNZXEdF47yhMLofmVP08yRmQzTXEKMeZf+BaMSzD
         gWRoj81zeFl4LGOZBCp084DMWmas1tbLxMZOVd/0=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jAwEj-00B2cM-AM; Sun, 08 Mar 2020 13:44:57 +0000
Date:   Sun, 8 Mar 2020 13:44:53 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3] irqchip: Replace setup_irq() by request_irq()
Message-ID: <20200308134453.32ab0fea@why>
In-Reply-To: <20200304004839.4729-1-afzal.mohd.ma@gmail.com>
References: <20200304004839.4729-1-afzal.mohd.ma@gmail.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: afzal.mohd.ma@gmail.com, linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, paul@crapouillou.net
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  4 Mar 2020 06:18:38 +0530
afzal mohammed <afzal.mohd.ma@gmail.com> wrote:

> request_irq() is preferred over setup_irq(). Invocations of setup_irq()
> occur after memory allocators are ready.
> 
> Per tglx[1], setup_irq() existed in olden days when allocators were not
> ready by the time early interrupts were initialized.
> 
> Hence replace setup_irq() by request_irq().
> 
> [1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos
> 
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>

I've queued this for 5.7.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
