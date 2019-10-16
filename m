Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 541B3D8A55
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 09:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390174AbfJPHzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 03:55:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48674 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfJPHzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:55:23 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iKe9R-0007yC-2j; Wed, 16 Oct 2019 09:55:21 +0200
Date:   Wed, 16 Oct 2019 09:55:21 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH 10/34] m68k/coldfire: Use CONFIG_PREEMPTION
Message-ID: <20191016075520.eauiemlvbo5a37d4@linutronix.de>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
 <20191015191821.11479-11-bigeasy@linutronix.de>
 <39d20c16-50a4-34f5-f98c-979138bf1a29@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39d20c16-50a4-34f5-f98c-979138bf1a29@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-16 10:50:41 [+1000], Greg Ungerer wrote:
> Hi Sebastian,
Hi Greg,

> On 16/10/19 5:17 am, Sebastian Andrzej Siewior wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> > 
> > CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
> > Both PREEMPT and PREEMPT_RT require the same functionality which today
> > depends on CONFIG_PREEMPT.
> > 
> > Switch the entry code over to use CONFIG_PREEMPTION.
> > 
> > Cc: Greg Ungerer <gerg@linux-m68k.org>
> 
> Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Thank you.

> Do you want me to take this via the m68knommu git tree?
> Or are you taking the whole series via some other tree?

It is up to you. You have all the dependencies so you can either add it
to your -next branch or leave it and we will pick it up for you.

> Regards
> Greg

Sebastian
