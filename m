Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97D1B11239F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 08:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfLDHbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 02:31:31 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6747 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725958AbfLDHbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 02:31:31 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3F60F3216FAD16662644;
        Wed,  4 Dec 2019 15:31:30 +0800 (CST)
Received: from [127.0.0.1] (10.133.216.73) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Dec 2019
 15:31:23 +0800
To:     Mike Waychison <mikew@google.com>
CC:     <linux-kernel@vger.kernel.org>,
        wanghaibin 00208455 <wanghaibin.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
From:   Guoheyi <guoheyi@huawei.com>
Subject: firmware: dmi-sysfs: why is the access mode of dmi sysfs entries
 restricted to 0400?
Message-ID: <42bb2db8-66e0-3df4-75b7-98b2b2bcfca8@huawei.com>
Date:   Wed, 4 Dec 2019 15:31:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.216.73]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Why is the access mode of dmi sysfs entries restricted to 0400? Is it 
for security concern? If it is, which information do we consider as privacy?

We would like to fetch CPU information from non-root application, is 
there feasible way to do that?

Any advice is appreciated.

Thanks,

Heyi


