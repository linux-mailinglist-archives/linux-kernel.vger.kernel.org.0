Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE6A1E3C60
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 21:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437649AbfJXTuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 15:50:24 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:59731 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437411AbfJXTuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 15:50:23 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B4877891AA;
        Fri, 25 Oct 2019 08:50:18 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1571946618;
        bh=/4YLyWGkU9rDMzrgmxiRkYG+Wye5vaf+QyGNMk6rhig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KA4/TSVcbKlSDRy2Qx3XafjHtS+9GLTgkHbeMwNdEk86m0SkF1vHBwYlQsYK02FDO
         VBMq8xscrKWjubFqsuD2d9V6VyXBLmbuATsEHdJxy3Dq6gdfqyXnHrjglfbUAs1YkJ
         OALYJ24vNuhGbUfFRMdv2gw+V3LqN6rcmtp4CM+hAIsXR3/rCY5gPGFtLEpQzJvshX
         NgeFeh3TEo2tsnOuogZEaBICN2e1AC+OGgGxGgSyzORvJVQbJXNUPXxoUGgvpVMPWv
         TtnbYVpbHROwvXbdqELqftF/rEnHEuGm4eHApcnfJvBwHqX3O+ZEbc+nsR95rXPESb
         5dBvvAafEj1Ug==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5db200790002>; Fri, 25 Oct 2019 08:50:17 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id C50CD13EEFC;
        Fri, 25 Oct 2019 08:50:22 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 912FA28005C; Fri, 25 Oct 2019 08:50:18 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     corbet@lwn.net, rppt@linux.ibm.com, willy@infradead.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 2/3] docs/core-api: memory-allocation: remove uses of c:func:
Date:   Fri, 25 Oct 2019 08:50:15 +1300
Message-Id: <20191024195016.11054-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024195016.11054-1-chris.packham@alliedtelesis.co.nz>
References: <20191024195016.11054-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are no longer needed as the documentation build will automatically
add the cross references.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    It should be noted that kvmalloc() and kmem_cache_destroy() lack a
    kerneldoc header, a side-effect of this change is that the :c:func:
    fallback of making them bold is lost. This is probably best fixed by
    adding a kerneldoc header to their source.
   =20
    Changes in v2:
    - new

 Documentation/core-api/memory-allocation.rst | 49 +++++++++-----------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/Documentation/core-api/memory-allocation.rst b/Documentation=
/core-api/memory-allocation.rst
index dcf851b4520f..e47d48655085 100644
--- a/Documentation/core-api/memory-allocation.rst
+++ b/Documentation/core-api/memory-allocation.rst
@@ -88,10 +88,10 @@ Selecting memory allocator
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
=20
 The most straightforward way to allocate memory is to use a function
-from the :c:func:`kmalloc` family. And, to be on the safe side it's
-best to use routines that set memory to zero, like
-:c:func:`kzalloc`. If you need to allocate memory for an array, there
-are :c:func:`kmalloc_array` and :c:func:`kcalloc` helpers.
+from the kmalloc() family. And, to be on the safe side it's best to use
+routines that set memory to zero, like kzalloc(). If you need to
+allocate memory for an array, there are kmalloc_array() and kcalloc()
+helpers.
=20
 The maximal size of a chunk that can be allocated with `kmalloc` is
 limited. The actual limit depends on the hardware and the kernel
@@ -102,29 +102,26 @@ The address of a chunk allocated with `kmalloc` is =
aligned to at least
 ARCH_KMALLOC_MINALIGN bytes.  For sizes which are a power of two, the
 alignment is also guaranteed to be at least the respective size.
=20
-For large allocations you can use :c:func:`vmalloc` and
-:c:func:`vzalloc`, or directly request pages from the page
-allocator. The memory allocated by `vmalloc` and related functions is
-not physically contiguous.
+For large allocations you can use vmalloc() and vzalloc(), or directly
+request pages from the page allocator. The memory allocated by `vmalloc`
+and related functions is not physically contiguous.
=20
 If you are not sure whether the allocation size is too large for
-`kmalloc`, it is possible to use :c:func:`kvmalloc` and its
-derivatives. It will try to allocate memory with `kmalloc` and if the
-allocation fails it will be retried with `vmalloc`. There are
-restrictions on which GFP flags can be used with `kvmalloc`; please
-see :c:func:`kvmalloc_node` reference documentation. Note that
-`kvmalloc` may return memory that is not physically contiguous.
+`kmalloc`, it is possible to use kvmalloc() and its derivatives. It will
+try to allocate memory with `kmalloc` and if the allocation fails it
+will be retried with `vmalloc`. There are restrictions on which GFP
+flags can be used with `kvmalloc`; please see kvmalloc_node() reference
+documentation. Note that `kvmalloc` may return memory that is not
+physically contiguous.
=20
 If you need to allocate many identical objects you can use the slab
-cache allocator. The cache should be set up with
-:c:func:`kmem_cache_create` or :c:func:`kmem_cache_create_usercopy`
-before it can be used. The second function should be used if a part of
-the cache might be copied to the userspace.  After the cache is
-created :c:func:`kmem_cache_alloc` and its convenience wrappers can
-allocate memory from that cache.
-
-When the allocated memory is no longer needed it must be freed. You
-can use :c:func:`kvfree` for the memory allocated with `kmalloc`,
-`vmalloc` and `kvmalloc`. The slab caches should be freed with
-:c:func:`kmem_cache_free`. And don't forget to destroy the cache with
-:c:func:`kmem_cache_destroy`.
+cache allocator. The cache should be set up with kmem_cache_create() or
+kmem_cache_create_usercopy() before it can be used. The second function
+should be used if a part of the cache might be copied to the userspace.
+After the cache is created kmem_cache_alloc() and its convenience
+wrappers can allocate memory from that cache.
+
+When the allocated memory is no longer needed it must be freed. You can
+use kvfree() for the memory allocated with `kmalloc`, `vmalloc` and
+`kvmalloc`. The slab caches should be freed with kmem_cache_free(). And
+don't forget to destroy the cache with kmem_cache_destroy().
--=20
2.23.0

