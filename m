Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 097F690C74
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2019 05:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfHQDex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 23:34:53 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41075 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfHQDex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 23:34:53 -0400
Received: by mail-qt1-f193.google.com with SMTP id i4so8262927qtj.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 20:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=H0x/tH5aSizx2cH/6tkCkmxwDmqvYIh10OUi2/vlP6A=;
        b=RrOWVqtAwYiQTjsn94IdecmlpayPTz0Ejsu4j/UK56LNpGtQE5LsURBpfNwVRa9rOI
         /L4qoMp1y//4TzKxsFN7AQioVK9CtWnvX6iKAjOAzh2BNaMtkPuFyznKiTDX4akoKwLj
         JQ+EkB6SK0eQaG+ZtEoSEB3wjGdrakKUPDCBWkO6libbh31fx0CbdG5osqCt0zrky2Ns
         57YzKTG1w7h0cmt801V4p7OE7T5MAGQmotegRzwqPpiT+ykefO2X+Y4Yzq88zZjlmeuj
         x3kyvbH1f6pu5IQu2d72p02He6/mDCJKDJb63V+WDzc9erLj/Ok2cGuZOWe17vi6QsJD
         xy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=H0x/tH5aSizx2cH/6tkCkmxwDmqvYIh10OUi2/vlP6A=;
        b=NHpEO309qUSlKGRGFE8IkpBVA/DqsD5MX+IU7VD5iw2vpB00A4Mhc8DAouxLjDlyfl
         TmknM628eK/DxF6ZWMGwvgZ0aD4qnqGx0uIux6tXPsEWtlOwXClw7EskLnvxF/ae9Uw1
         OZweCsKjSwED0FrphTUZGwWqHt7BuDJYq6Gcyfw2q6DaYCXDmyqUlXe+2XLKYXJwE1RE
         0gPbUkdqlLvKxDRkTbJZ03qLts73V0pVYTIGiEtoogi20t5T7hLGvUFZ4ZG9SKdZWTLi
         ll3fc6OrcAxYPVNCvFMAlQoTDszHRDJVEqf3IXLzaxPzzRTTLMup1al0P5o/4ZVS69UK
         1NFw==
X-Gm-Message-State: APjAAAVf+TpqDk3hDFTJud5ae902dSR05v7zETf++Dm9FzSbyXhDaghY
        h4YiyfYI/DZrWiFTDw3v5kw7zFWYOU6ybg==
X-Google-Smtp-Source: APXvYqzKZFIiA1WayBaCAyJzE7QlJ+pLR5W/3o1VQ6ZxRYJvCp92/20b4AR3fq/Auj6gijjO6ilTIA==
X-Received: by 2002:ad4:4301:: with SMTP id c1mr996111qvs.138.1566012891520;
        Fri, 16 Aug 2019 20:34:51 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id f20sm5430480qtf.68.2019.08.16.20.34.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 20:34:51 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: devm_memremap_pages() triggers a kasan_add_zero_shadow() warning
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <CAPcyv4i9VFLSrU75U0gQH6K2sz8AZttqvYidPdDcS7sU2SFaCA@mail.gmail.com>
Date:   Fri, 16 Aug 2019 23:34:49 -0400
Cc:     Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev@googlegroups.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <0FB85A78-C2EE-4135-9E0F-D5623CE6EA47@lca.pw>
References: <1565991345.8572.28.camel@lca.pw>
 <CAPcyv4i9VFLSrU75U0gQH6K2sz8AZttqvYidPdDcS7sU2SFaCA@mail.gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 16, 2019, at 5:48 PM, Dan Williams <dan.j.williams@intel.com> =
wrote:
>=20
> On Fri, Aug 16, 2019 at 2:36 PM Qian Cai <cai@lca.pw> wrote:
>>=20
>> Every so often recently, booting Intel CPU server on linux-next =
triggers this
>> warning. Trying to figure out if  the commit 7cc7867fb061
>> ("mm/devm_memremap_pages: enable sub-section remap") is the culprit =
here.
>>=20
>> # ./scripts/faddr2line vmlinux devm_memremap_pages+0x894/0xc70
>> devm_memremap_pages+0x894/0xc70:
>> devm_memremap_pages at mm/memremap.c:307
>=20
> Previously the forced section alignment in devm_memremap_pages() would
> cause the implementation to never violate the KASAN_SHADOW_SCALE_SIZE
> (12K on x86) constraint.
>=20
> Can you provide a dump of /proc/iomem? I'm curious what resource is
> triggering such a small alignment granularity.

This is with memmap=3D4G!4G ,

# cat /proc/iomem=20
00000000-00000fff : Reserved
00001000-00093fff : System RAM
00094000-0009ffff : Reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000c7fff : Video ROM
000c8000-000cbfff : Adapter ROM
000cc000-000ccfff : Adapter ROM
000e0000-000fffff : Reserved
  000f0000-000fffff : System ROM
