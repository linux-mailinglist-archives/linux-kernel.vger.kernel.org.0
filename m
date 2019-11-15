Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 447A4FD29B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 02:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfKOB5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 20:57:23 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:50294 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726956AbfKOB5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 20:57:23 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CD7728AE8EE6C43EE20A;
        Fri, 15 Nov 2019 09:57:21 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Fri, 15 Nov 2019
 09:57:14 +0800
Subject: Re: [PATCH] debugfs: fix potential infinite loop in
 debugfs_remove_recursive
From:   "yukuai (C)" <yukuai3@huawei.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <oleg@redhat.com>, <jack@suse.cz>, <linux-kernel@vger.kernel.org>,
        <zhengbin13@huawei.com>, <yi.zhang@huawei.com>,
        <chenxiang66@hisilicon.com>, <xiexiuqi@huawei.com>,
        "Al Viro" <viro@ZenIV.linux.org.uk>
References: <1572528884-67565-1-git-send-email-yukuai3@huawei.com>
 <20191113151755.7125e914@gandalf.local.home>
 <a399ae58-a467-3ff9-5a01-a4a2cdcf4fd6@huawei.com>
 <20191113214307.29a8d001@oasis.local.home>
 <0ceb4529-5238-e7fc-2b5b-d2f0bdeb706e@huawei.com>
 <20191114093410.15f10eda@gandalf.local.home>
 <6ac793b1-5472-6a39-fe94-348ad6a4e2be@huawei.com>
Message-ID: <9441c491-3d91-f16b-71fc-aeb658d6c8f0@huawei.com>
Date:   Fri, 15 Nov 2019 09:57:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6ac793b1-5472-6a39-fe94-348ad6a4e2be@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.220.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2019/11/15 9:47, yukuai (C) 写道:
> 
> 
> On 2019/11/14 22:34, Steven Rostedt wrote:
>> On Thu, 14 Nov 2019 14:59:04 +0800
>> "yukuai (C)" <yukuai3@huawei.com> wrote:
>>
>>>> Have you tried this patch with lockdep enabled and tried to hit this
>>>> code path?
>>>>
>>
>>> You are right, I get the results with lockdep enabled:
>>
>> That was what I was afraid of :-(
>>
>>> [   64.314748] ============================================
>>> [   64.315568] WARNING: possible recursive locking detected
>>> [   64.316549] 5.4.0-rc7-dirty #5 Tainted: G           O
>>> [   64.317398] --------------------------------------------
>>> [   64.318230] rmmod/2607 is trying to acquire lock:
>>
>>>
>>> The warning will disappeare by adding
>>> lockdep_set_novalidate_class(&child->d_lock) before calling
>>> simple_empty(child). But I'm not sure It's the right modfication.
>>
>> I'm wondering if we should add a simple_empty_unlocked() that does
>> simple_empty() without taking the lock, to allow us to call
>> spin_lock_nested() on the child. Of course, I don't know how much
>> nesting we allow as it calls the nesting too.
> Do you think we can do this:
> 1. add a new enum type for dentry_d_lock_class:
> enum dentry_d_lock_class
> {
>      DENTRY_D_LOCK_NORMAL, /* implicitly used by plain spin_lock() APIs. */
>      DENTRY_D_LOCK_NESTED
missing a ','
>      DENTRY_D_LOCK_NESTED_1 /* maybe another name */
> };
> 2. use the new enum type in simple_empty
> int simple_empty(struct dentry *dentry)
> {
>      spin_lock(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
should be 'spin_lock_nested'
>      list_for_each_entry(child, &dentry->d_subdirs, d_child) {
>          spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED_1);
> }
> 
> If you agree, I'll try to send a patch or patchset(with modification in 
> debugfs_remove_recursive).
sorry about the stupid mistake..

Thanks!
Yu Kuai

