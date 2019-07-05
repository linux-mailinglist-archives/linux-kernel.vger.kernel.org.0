Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 017EF60DDC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2019 00:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfGEWcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jul 2019 18:32:31 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33114 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfGEWcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 18:32:31 -0400
Received: by mail-ot1-f67.google.com with SMTP id q20so10469686otl.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 15:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1wm0pw4O8jGrQBiDWGY1iI0LWQ3L51MTQbW4ZCjLQSg=;
        b=XBE4SDcAEoyDwNhulgwMtQTbrBG037H4PVtb7nFjbFfO2ZNN3pM/nd7NEiDXajAFdW
         TLFKn4/fILMTGTiYgco+0kEADRLiWR6qV1l7Jt9KrVk23UB+dGn9VZeuMt15OingZftG
         0qbCE9oI4nHFuHXjSBfgmZCrbqxHvK79C1hHZ8lo6ZSm13TyURqE9pB3FvoP9FZBK7px
         Pzr+ZC405VKPGBR2+d7wRb74aL0Rypv7pyUWdIkqlLs4pW6YR8g0RhG/YFfMoGmHxsit
         YNsAgMdgjZ2zn0HTOGzhE9tfNAQ0fQSh2rNWvjCGLLfhE+N2D7vYGs7MSu7wKz/AlHFC
         R4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1wm0pw4O8jGrQBiDWGY1iI0LWQ3L51MTQbW4ZCjLQSg=;
        b=ozx62hgWEJrxrwZZg4qCbV348B7z4y6Y1GIjSKnQTd7H7CREHIto9BUuqKXuhTe+sJ
         lscuAacAaayvdbplP0RTTtQO6QCBdWHMLOuLmiNFKPuXYWAgCIRemz+l2pLeiTe+TyKK
         1PSu0xgw3BfDDnAYRC/HX1g59jzlcal0aUcpVyl45EuEjhmEjJdK95uIW3GTb3hOLeEC
         v7FV4B9EhidRdCTyaYX/bmRZdUrXfl450Ci3dC1cRonlsqyb7A1fubMYFkn+SzDvCL5D
         VY5zNj5DJbTcuv6M1RWZ8CmFZlCt4JR0cs7puX8sZubqC77kB+zIhdO4bIi1S+rQ44AK
         FLBg==
X-Gm-Message-State: APjAAAUBeu3VlOLN+wLiG4KIGh0Vc4nAgFcAAXxKYtTcxSr6ZQztxVYS
        Df0Dx3JFFz1lHEqNXhMEL/dDzV3MVZvws1PEfWjJLljj
X-Google-Smtp-Source: APXvYqwGQbiNPwIE2byyxn0tHolot0gPU6NwuDBWiOyEImIrwg3SDFRjKvMGl+cUVDjhjAMM1pAdKSMDIUS/iPsAT8w=
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr4626247oto.207.1562365950689;
 Fri, 05 Jul 2019 15:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190705172025.46abf71e@canb.auug.org.au>
In-Reply-To: <20190705172025.46abf71e@canb.auug.org.au>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 5 Jul 2019 15:32:19 -0700
Message-ID: <CAPcyv4gU7TfBucm2WoAyUng8qaUQOxGu0PuuJNVd1u0m9Q_tQw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the nvdimm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pankaj Gupta <pagupta@redhat.com>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jakub Staron <jstaron@google.com>,
        Cornelia Huck <cohuck@redhat.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 5, 2019 at 12:20 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the nvdimm tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> In file included from <command-line>:32:
> ./usr/include/linux/virtio_pmem.h:19:2: error: unknown type name 'uint64_t'
>   uint64_t start;
>   ^~~~~~~~
> ./usr/include/linux/virtio_pmem.h:20:2: error: unknown type name 'uint64_t'
>   uint64_t size;
>   ^~~~~~~~

/me boggles at how this sat in 0day visible tree for a long while
without this report?

>
> Caused by commit
>
>   403b7f973855 ("virtio-pmem: Add virtio pmem driver")
>
> I have used the nvdimm tree from next-20190704 for today.

Thanks Stephen, sorry for the noise.
