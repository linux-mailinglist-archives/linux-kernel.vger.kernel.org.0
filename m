Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18DE8DAE5B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 15:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbfJQN2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 09:28:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53025 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfJQN2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 09:28:54 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iL5pf-0000Od-1U; Thu, 17 Oct 2019 15:28:47 +0200
Date:   Thu, 17 Oct 2019 15:28:47 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 29/34] backlight/jornada720: Use CONFIG_PREEMPTION
Message-ID: <20191017132846.ojsh27celyl76dlx@linutronix.de>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
 <20191015191821.11479-30-bigeasy@linutronix.de>
 <20191017113707.lsjwlhi6b4ittcpe@holly.lan>
 <20191017132324.GP4365@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191017132324.GP4365@dell>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-17 14:23:24 [+0100], Lee Jones wrote:
> So what are the OP's expectations in that regard?  I see this is a
> large set and I am only privy to this patch, thus lack wider
> visibility.  Does this patch depend on others, or is it independent?
> I'm happy to take it, but wish to avoid bisectability issues in the
> next release kernel.

It is independent, you can apply it to your -next branch. All
dependencies are merged.

Sebastian
