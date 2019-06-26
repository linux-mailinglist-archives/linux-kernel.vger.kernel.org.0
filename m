Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C65B56301
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 09:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfFZHRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 03:17:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45248 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFZHRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:17:22 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hg2BE-0006XH-9Y; Wed, 26 Jun 2019 09:17:20 +0200
Date:   Wed, 26 Jun 2019 09:17:19 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/6] workqueue: convert to raw_spinlock_t
Message-ID: <20190626071719.psyftqdop4ny3zxd@linutronix.de>
References: <20190613145027.27753-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190613145027.27753-1-bigeasy@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-13 16:50:21 [+0200], To linux-kernel@vger.kernel.org wrote:
> Hi,
> 
> the workqueue code has been reworked in -RT to use raw_spinlock_t based
> locking. This change allows to schedule worker from preempt_disable()ed
> or IRQ disabled section on -RT. This is the last patch. The previous
> patches are prerequisites or tiny cleanup (like patch #1 and #2).

a gentle *ping*

Sebastian
