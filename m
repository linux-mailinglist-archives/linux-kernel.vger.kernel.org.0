Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA0219258A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 11:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbgCYK1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 06:27:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38790 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726073AbgCYK1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 06:27:50 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6683DA4D7888C90A18DD;
        Wed, 25 Mar 2020 18:27:43 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.153) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Wed, 25 Mar 2020
 18:27:33 +0800
Subject: Re: [PATCH v2] sys_personality: Add a optional arch hook
 arch_check_personality() for common sys_personality()
To:     Dominik Brodowski <linux@dominikbrodowski.net>
CC:     <mark.rutland@arm.com>, <hch@infradead.org>,
        <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>, <yangyingliang@huawei.com>,
        <guohanjun@huawei.com>, <wcohen@redhat.com>,
        <linux-kernel@vger.kernel.org>, <mtk.manpages@gmail.com>,
        <wezhang@redhat.com>
References: <20200109133634.176483-1-bobo.shaobowang@huawei.com>
 <20200110054551.GA352443@light.dominikbrodowski.net>
From:   "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Message-ID: <ec8e957b-9fd2-3956-f9c6-338ee7178951@huawei.com>
Date:   Wed, 25 Mar 2020 18:27:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20200110054551.GA352443@light.dominikbrodowski.net>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.222.153]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...

this issue still exists, I am looking forward to your attention.

�� 2020/1/10 13:45, Dominik Brodowski д��:
> On Thu, Jan 09, 2020 at 09:36:34PM +0800, Wang ShaoBo wrote:
>> currently arm64 use __arm64_sys_arm64_personality() as its default
>> syscall. But using a normal hook arch_check_personality() can reject
>> personality settings for special case of different archs.
>>
>> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
>
> Thanks,
> 	Dominik
> .

