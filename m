Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A30DBEC2B2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 13:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbfKAMas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 08:30:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59564 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726805AbfKAMar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:30:47 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B0B16D7898535B71EE5E;
        Fri,  1 Nov 2019 20:30:43 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Fri, 1 Nov 2019
 20:30:35 +0800
Subject: Re: [PATCH v2 21/36] irqchip/gic-v4.1: Allow direct invalidation of
 VLPIs
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
 <20191027144234.8395-22-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <cf2b6dc3-a33c-164d-25bb-6cdb24c9f424@huawei.com>
Date:   Fri, 1 Nov 2019 20:30:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191027144234.8395-22-maz@kernel.org>
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
> Just like for INVALL, GICv4.1 has grown a VPE-aware INVLPI register.
> Let's plumb it in and make use of the DirectLPI code in that case.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

