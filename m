Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7B9F5E10
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2019 09:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfKII05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Nov 2019 03:26:57 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5752 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726136AbfKII04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 03:26:56 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 32D67157DA822E96A5FA;
        Sat,  9 Nov 2019 16:26:53 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Sat, 9 Nov 2019
 16:26:43 +0800
Subject: Re: [PATCH v2 01/11] irqchip/gic-v3-its: Free collection mapping on
 device teardown
To:     Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        <lorenzo.pieralisi@arm.com>, <Andrew.Murray@arm.com>,
        Heyi Guo <guoheyi@huawei.com>
References: <20191108165805.3071-1-maz@kernel.org>
 <20191108165805.3071-2-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <68a30908-90ea-7aeb-0ef2-6197ef8805e3@huawei.com>
Date:   Sat, 9 Nov 2019 16:26:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20191108165805.3071-2-maz@kernel.org>
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
> We allocate the collection mapping on device creation, but somehow
> free it on the irqdomain free path, which is pretty inconsistent
> and has led to bugs in the past.
> 
> Move it to the point where we teardown the device, making the
> alloc/free symetric.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

