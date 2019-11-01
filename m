Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85212EC28D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 13:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbfKAMR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 08:17:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5684 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730552AbfKAMR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:17:26 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B574CA5A24D5CE4484E6;
        Fri,  1 Nov 2019 20:17:23 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Fri, 1 Nov 2019
 20:17:13 +0800
Subject: Re: [PATCH v2 20/36] irqchip/gic-v4.1: Suppress per-VLPI doorbell
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
 <20191027144234.8395-21-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <256391fa-56f1-7588-3bff-ae8aa36d6615@huawei.com>
Date:   Fri, 1 Nov 2019 20:17:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191027144234.8395-21-maz@kernel.org>
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
> Since GICv4.1 gives us a per-VPE doorbell, avoid programming anything
> else on VMOVI/VMAPI/VMAPTI and on any other action that would have
> otherwise resulted in a per-VLPI doorbell to be programmed.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

