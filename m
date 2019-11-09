Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD222F5E11
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2019 09:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfKII1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Nov 2019 03:27:11 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43572 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726136AbfKII1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 03:27:10 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0EA999E548B750977C40;
        Sat,  9 Nov 2019 16:27:03 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Sat, 9 Nov 2019
 16:26:56 +0800
Subject: Re: [PATCH v2 03/11] irqchip/gic-v3-its: Allow LPI invalidation via
 the DirectLPI interface
To:     Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        <lorenzo.pieralisi@arm.com>, <Andrew.Murray@arm.com>,
        Heyi Guo <guoheyi@huawei.com>
References: <20191108165805.3071-1-maz@kernel.org>
 <20191108165805.3071-4-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <37704aea-06c1-1bfe-1c00-2498460c3bd2@huawei.com>
Date:   Sat, 9 Nov 2019 16:26:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20191108165805.3071-4-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/11/9 0:57, Marc Zyngier wrote:
> We currently don't make much use of the DirectLPI feature, and it would
> be beneficial to do this more, if only because it becomes a mandatory
> feature for GICv4.1.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/20191027144234.8395-4-maz@kernel.org

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

