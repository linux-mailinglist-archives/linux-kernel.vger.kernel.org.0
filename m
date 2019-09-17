Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B285B52D7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 18:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfIQQVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 12:21:47 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36049 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfIQQVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 12:21:47 -0400
Received: by mail-qk1-f196.google.com with SMTP id s18so4659381qkj.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 09:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7zcxfoeB93t2LFv4lA/iGGDzpuTwdsiMs4R0hCM94F0=;
        b=IPKfWlnk6g+8xYh6QPDOV11rgt8hSjZYNydSSMeCC5lKQ3BAPdYcMVFhqlL6/hwZ0L
         EpNpNap6RxUM7xANzt7U00kSQeknoPyQ0uViAZwm0bLghRCvcpjwrSukCB7LJP0jbqug
         AEambkcgJO2Rxl/j3spzefDlO8/yGcnoM6b3xgAltN01rOEE6NQh4V3K1/Vx98YKkQOu
         BrnCaimHtq85qpZJuiNfl/zuqz/jg+n6ZacxHKeAFoTQdf6eXO07ENRaIErUPzEcfZvG
         6VqeXfW7mFmajNBrjUD4+IoP3kIZdGCGAI9/IPGQK/9dVx4ArRCNMufP0PkHULbLyK6g
         Vglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7zcxfoeB93t2LFv4lA/iGGDzpuTwdsiMs4R0hCM94F0=;
        b=moKJBkK3KmBP9opG9ijdlpAmXkmdk9JpAMIlftDdIpS+OtgGeQkim6gnRxycpSqEAc
         7aEv2hoOSG20rtu3ylNYuTRlqRWMB9O9Es/vU3cECNWDNSS5f92XkbTPS4jvRozyagJY
         XoKEADkiDy82Mg5QAYpnbpV5mnGpK1vWlzN1OiYXVgk23lYM4ametTd3aM6FrWcM+KQO
         7R02+kKSxzk7RSqli9iwWVhkKsZa5meNtsPdcXImpCHeGavBOv1atLQUGwtdtGQJmccH
         /RNbCZTYZHfcJt3PyLzLAavPxa40klq2TULeNTM1AV6erL5hJooynGrJRUTZY2C8g57t
         wArg==
X-Gm-Message-State: APjAAAVHWhzGdR32+TQrKOhJmoSQ0zSbqxHr0HInEGEGJjk159HRN1Mh
        fD+aVD5l/wRH7qr2ZymmSjxpIw==
X-Google-Smtp-Source: APXvYqwb/MFu85JM4GcuDSGF0uOmP1Zyl45W9YDIPitIpFmqcKkM4HZhLZjsrcEi4qbiBF9otNjRKQ==
X-Received: by 2002:a05:620a:1458:: with SMTP id i24mr4660603qkl.361.1568737306585;
        Tue, 17 Sep 2019 09:21:46 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id b16sm1824587qtk.65.2019.09.17.09.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 09:21:45 -0700 (PDT)
Message-ID: <1568737304.5576.162.camel@lca.pw>
Subject: Re: [RFC PATCH v2] mm: initialize struct pages reserved by
 ZONE_DEVICE driver.
From:   Qian Cai <cai@lca.pw>
To:     Waiman Long <longman@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "hch@lst.de" <hch@lst.de>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "mst@redhat.com" <mst@redhat.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>
Date:   Tue, 17 Sep 2019 12:21:44 -0400
In-Reply-To: <59c946f8-843d-c017-f342-d007a5e14a85@redhat.com>
References: <20190906081027.15477-1-t-fukasawa@vx.jp.nec.com>
         <b7732a55-4a10-2c1d-c2f5-ca38ee60964d@redhat.com>
         <e762ee45-43e3-975a-ad19-065f07d1440f@vx.jp.nec.com>
         <40a1ce2e-1384-b869-97d0-7195b5b47de0@redhat.com>
         <6a99e003-e1ab-b9e8-7b25-bc5605ab0eb2@vx.jp.nec.com>
         <e4e54258-e83b-cf0b-b66e-9874be6b5122@redhat.com>
         <31fd3c86-5852-1863-93bd-8df9da9f95b4@vx.jp.nec.com>
         <38e58d23-c20b-4e68-5f56-20bba2be2d6c@redhat.com>
         <59c946f8-843d-c017-f342-d007a5e14a85@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-17 at 11:49 -0400, Waiman Long wrote:
> On 9/17/19 3:13 AM, David Hildenbrand wrote:
> > On 17.09.19 04:34, Toshiki Fukasawa wrote:
> > > On 2019/09/09 16:46, David Hildenbrand wrote:
> > > > Let's take a step back here to understand the issues I am aware of. I
> > > > think we should solve this for good now:
> > > > 
> > > > A PFN walker takes a look at a random PFN at a random point in time. It
> > > > finds a PFN with SECTION_MARKED_PRESENT && !SECTION_IS_ONLINE. The
> > > > options are:
> > > > 
> > > > 1. It is buddy memory (add_memory()) that has not been online yet. The
> > > > memmap contains garbage. Don't access.
> > > > 
> > > > 2. It is ZONE_DEVICE memory with a valid memmap. Access it.
> > > > 
> > > > 3. It is ZONE_DEVICE memory with an invalid memmap, because the section
> > > > is only partially present: E.g., device starts at offset 64MB within a
> > > > section or the device ends at offset 64MB within a section. Don't access it.
> > > 
> > > I don't agree with case #3. In the case, struct page area is not allocated on
> > > ZONE_DEVICE, but is allocated on system memory. So I think we can access the
> > > struct pages. What do you mean "invalid memmap"?
> > 
> > No, that's not the case. There is no memory, especially not system
> > memory. We only allow partially present sections (sub-section memory
> > hotplug) for ZONE_DEVICE.
> > 
> > invalid memmap == memmap was not initialized == struct pages contains
> > garbage. There is a memmap, but accessing it (e.g., pfn_to_nid()) will
> > trigger a BUG.
> > 
> 
> As long as the page structures exist, they should be initialized to some
> known state. We could set PagePoison for those invalid memmap. It is the

Sounds like you want to run page_init_poison() by default.


> garbage that are in those page structures that can cause problem if a
> struct page walker scan those pages and try to make sense of it.

