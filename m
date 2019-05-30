Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B055303CD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 23:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfE3VHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 17:07:18 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42011 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfE3VHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 17:07:17 -0400
Received: by mail-ed1-f65.google.com with SMTP id g24so1452255eds.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 14:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pv5CB4WwZj0N9C+rEj8/2lRh5EGUHdn0uj79m0rM0oo=;
        b=VEU5u5GDrcgB8PRAclAeTaxHNWRXxNgMKQuxMFD2SFRizhpvwX2vSFrW58YKLvKdGO
         eVuKFZtXyc1RHb9iKevkl1RKESa8X+H4JsE7X49/wDWGTTF1++R+Oi6bCGLu0qiMFC7q
         hWo0t+OsCQNb5YJC5V+PLRuPaGXL4SH2RlhfYwJV76d+wtYGM87zkTYGJrmM5dahxIDn
         qHnxrRKHJ981k6zXutXR8rLnD27RwSUR9gdS6t3qdzrPraAAqPEeILMrt+Xu+DkaI8aO
         CnVCUN2x67n04/yYkoMoVaF4yzXSA1yTow1K1ywH4DmLZh4o+OnP8FcuMAvRu6sLPZIL
         UDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pv5CB4WwZj0N9C+rEj8/2lRh5EGUHdn0uj79m0rM0oo=;
        b=JlPWsGfCayQP4lI4jgIc+5134oQNXrQ44r7AM2IbpfbPdT9tEWdsftOMfFphlXgnoh
         jb3Z4aqxwzg+PpEQSsKu42c1ANNDIwuDmAGYlWkrjCmbQ97n7fS+butRDeuPGnxGRldo
         CEpibGao/OhaI9tG+so1MkQ7XOf6xqPjeI5e+BrhjtKacpdxgdL3J0s5jKk3imacObt8
         nBkNb7wG95zvVUW4UKS+7U5o8b8jTRpvU8Ki2d16P952aKWNurx/LfmpMqvSPpEfAKWW
         ZneHZrBRxh1HXW0pt4RAx0pwjKHunoCdvGtI5OwAh9I6XA4e+n+xEkZ245IDgP2+gNRz
         otKQ==
X-Gm-Message-State: APjAAAXXUYVPs2rDqrFvJoGW2DGcTwaPqctQIIBUvq+asQaSjIhlJDd3
        XFQToAPAGmWpnQ7twAzTwW/8JtM5O5hRHxzCDuZelA==
X-Google-Smtp-Source: APXvYqzIBqcTjn5yiKx6Vr6nLGFPUVRyPMd7kuo7uA8Xmjn8HuSs90QeWcqYdxDxX2LpwL8i4qi0lXPOMCD5KRVUoAU=
X-Received: by 2002:aa7:d711:: with SMTP id t17mr7195382edq.80.1559250436307;
 Thu, 30 May 2019 14:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190527111152.16324-1-david@redhat.com> <20190527111152.16324-8-david@redhat.com>
In-Reply-To: <20190527111152.16324-8-david@redhat.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 30 May 2019 17:07:05 -0400
Message-ID: <CA+CK2bBLtZL8qxsjJt-tdaOraJCbDYfH2cbQ1ABJJ8hYif8LiQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] mm/memory_hotplug: Create memory block devices
 after arch_add_memory()
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "mike.travis@hpe.com" <mike.travis@hpe.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Banman <andrew.banman@hpe.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>, Qian Cai <cai@lca.pw>,
        Arun KS <arunks@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 7:12 AM David Hildenbrand <david@redhat.com> wrote:
>
> Only memory to be added to the buddy and to be onlined/offlined by
> user space using /sys/devices/system/memory/... needs (and should have!)
> memory block devices.
>
> Factor out creation of memory block devices. Create all devices after
> arch_add_memory() succeeded. We can later drop the want_memblock parameter,
> because it is now effectively stale.
>
> Only after memory block devices have been added, memory can be onlined
> by user space. This implies, that memory is not visible to user space at
> all before arch_add_memory() succeeded.
>
> While at it
> - use WARN_ON_ONCE instead of BUG_ON in moved unregister_memory()
> - introduce find_memory_block_by_id() to search via block id
> - Use find_memory_block_by_id() in init_memory_block() to catch
>   duplicates
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: "mike.travis@hpe.com" <mike.travis@hpe.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Andrew Banman <andrew.banman@hpe.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Arun KS <arunks@codeaurora.org>
> Cc: Mathieu Malaterre <malat@debian.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

LGTM
Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
