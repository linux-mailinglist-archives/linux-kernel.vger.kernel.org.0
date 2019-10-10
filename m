Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA407D2BBF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 15:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfJJNvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 09:51:42 -0400
Received: from muru.com ([72.249.23.125]:36904 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbfJJNvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:51:41 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D7D9E80BB;
        Thu, 10 Oct 2019 13:52:14 +0000 (UTC)
Date:   Thu, 10 Oct 2019 06:51:38 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Yi Zheng <goodmenzy@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        Sekhar Nori <nsekhar@ti.com>, Zheng Yi <yzheng@techyauld.com>
Subject: Re: Maybe a bug in kernel/irq/chip.c unmask_irq(), device IRQ masked
 unexpectedly. (re-formated the mail body, sorry)
Message-ID: <20191010135138.GU5610@atomide.com>
References: <CAJPHfYNx31=JjKiSEvihk_NszAWGuB-CKP84SAgx4EGsKrJxfA@mail.gmail.com>
 <20191009174500.GM5610@atomide.com>
 <CAJPHfYPkPSguU8vvZWbkeinZz1F7SSkcxJk6AAyTBKVfqNoGJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJPHfYPkPSguU8vvZWbkeinZz1F7SSkcxJk6AAyTBKVfqNoGJw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Yi Zheng <goodmenzy@gmail.com> [191010 06:22]:
> Hi
> 
>    My patch is canceled. I have tested that simple adjustment, the
> device IRQ masked unexpectedly. It seems that it is more easily to
> occur with that patch.
> 
> So, the root cause is not found yet.

OK. Based on your description, it could be a missing flush of a
posted write somewhere in the gpio-omap or intc path.

Regards,

Tony
