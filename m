Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD52FFD58
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 04:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfKRD3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Nov 2019 22:29:43 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39562 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfKRD3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 22:29:43 -0500
Received: by mail-pf1-f194.google.com with SMTP id x28so9666071pfo.6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 19:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=slCYCjmvNMTbkkbIU6vyjGQZT2Z+twrEjOEJUYrjB/c=;
        b=eNgIem4/xFKAvMK2zwOdZD70pAGJmpiUSO3H3mk4jnGgs/M6C0pK0Ot0PaeENzJWz8
         NQxszyDzkVM/ugqnd17zTKwmrmHSymGjZNUZasac1wraguqXDrA5ZjjKnZHH2eu6l+C7
         /DSvb3fpMuGvwkpIpZuLQtA9tXYgIFdp97zfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=slCYCjmvNMTbkkbIU6vyjGQZT2Z+twrEjOEJUYrjB/c=;
        b=ZBTcTXk6TwDN/wSWgu5hF1W5QRjEevEgI2t8Hp8bUBrZRx2EcPesfGEmmG4QyoNHyo
         p5A4qbqKTruPBkrQUpRATn3EKzv1ddobkDIr8lnxT5q0/AmiaF4gZf24FBXo0MVKWDF6
         dCjLDBteWXw50GbQ3ZqarAPrZTAv5hjKfWQGTzoQ/xhjeIrsqycGeY6rbHnH0tyryFg+
         H3QFMPP6uSzdqP2enEO2jCKCmcD/ZfFU3In0mpJSYGb7+z7MK63HXVD14OXmAigy2qPk
         JotK+eRG8lKVkVOw2qFfB2VJEwrR80Nnzpob7YQOzreuLvXsG21FIPt7ajJyOQV8PLkz
         GuiQ==
X-Gm-Message-State: APjAAAUvjtm6F4B/O/McoDhxl+5n5tUGks46PvDQv9eVJuZbIbe5uVe7
        JIYzcQ6Sqh0oJqRjCatKP65QWVZaPjo=
X-Google-Smtp-Source: APXvYqyRNgmF3OA7FCUV2xqL8GrsOdtKk0DM+NkVYniatqzTJKRhvCByMpDGpwM4hGX6fuRUrrrZvA==
X-Received: by 2002:a63:b502:: with SMTP id y2mr7469398pge.317.1574047782524;
        Sun, 17 Nov 2019 19:29:42 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-f1d8-c2a6-5354-14d8.static.ipv6.internode.on.net. [2001:44b8:1113:6700:f1d8:c2a6:5354:14d8])
        by smtp.gmail.com with ESMTPSA id j17sm18141516pfr.2.2019.11.17.19.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 19:29:41 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Qian Cai <cai@lca.pw>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, x86@kernel.org, aryabinin@virtuozzo.com,
        glider@google.com, luto@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com
Subject: Re: [PATCH v11 1/4] kasan: support backing vmalloc space with real shadow memory
In-Reply-To: <1573835765.5937.130.camel@lca.pw>
References: <20191031093909.9228-1-dja@axtens.net> <20191031093909.9228-2-dja@axtens.net> <1573835765.5937.130.camel@lca.pw>
Date:   Mon, 18 Nov 2019 14:29:38 +1100
Message-ID: <871ru5hnfh.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qian Cai <cai@lca.pw> writes:

> On Thu, 2019-10-31 at 20:39 +1100, Daniel Axtens wrote:
>>  	/*
>>  	 * In this function, newly allocated vm_struct has VM_UNINITIALIZED
>>  	 * flag. It means that vm_struct is not fully initialized.
>> @@ -3377,6 +3411,9 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>>  
>>  		setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
>>  				 pcpu_get_vm_areas);
>> +
>> +		/* assume success here */
>> +		kasan_populate_vmalloc(sizes[area], vms[area]);
>>  	}
>>  	spin_unlock(&vmap_area_lock);
>
> Here it is all wrong. GFP_KERNEL with in_atomic().

I think this fix will work, I will do a v12 with it included.

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a4b950a02d0b..bf030516258c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3417,11 +3417,14 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 
                setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
                                 pcpu_get_vm_areas);
+       }
+       spin_unlock(&vmap_area_lock);
 
+       /* populate the shadow space outside of the lock */
+       for (area = 0; area < nr_vms; area++) {
                /* assume success here */
                kasan_populate_vmalloc(sizes[area], vms[area]);
        }
-       spin_unlock(&vmap_area_lock);
 
        kfree(vas);
        return vms;


