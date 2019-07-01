Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9DDC2F864
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 10:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfE3IPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 04:15:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39118 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725440AbfE3IPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:15:39 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 67677EBEDAA20966E231;
        Thu, 30 May 2019 16:15:36 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Thu, 30 May 2019
 16:15:35 +0800
Subject: Re: [PATCH -next] platform/chrome: cros_ec_lpc: Make some symbols
 static
To:     Guenter Roeck <groeck@google.com>
References: <20190529150749.8032-1-yuehaibing@huawei.com>
 <CABXOdTfbfWsan3MH0e=pnQ2DKw5p===1s4hKcnDdbRUwARPSDg@mail.gmail.com>
CC:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <e11f1097-7010-064d-1b82-17d6d8b697ec@huawei.com>
Date:   Thu, 30 May 2019 16:15:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CABXOdTfbfWsan3MH0e=pnQ2DKw5p===1s4hKcnDdbRUwARPSDg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/5/29 23:12, Guenter Roeck wrote:
> On Wed, May 29, 2019 at 8:08 AM YueHaibing <yuehaibing@huawei.com> wrote:
>>
>> Fix sparse warning:
>>
>> drivers/platform/chrome/cros_ec_debugfs.c:256:30: warning: symbol 'cros_ec_console_log_fops' was not declared. Should it be static?
>> drivers/platform/chrome/cros_ec_debugfs.c:265:30: warning: symbol 'cros_ec_pdinfo_fops' was not declared. Should it be static?
>> drivers/platform/chrome/cros_ec_lightbar.c:550:24: warning: symbol 'cros_ec_lightbar_attr_group' was not declared. Should it be static?
>> drivers/platform/chrome/cros_ec_sysfs.c:338:24: warning: symbol 'cros_ec_attr_group' was not declared. Should it be static?
>> drivers/platform/chrome/cros_ec_vbc.c:104:24: warning: symbol 'cros_ec_vbc_attr_group' was not declared. Should it be static?
>> drivers/platform/chrome/cros_ec_lpc.c:408:25: warning: symbol 'cros_ec_lpc_pm_ops' was not declared. Should it be static?
>>
> 
> The subject is misleading: The patch does not only affect cros_ec_lpc.

Sorry, will fix it in v2.

> 
> Guenter
> 
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/platform/chrome/cros_ec_debugfs.c  | 4 ++--
>>  drivers/platform/chrome/cros_ec_lightbar.c | 2 +-
>>  drivers/platform/chrome/cros_ec_lpc.c      | 2 +-
>>  drivers/platform/chrome/cros_ec_sysfs.c    | 2 +-
>>  drivers/platform/chrome/cros_ec_vbc.c      | 2 +-
>>  5 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
>> index 4c2a27f6a6d0..4578eb3e0731 100644
>> --- a/drivers/platform/chrome/cros_ec_debugfs.c
>> +++ b/drivers/platform/chrome/cros_ec_debugfs.c
>> @@ -241,7 +241,7 @@ static ssize_t cros_ec_pdinfo_read(struct file *file,
>>                                        read_buf, p - read_buf);
>>  }
>>
>> -const struct file_operations cros_ec_console_log_fops = {
>> +static const struct file_operations cros_ec_console_log_fops = {
>>         .owner = THIS_MODULE,
>>         .open = cros_ec_console_log_open,
>>         .read = cros_ec_console_log_read,
>> @@ -250,7 +250,7 @@ const struct file_operations cros_ec_console_log_fops = {
>>         .release = cros_ec_console_log_release,
>>  };
>>
>> -const struct file_operations cros_ec_pdinfo_fops = {
>> +static const struct file_operations cros_ec_pdinfo_fops = {
>>         .owner = THIS_MODULE,
>>         .open = simple_open,
>>         .read = cros_ec_pdinfo_read,
>> diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
>> index d30a6650b0b5..23a82ee4c785 100644
>> --- a/drivers/platform/chrome/cros_ec_lightbar.c
>> +++ b/drivers/platform/chrome/cros_ec_lightbar.c
>> @@ -547,7 +547,7 @@ static struct attribute *__lb_cmds_attrs[] = {
>>         NULL,
>>  };
>>
>> -struct attribute_group cros_ec_lightbar_attr_group = {
>> +static struct attribute_group cros_ec_lightbar_attr_group = {
>>         .name = "lightbar",
>>         .attrs = __lb_cmds_attrs,
>>  };
>> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
>> index c9c240fbe7c6..aaa21803633a 100644
>> --- a/drivers/platform/chrome/cros_ec_lpc.c
>> +++ b/drivers/platform/chrome/cros_ec_lpc.c
>> @@ -405,7 +405,7 @@ static int cros_ec_lpc_resume(struct device *dev)
>>  }
>>  #endif
>>
>> -const struct dev_pm_ops cros_ec_lpc_pm_ops = {
>> +static const struct dev_pm_ops cros_ec_lpc_pm_ops = {
>>         SET_LATE_SYSTEM_SLEEP_PM_OPS(cros_ec_lpc_suspend, cros_ec_lpc_resume)
>>  };
>>
>> diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
>> index fe0b7614ae1b..3edb237bf8ed 100644
>> --- a/drivers/platform/chrome/cros_ec_sysfs.c
>> +++ b/drivers/platform/chrome/cros_ec_sysfs.c
>> @@ -335,7 +335,7 @@ static umode_t cros_ec_ctrl_visible(struct kobject *kobj,
>>         return a->mode;
>>  }
>>
>> -struct attribute_group cros_ec_attr_group = {
>> +static struct attribute_group cros_ec_attr_group = {
>>         .attrs = __ec_attrs,
>>         .is_visible = cros_ec_ctrl_visible,
>>  };
>> diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
>> index 8392a1ec33a7..2aaefed87eb4 100644
>> --- a/drivers/platform/chrome/cros_ec_vbc.c
>> +++ b/drivers/platform/chrome/cros_ec_vbc.c
>> @@ -101,7 +101,7 @@ static struct bin_attribute *cros_ec_vbc_bin_attrs[] = {
>>         NULL
>>  };
>>
>> -struct attribute_group cros_ec_vbc_attr_group = {
>> +static struct attribute_group cros_ec_vbc_attr_group = {
>>         .name = "vbc",
>>         .bin_attrs = cros_ec_vbc_bin_attrs,
>>  };
>> --
>> 2.17.1
>>
>>
> 
> .
> 

