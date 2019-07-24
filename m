Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60A2073186
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 16:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfGXOXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 10:23:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38852 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfGXOXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:23:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C1DEB60388; Wed, 24 Jul 2019 14:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563978225;
        bh=pNTFd4GmgIemvAGZcRfXhGjbvAYr7N4RVD4y6EzlC9k=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=Zt0GZmdTrFmVCrJsx1/9WAQW1xa/jiZPsPOaSllL1ue5JuPzW+PdKgEItIIBcmwEk
         jBZJvVj+8374rQ4U5W1+N66Y1l4jGJJZ5Ih+idwpR96sI8YuxEFXc8vH9m9Gdg4qmc
         DaMRaShkRzM14qJHuRzUtIq884kgNBbJQkGAhr/0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DF597602F1;
        Wed, 24 Jul 2019 14:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563978224;
        bh=pNTFd4GmgIemvAGZcRfXhGjbvAYr7N4RVD4y6EzlC9k=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=TJ3QjVqKH6HXV0SSlY8bbkVtkHGfcsNegQjrsgyIGsfWcZDEhFFxX78UEPC9AS1df
         xxlm81zxYM96AHtoBHgzt9Vc21Tgrkue9Vz3xijEMmgAT0gL7j2JgZ+fqMpGUviSt+
         hQJBElL5KhC5qYxl54kmw/ghmhSUr9P9wazPQ3yA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DF597602F1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v5] driver core: Fix use-after-free and double free on
 glue directory
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     Muchun Song <smuchun@gmail.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     benh@kernel.crashing.org, prsood@codeaurora.org,
        gkohli@codeaurora.org, linux-kernel@vger.kernel.org
References: <20190718111958.17336-1-smuchun@gmail.com>
 <afd6b116-5d3b-2b5b-2748-164ee388173b@codeaurora.org>
