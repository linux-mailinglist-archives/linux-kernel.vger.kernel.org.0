Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84F9713C36C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 14:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgAONn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 08:43:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47244 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgAONn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:43:27 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1irixB-0007Po-G9; Wed, 15 Jan 2020 14:43:25 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id C547110122A; Wed, 15 Jan 2020 14:43:14 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     chengkaitao <pilgrimtao@gmail.com>
Cc:     linux-kernel@vger.kernel.org, smuchun@gmail.com,
        Kaitao Cheng <pilgrimtao@gmail.com>
Subject: Re: [RESEND v2] irq: Refactor irq_wait_for_interrupt info to simplify the code
In-Reply-To: <20200106154430.3413-1-pilgrimtao@gmail.com>
References: <20200106154430.3413-1-pilgrimtao@gmail.com>
Date:   Wed, 15 Jan 2020 14:43:14 +0100
Message-ID: <877e1sg7il.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

chengkaitao <pilgrimtao@gmail.com> writes:
> From: Kaitao Cheng <pilgrimtao@gmail.com>
>
> Cleanup extra if(test_and_clear_bit), and put the other one in front.

That simplifies the code but opens a race window:

 CPU 0                                CPU 1
                                      irq_wait_for_interrupt()
                                        has not yet reached schedule()
 free_irq()
   remove_action();
   synchronize_irq();                   

   #ifdef CONFIG_DEBUG_SHIRQ
    action->handler()                   if (test_and_clear_bit())
                            ---> bit is not set yet                                           
      --> SET thread running
   #endif                               

   kthread_stop()                       if (kthread_stop())

                   ---> Leave with bit set and thread active count != 0

That's just the most obvious example...

Thanks,

        tglx
