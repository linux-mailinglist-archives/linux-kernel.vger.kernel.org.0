Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2EB017D4D1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Mar 2020 17:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgCHQeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Mar 2020 12:34:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56789 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgCHQeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 12:34:03 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jAysH-0007T0-Fc; Sun, 08 Mar 2020 17:33:57 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 99600104096; Sun,  8 Mar 2020 17:33:56 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Marc Zyngier <maz@kernel.org>
Cc:     luanshi <zhangliguang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqdomain: Fix function documentation of __irq_domain_alloc_fwnode
In-Reply-To: <20200308145045.20ff820d@why>
References: <1583200125-58806-1-git-send-email-zhangliguang@linux.alibaba.com> <20200308135610.379db6da@why> <87o8t69agn.fsf@nanos.tec.linutronix.de> <20200308145045.20ff820d@why>
Date:   Sun, 08 Mar 2020 17:33:56 +0100
Message-ID: <87k13u956z.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Zyngier <maz@kernel.org> writes:

> On Sun, 08 Mar 2020 15:40:08 +0100
> Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> Marc Zyngier <maz@kernel.org> writes:
>> 
>> > On Tue,  3 Mar 2020 09:48:45 +0800
>> > luanshi <zhangliguang@linux.alibaba.com> wrote:
>> >  
>> >> The function got renamed at some point, but the kernel-doc was not
>> >> updated.
>> >> 
>> >> Signed-off-by: luanshi <zhangliguang@linux.alibaba.com>  
>> >
>> > Queued for 5.7.  
>> 
>> It's already in tip. You got a tip-bot mail telling you :)
>
> That's the problem, I don't. Somehow, tip-bot dropped me from the cc
> list (see [1]). How sad! ;-)

Tip-bot didn't. I stripped the cc list when applying the patch and
tip-bot only sees the git commit....