Message-ID: <885c2912-029d-5c2e-8c2b-89bea2d763ac@codeaurora.org>
Date:   Wed, 24 Jul 2019 19:53:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <afd6b116-5d3b-2b5b-2748-164ee388173b@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/24/2019 7:11 PM, Mukesh Ojha wrote:
>
> On 7/18/2019 4:49 PM, Muchun Song wrote:
>> There is a race condition between removing glue directory and adding 
>> a new
>> device under the glue directory. It can be reproduced in following test:
>>
>> path 1: Add the child device under glue dir
>> device_add()
>>      get_device_parent()
>>          mutex_lock(&gdp_mutex);
>>          ....
>>          /*find parent from glue_dirs.list*/
>>          list_for_each_entry(k, &dev->class->p->glue_dirs.list, entry)
>>              if (k->parent == parent_kobj) {
>>                  kobj = kobject_get(k);
>>                  break;
>>              }
>>          ....
>>          mutex_unlock(&gdp_mutex);
>>          ....
>>      ....
>>      kobject_add()
>>          kobject_add_internal()
>>              create_dir()
>>                  sysfs_create_dir_ns()
>>                      if (kobj->parent)
>>                          parent = kobj->parent->sd;
>>                      ....
>>                      kernfs_create_dir_ns(parent)
>>                          kernfs_new_node()
>>                              kernfs_get(parent)
>>                          ....
>>                          /* link in */
>>                          rc = kernfs_add_one(kn);
>>                          if (!rc)
>>                              return kn;
>>
>>                          kernfs_put(kn)
>>                              ....
>>                              repeat:
>>                              kmem_cache_free(kn)
>>                              kn = parent;
>>
>>                              if (kn) {
>>                                  if (atomic_dec_and_test(&kn->count))
>>                                      goto repeat;
>>                              }
>>                          ....
>>
>> path2: Remove last child device under glue dir
>> device_del()
>>      cleanup_glue_dir()
>>          mutex_lock(&gdp_mutex);
>>          if (!kobject_has_children(glue_dir))
>>              kobject_del(glue_dir);
>>          kobject_put(glue_dir);
>>          mutex_unlock(&gdp_mutex);
>>
>> Before path2 remove last child device under glue dir, If path1 add a new
>> device under glue dir, the glue_dir kobject reference count will be
>> increase to 2 via kobject_get(k) in get_device_parent(). And path1 has
>> been called kernfs_new_node(), but not call kernfs_get(parent).
>> Meanwhile, path2 call kobject_del(glue_dir) beacause 0 is returned by
>> kobject_has_children(). This result in glue_dir->sd is freed and it's
>> reference count will be 0. Then path1 call kernfs_get(parent) will 
>> trigger
>> a warning in kernfs_get()(WARN_ON(!atomic_read(&kn->count))) and 
>> increase
>> it's reference count to 1. Because glue_dir->sd is freed by path2, 
>> the next
>> call kernfs_add_one() by path1 will fail(This is also use-after-free)
>> and call atomic_dec_and_test() to decrease reference count. Because the
>> reference count is decremented to 0, it will also call kmem_cache_free()
>> to free glue_dir->sd again. This will result in double free.
>>
>> In order to avoid this happening, we also should make sure that 
>> kernfs_node
>> for glue_dir is released in path2 only when refcount for glue_dir 
>> kobj is
>> 1 to fix this race.
>>
>> The following calltrace is captured in kernel 4.14 with the following 
>> patch
>> applied:
>>
>> commit 726e41097920 ("drivers: core: Remove glue dirs from sysfs 
>> earlier")
>>
>> -------------------------------------------------------------------------- 
>>
>> [    3.633703] WARNING: CPU: 4 PID: 513 at .../fs/kernfs/dir.c:494
>>                  Here is WARN_ON(!atomic_read(&kn->count) in 
>> kernfs_get().
>> ....
>> [    3.633986] Call trace:
>> [    3.633991]  kernfs_create_dir_ns+0xa8/0xb0
>> [    3.633994]  sysfs_create_dir_ns+0x54/0xe8
>> [    3.634001]  kobject_add_internal+0x22c/0x3f0
>> [    3.634005]  kobject_add+0xe4/0x118
>> [    3.634011]  device_add+0x200/0x870
>> [    3.634017]  _request_firmware+0x958/0xc38
>> [    3.634020]  request_firmware_into_buf+0x4c/0x70
>> ....
>> [    3.634064] kernel BUG at .../mm/slub.c:294!
>>                  Here is BUG_ON(object == fp) in set_freepointer().
>> ....
>> [    3.634346] Call trace:
>> [    3.634351]  kmem_cache_free+0x504/0x6b8
>> [    3.634355]  kernfs_put+0x14c/0x1d8
>> [    3.634359]  kernfs_create_dir_ns+0x88/0xb0
>> [    3.634362]  sysfs_create_dir_ns+0x54/0xe8
>> [    3.634366]  kobject_add_internal+0x22c/0x3f0
>> [    3.634370]  kobject_add+0xe4/0x118
>> [    3.634374]  device_add+0x200/0x870
>> [    3.634378]  _request_firmware+0x958/0xc38
>> [    3.634381]  request_firmware_into_buf+0x4c/0x70
>> -------------------------------------------------------------------------- 
>>
>>
>> Fixes: 726e41097920 ("drivers: core: Remove glue dirs from sysfs 
>> earlier")
>>
>> Signed-off-by: Muchun Song <smuchun@gmail.com>
>> ---
>>
>> Change in v5:
>>         1. Revert to the v1 fix.
>>         2. Add some comment to explain why we need do this in
>>            cleanup_glue_dir().
>> Change in v4:
>>         1. Add some kerneldoc comment.
>>         2. Remove unlock_if_glue_dir().
>>         3. Rename get_device_parent_locked_if_glue_dir() to
>>            get_device_parent_locked.
>>         4. Update commit message.
>> Change in v3:
>>         Add change log.
>> Change in v2:
>>         Fix device_move() also.
>>
>>   drivers/base/core.c | 54 ++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 53 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index 4aeaa0c92bda..1a67ee325584 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -1825,7 +1825,59 @@ static void cleanup_glue_dir(struct device 
>> *dev, struct kobject *glue_dir)
>>           return;
>>         mutex_lock(&gdp_mutex);
>> -    if (!kobject_has_children(glue_dir))
>> +    /**
>> +     * There is a race condition between removing glue directory
>> +     * and adding a new device under the glue directory.
>> +     *
>> +     * path 1: Add the child device under glue dir
>> +     * device_add()
>> +     *    get_device_parent()
>> +     *        mutex_lock(&gdp_mutex);
>> +     *        ....
>> +     *        list_for_each_entry(k, &dev->class->p->glue_dirs.list,
>> +     *                    entry)
>> +     *        if (k->parent == parent_kobj) {
>> +     *            kobj = kobject_get(k);
>> +     *            break;
>> +     *        }
>> +     *        ....
>> +     *        mutex_unlock(&gdp_mutex);
>> +     *        ....
>> +     *    ....
>> +     *    kobject_add()
>> +     *        kobject_add_internal()
>> +     *        create_dir()
>> +     *            ....
>> +     *            if (kobj->parent)
>> +     *                parent = kobj->parent->sd;
>> +     *            ....
>> +     *            kernfs_create_dir_ns(parent)
>> +     *                ....
>> +     *
>> +     * path2: Remove last child device under glue dir
>> +     * device_del()
>> +     *    cleanup_glue_dir()
>> +     *        ....
>> +     *        mutex_lock(&gdp_mutex);
>> +     *        if (!kobject_has_children(glue_dir))
>> +     *            kobject_del(glue_dir);
>> +     *        ....
>> +     *        mutex_unlock(&gdp_mutex);
>> +     *
>> +     * Before path2 remove last child device under glue dir, if 
>> path1 add
>> +     * a new device under glue dir, the glue_dir kobject reference 
>> count
>> +     * will be increase to 2 via kobject_get(k) in get_device_parent().
>> +     * And path1 has been called kernfs_create_dir_ns(). Meanwhile,
>> +     * path2 call kobject_del(glue_dir) beacause 0 is returned by
>> +     * kobject_has_children(). This result in glue_dir->sd is freed.
>> +     * Then the path1 will see a stale "empty" but still potentially 
>> used
>> +     * glue dir around.
>> +     *
>> +     * In order to avoid this happening, we also should make sure that
>> +     * kernfs_node for glue_dir is released in path2 only when refcount
>> +     * for glue_dir kobj is 1.
>> +     */
>> +    if (!kobject_has_children(glue_dir) && 
>> kref_read(&glue_dir->kref) == 1)
> Instead of hardcoding "1 " , can't we check against zero Like Prateek 
> sood did in his patch.https://lkml.org/lkml/2019/5/1/3
>
> +ref = kref_read(&glue_dir->kref);
> +if  (!kobject_has_children(glue_dir) && --ref)
>
I meant if  (!kobject_has_children(glue_dir) && ! --ref)
>
>
> We have seen many pattern of this issue which is coming from different 
> driver e.g uinput as well in 4.14 
> kernel.(https://lkml.org/lkml/2019/4/10/146)
> The reason why it  started coming after
>
> 726e41097920 ("drivers: core: Remove glue dirs from sysfs earlier")
>
> Looks good to me
>
> Reviewed-by: Mukesh Ojha  <mojha@codeaurora.org>
>
>
> -Mukesh
>
>
>>           kobject_del(glue_dir);
>>       kobject_put(glue_dir);
>>       mutex_unlock(&gdp_mutex);
