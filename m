Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0779318CEC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 17:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfEIP0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 11:26:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7186 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726187AbfEIP0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 11:26:18 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E702ADD31853844834E4;
        Thu,  9 May 2019 23:26:14 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.55) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Thu, 9 May 2019
 23:26:06 +0800
To:     <linux-kernel@vger.kernel.org>
CC:     Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        wanghaibin 00208455 <wanghaibin.wang@huawei.com>
From:   Heyi Guo <guoheyi@huawei.com>
Subject: Does it make sense to flush ap_list of offlined vcpu?
Message-ID: <73927ccf-1582-2e91-051b-b22854df3290@huawei.com>
Date:   Thu, 9 May 2019 23:26:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.55]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

When guest OS calls PSCI CPU_OFF, the corresponding VCPU will be put in sleep state. But if there is still IRQ remaining in this VCPU's ap_list, this will block all the following triggers of this IRQ even to other VCPUs. Does it make sense to flush the ap_list of the VCPU when it is requested to be offlined? Or did I miss something?

Thanks,

Heyi


