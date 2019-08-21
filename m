Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5C2197B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 15:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbfHUNok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 09:44:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55771 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728616AbfHUNok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 09:44:40 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i0Quj-0005IB-Gn; Wed, 21 Aug 2019 15:44:37 +0200
Date:   Wed, 21 Aug 2019 15:44:37 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-rt-users@vger.kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, maz@kernel.org, rostedt@goodmis.org
Subject: Re: [RT PATCH 1/3] hrtimer: Use READ_ONCE to access timer->base in
 hrimer_grab_expiry_lock()
Message-ID: <20190821134437.efc3cs55o7uatrpj@linutronix.de>
References: <20190821092409.13225-1-julien.grall@arm.com>
 <20190821092409.13225-2-julien.grall@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190821092409.13225-2-julien.grall@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-21 10:24:07 [+0100], Julien Grall wrote:
> The update to timer->base is protected by the base->cpu_base->lock().
> However, hrtimer_grab_expirty_lock() does not access it with the lock.
> 
> So it would theorically be possible to have timer->base changed under
> our feet. We need to prevent the compiler to refetch timer->base so the
> check and the access is performed on the same base.

It is not a problem if the timer's bases changes. We get here because we
want to help the timer to complete its callback.
The base can only change if the timer gets re-armed on another CPU which
means is completed callback. In every case we can cancel the timer on
the next iteration.

Sebastian
