Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6428AA99
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 00:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfHLWjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 18:39:23 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43614 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfHLWjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 18:39:23 -0400
Received: by mail-ot1-f68.google.com with SMTP id e12so20939955otp.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 15:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3aW5whQDJuBeImZ/vm/gZQhI4k4oQ8vroJ1EZoWTTJg=;
        b=W5RPcjMy2nSOxlc4JEQN/FwtmfGeYjojp9ZODu4ApD4CFAxXskqe+/tMV9edw9LUdx
         qnlUND2MQlVVlnOu7OGYLgJuZf4cj69zqu/4J89ENTbTDUFhgZrGN1dcouiEGSJDIKTv
         o/JtrRgZ/xJIsXmeC3F8OwvGykjcnMREp0KRFnpgOCL6zagxsRbC5C54aynLQTRDUqYi
         jhXMUGbVLruMjszhZFEpIvilTWNyNkBnr6HlHaN1RHkovoMhGAGAv6/rEmt5BZq726Yv
         kL8Nyzc4obRWZMKrP5ghFcL3rhUa8D/iVtsx1IjYskP+I4BJK7OlaRrKsNReR5wsC6RW
         hwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3aW5whQDJuBeImZ/vm/gZQhI4k4oQ8vroJ1EZoWTTJg=;
        b=AQrbIZfIxPYxq4WK5dkfTLbvk/gytsTUocLwkV3I1NPeO9K02CKnD2zxJSk1beaHiA
         yfi3x4nj1M9kbVR0pa5F5NbL7xoUxcl3jSl1VMJw4+eul5n4iyhudG/rNsUEiL1QMGyF
         kzm0t3w93lA/xM6fUsbeWH7bt+vC5jnZKjzUFQHX/y5PoXcyDfNOfik+YLpJlEtRGu61
         f2T18d/8bxZPkpq6a05xpgOjutE1flRHtKAoEm1UJTyhs1rembPSKnzT11t7lVKxdJhh
         d8CnJeaYfQ4h6PwZkqev4PQ70/yJoISycZ+QPiGENpANwlE7mG29pxTzcXRoTs3B/LHg
         FdFA==
X-Gm-Message-State: APjAAAUUQHEDYiPT5QAnTS1Srcun8pDJEH4/PDhG+yCe/VTdPfKFZ+OW
        pK/zDYH7rHEvLSlEx3P0yD3T+LXtuloCY5Wm2OVN2g==
X-Google-Smtp-Source: APXvYqyZa9vrGETWKw/3K2ZNQJVHXbpz2NU1cLAvQDyLfoeTJYzgNcrQQuvBKjD9GBMcejKS62NxlzuqZX/kdrrVoDI=
X-Received: by 2002:a9d:7248:: with SMTP id a8mr33233142otk.363.1565649562325;
 Mon, 12 Aug 2019 15:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190812213158.22097.30576.stgit@localhost.localdomain> <20190812213337.22097.66780.stgit@localhost.localdomain>
In-Reply-To: <20190812213337.22097.66780.stgit@localhost.localdomain>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 12 Aug 2019 15:39:11 -0700
Message-ID: <CAPcyv4id6nUNHJxspAWjaLFSPyLM_2jSKAa5PDibqeQXP0yN5w@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] mm: Use zone and order instead of free area in
 free_list manipulators
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     nitesh@redhat.com, KVM list <kvm@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        virtio-dev@lists.oasis-open.org,
        Oscar Salvador <osalvador@suse.de>, yang.zhang.wz@gmail.com,
        Pankaj Gupta <pagupta@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        lcapitulino@redhat.com, "Wang, Wei W" <wei.w.wang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 2:33 PM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
>
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>
> In order to enable the use of the zone from the list manipulator functions
> I will need access to the zone pointer. As it turns out most of the
> accessors were always just being directly passed &zone->free_area[order]
> anyway so it would make sense to just fold that into the function itself
> and pass the zone and order as arguments instead of the free area.
>
> In order to be able to reference the zone we need to move the declaration
> of the functions down so that we have the zone defined before we define the
> list manipulation functions.

Independent of the code movement for the zone declaration this looks
like a nice cleanup of the calling convention.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
