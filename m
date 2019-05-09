Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5772B185CB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 09:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfEIHKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 03:10:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7737 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726192AbfEIHKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 03:10:18 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6730D60ABA2AFA2752F7;
        Thu,  9 May 2019 15:10:16 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.55) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Thu, 9 May 2019
 15:10:10 +0800
To:     <linux-kernel@vger.kernel.org>
CC:     Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        wanghaibin 00208455 <wanghaibin.wang@huawei.com>
From:   Heyi Guo <guoheyi@huawei.com>
Subject: Why do we mark vpending table as non-shareable in GICR_VPENDBASER?
Message-ID: <fbee07c9-ec3b-d443-2132-7208dae38539@huawei.com>
Date:   Thu, 9 May 2019 15:10:09 +0800
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

Hi Marc,

We can see in its_vpe_schedule() the shareability bits of GICR_VPENDBASER are set as non-shareable, But we set physical PENDBASER as inner-shareable. Is there any special reason for doing this? If it is because the vpending table is GICR specific, why don't we do the same for physical pending table?

We have not seen function issue with this setting, but a special detector in our hardware warns us that there are non-shareable requests sent out while some inner shareable cache entries still present in the cache, and it may cause data inconsistent.

Thanks,

Heyi


