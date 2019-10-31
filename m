Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD7DEABC4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 09:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfJaItt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 04:49:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33418 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726874AbfJaIts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 04:49:48 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9CED2566D52269F09AA3;
        Thu, 31 Oct 2019 16:49:45 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Thu, 31 Oct 2019
 16:49:34 +0800
Subject: Re: [PATCH v2 03/36] irqchip/gic-v3-its: Allow LPI invalidation via
 the DirectLPI interface
To:     Marc Zyngier <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-kernel@vger.kernel.org>
CC:     Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Andrew Murray" <Andrew.Murray@arm.com>,
        Jayachandran C <jnair@marvell.com>,
        "Robert Richter" <rrichter@marvell.com>
References: <20191027144234.8395-1-maz@kernel.org>
 <20191027144234.8395-4-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <a263e264-298c-57cf-31b7-a781160a3929@huawei.com>
Date:   Thu, 31 Oct 2019 16:49:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191027144234.8395-4-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2019/10/27 22:42, Marc Zyngier wrote:
> We currently don't make much use of the DirectLPI feature, and it would
> be beneficial to do this more, if only because it becomes a mandatory
> feature for GICv4.1.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

I have no objection to this patch, which says:

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>


But this patch really drives me to look through all callsites of
dev_event_to_col(), the abstraction which can be used _only_ with
physical LPI mappings.

I find that when building the INV command, we use dev_event_to_col()
to find the "sync_obj" and then pass it to the following SYNC command.
But the "INV+SYNC" will be performed both on physical LPI and *VLPI*
(lpi_update_config/its_send_inv).
So I have two questions about the way we sending INV on VLPI:

1) Which "sync" command should be followed?  SYNC or VSYNC?
(we currently use SYNC, while the spec says, SYNC "ensures all
outstanding ITS operations associated with *physical* interrupts
for the Redistributor are globally observed ...")

2) The "sync_obj" we are currently using seems to be wrong.


Thanks,
Zenghui

