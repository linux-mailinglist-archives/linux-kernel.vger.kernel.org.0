Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D842313DF7D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 17:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgAPQBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 11:01:44 -0500
Received: from mail.elvees.com ([80.90.126.250]:53823 "EHLO mail.elvees.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbgAPQBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:01:44 -0500
X-Greylist: delayed 633 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jan 2020 11:01:43 EST
Received: from virgo-pc.elvees.com ([81.26.151.163])
        (authenticated bits=0)
        by mail.elvees.com (8.14.3/8.14.2) with ESMTP id 00GFovp7003197
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT);
        Thu, 16 Jan 2020 18:50:57 +0300 (MSK)
        (envelope-from okitain@elvees.com)
Reply-To: okitain@elvees.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org
From:   Olga Kitaina <okitain@elvees.com>
Organization: ELVEES
Subject: irqchip: Figuring out utility of hierarchy irqdomain
Message-ID: <b27626dc-dad7-b19c-dcfd-f3668c5e5be6@elvees.com>
Date:   Thu, 16 Jan 2020 18:50:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I'm looking to implement an interrupt controller (referred to here 
as QLIC) that is based on the RISC-V PLIC (see 
drivers/irqchip/irq-sifive-plic.c), with the difference that it's not 
the root interrupt controller, but instead it is connected to a GIC.

The features of the controller are as follows:

* A cluster of DSPs serve as interrupt sources to QLIC, each DSP with 
several interrupt lines going to QLIC.
* Several interrupt lines (documented as TARGET_x) go from QLIC to the GIC.
* Sources are mapped to targets by way of writing a mask of allowed 
sources in the TARG_x_ENABLE register.
* The source of an interrupt mapped to TARGET_x can be determined by 
reading from register TARG_x_CC. Writing the number of the source to 
TARG_x_CC masks the interrupt.
* To mask all interrupts corresponding to TARGET_x, TARG_x_CC must be 
read repeatedly, with the values written back after the source interrupt 
is handled.
* Source numbers start from 1, 0 is a special case in TARG_x_CC - it 
corresponds to "no interrupt", and writing 0 to the register does nothing.

I am not yet well-acquainted with the irq subsystem, which means I am 
not sure what kind of APIs I need to use. This is why I have a couple of 
questions:
1. Do I understand correctly that using hierarchy irqdomain means that 
the interrupt controller has to have a 1:1 mapping between inputs and 
outputs?
2. Is a chained handler necessary for this setup, e.g. handling 0 in 
TARG_x_CC?

-- 
Regards,
Olga