00100000-5a7a0fff : System RAM
5a7a1000-5b5e0fff : Reserved
5b5e1000-790fefff : System RAM
  69000000-78ffffff : Crash kernel
790ff000-791fefff : Reserved
791ff000-7b5fefff : ACPI Non-volatile Storage
7b5ff000-7b7fefff : ACPI Tables
7b7ff000-7b7fffff : System RAM
7b800000-8fffffff : Reserved
  80000000-8fffffff : PCI MMCONFIG 0000 [bus 00-ff]
90000000-c7ffbfff : PCI Bus 0000:00
  90000000-92afffff : PCI Bus 0000:01
    90000000-9000ffff : 0000:01:00.2
    91000000-91ffffff : 0000:01:00.1
    92000000-927fffff : 0000:01:00.1
    92800000-928fffff : 0000:01:00.2
    92900000-929fffff : 0000:01:00.2
    92a00000-92a7ffff : 0000:01:00.2
    92a80000-92a87fff : 0000:01:00.2
    92a88000-92a8bfff : 0000:01:00.1
    92a8c000-92a8c0ff : 0000:01:00.2
    92a8d000-92a8d1ff : 0000:01:00.0
  92b00000-92dfffff : PCI Bus 0000:02
    92b00000-92bfffff : 0000:02:00.1
      92b00000-92bfffff : igb
    92c00000-92cfffff : 0000:02:00.0
      92c00000-92cfffff : igb
    92d00000-92d03fff : 0000:02:00.1
      92d00000-92d03fff : igb
    92d04000-92d07fff : 0000:02:00.0
      92d04000-92d07fff : igb
    92d80000-92dfffff : 0000:02:00.0
  92e00000-92ffffff : PCI Bus 0000:03
    92e00000-92efffff : 0000:03:00.0
      92e00000-92efffff : hpsa
    92f00000-92f003ff : 0000:03:00.0
      92f00000-92f003ff : hpsa
    92f80000-92ffffff : 0000:03:00.0
  93000000-930003ff : 0000:00:1d.0
  93001000-930013ff : 0000:00:1a.0
  93003000-93003fff : 0000:00:05.4
c7ffc000-c7ffcfff : dmar1
c8000000-fbffbfff : PCI Bus 0000:80
  c8000000-c8000fff : 0000:80:05.4
fbffc000-fbffcfff : dmar0
fec00000-fecfffff : PNP0003:00
  fec00000-fec003ff : IOAPIC 0
  fec01000-fec013ff : IOAPIC 1
  fec40000-fec403ff : IOAPIC 2
fed00000-fed003ff : HPET 0
  fed00000-fed003ff : PNP0103:00
fed12000-fed1200f : pnp 00:01
fed12010-fed1201f : pnp 00:01
fed1b000-fed1bfff : pnp 00:01
fed1c000-fed3ffff : pnp 00:01
fed45000-fed8bfff : pnp 00:01
fee00000-feefffff : pnp 00:01
  fee00000-fee00fff : Local APIC
ff800000-ffffffff : Reserved
100000000-155dfffff : Persistent Memory (legacy)
  100000000-155dfffff : namespace0.0
155e00000-15982bfff : System RAM
  155e00000-156a00fa0 : Kernel code
  156a00fa1-15765d67f : Kernel data
  157837000-1597fffff : Kernel bss
15982c000-1ffffffff : Persistent Memory (legacy)
200000000-87fffffff : System RAM
  858000000-877ffffff : Crash kernel
38000000000-39fffffffff : PCI Bus 0000:00
  39fffe00000-39fffefffff : PCI Bus 0000:02
  39ffff00000-39ffff0ffff : 0000:00:14.0
  39ffff10000-39ffff13fff : 0000:00:04.7
  39ffff14000-39ffff17fff : 0000:00:04.6
  39ffff18000-39ffff1bfff : 0000:00:04.5
  39ffff1c000-39ffff1ffff : 0000:00:04.4
  39ffff20000-39ffff23fff : 0000:00:04.3
  39ffff24000-39ffff27fff : 0000:00:04.2
  39ffff28000-39ffff2bfff : 0000:00:04.1
  39ffff2c000-39ffff2ffff : 0000:00:04.0
  39ffff31000-39ffff310ff : 0000:00:1f.3
3a000000000-3bfffffffff : PCI Bus 0000:80
  3bffff00000-3bffff03fff : 0000:80:04.7
  3bffff04000-3bffff07fff : 0000:80:04.6
  3bffff08000-3bffff0bfff : 0000:80:04.5
  3bffff0c000-3bffff0ffff : 0000:80:04.4
  3bffff10000-3bffff13fff : 0000:80:04.3
  3bffff14000-3bffff17fff : 0000:80:04.2
  3bffff18000-3bffff1bfff : 0000:80:04.1
  3bffff1c000-3bffff1ffff : 0000:80:04.0

>=20
> Is it truly only linux-next or does latest mainline have this issue as =
well?

No idea. I have not had a chance to test it on the mainline yet.

