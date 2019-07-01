Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E04350A09
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 13:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbfFXLqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 07:46:07 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43819 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfFXLqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 07:46:07 -0400
Received: by mail-io1-f68.google.com with SMTP id k20so808768ios.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 04:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xjyC1woOCk6QoSm3J7dmvFYHQ65jTUd0WwHup6buLdA=;
        b=c/f5f/Ezq3qoosgf0iqgNPPcbIYUobo1qpnTyfBhKYcJlD4mJXs5nY2Fk/i59Ypocr
         oQFMXxWneqxFDJ3UlvFYhCbMzeaD0RwSQIePTpoE5ZabZmOc1ubkk2xy9XaV16k1mWpG
         uhW5uB/qv024uac34FQoadj7MRiYeO6H4o0MhAbsqH09bTa0F0KQpiaQXFET3z1MtT/d
         Oju2FzIw+5E6M8TP+z8WD0t/uffACrjPTXLSo1MYDaEtdGk+3Hm/PaRXl5EZWsdpLsO8
         3k6Ap14uTP2sPWcBeX+6gjzk8vGBecUobCh1G6MaumuEeR7EXuz9p88d7wEt2SPezw97
         FmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xjyC1woOCk6QoSm3J7dmvFYHQ65jTUd0WwHup6buLdA=;
        b=nx8xKt/Z/0zs4S5vR7na6qB1B0GY0jTnlslc9Uh3cI6DgPAw+RQlioZUxCOjm2kitr
         GLIukitlsyfiWoK84YKFnTnUI5+AUlhCOOjJg4XVKIAtovUz4J1hYvyjDqhmbte0rC02
         AsL3ZQYt1e1RHtxT3dGgD17XeBkZPxNii2cw6l1XgmYhAfaH4vRspfDozCHESYUFRRPT
         V3gmeOsWHfBiC/jNNxkYDEc/0vJghi+MxwnK/OxIufArvETi22tzRJz5GTus3W2omf8Z
         Y4FNI+YEIqLnu0pvGwvLSn6keZo/IUR2kwng3mvZzHcx6qCU/UayVj8gpTNW5crGzzwq
         ltSg==
X-Gm-Message-State: APjAAAVGn7QibZLfa+sJgtAe8w1nccnaBb4r76O2aAdCYtKi9IDBPuzM
        /QEul7oSSg2Yid9PnL7K4jOXIS2XG6wlGNAlhgUFsA==
X-Google-Smtp-Source: APXvYqx6HEUoIqfS52gzn8y0KrQsf7q1x4CiJ/9P8zJ9QW7nroLu9eqcvYa+03rEne+EbXrDQjNrpkGRT2bTR5Pv1mU=
X-Received: by 2002:a6b:4101:: with SMTP id n1mr14151102ioa.138.1561376765960;
 Mon, 24 Jun 2019 04:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190624110532.41065-1-elver@google.com>
In-Reply-To: <20190624110532.41065-1-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 24 Jun 2019 13:45:53 +0200
Message-ID: <CACT4Y+ZP4gkLh5zbwSLzV+ZwJCq_zSrsaQE+1Y94iU0JJzJNqw@mail.gmail.com>
Subject: Re: [PATCH] mm/kasan: Add shadow memory validation in ksize()
To:     Marco Elver <elver@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 1:05 PM Marco Elver <elver@google.com> wrote:
>
> ksize() has been unconditionally unpoisoning the whole shadow memory region
> associated with an allocation. This can lead to various undetected bugs,
> for example, double-kzfree().
>
> kzfree() uses ksize() to determine the actual allocation size, and
> subsequently zeroes the memory. Since ksize() used to just unpoison the
> whole shadow memory region, no invalid free was detected.
>
> This patch addresses this as follows:
>
> 1. For each SLAB and SLUB allocators: add a check in ksize() that the
>    pointed to object's shadow memory is valid, and only then unpoison
>    the memory region.
>
> 2. Update kasan_unpoison_slab() to explicitly unpoison the shadow memory
>    region using the size obtained from ksize(); it is possible that
>    double-unpoison can occur if the shadow was already valid, however,
>    this should not be the general case.
>
> Tested:
> 1. With SLAB allocator: a) normal boot without warnings; b) verified the
>    added double-kzfree() is detected.
> 2. With SLUB allocator: a) normal boot without warnings; b) verified the
>    added double-kzfree() is detected.
>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199359
> Signed-off-by: Marco Elver <elver@google.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: kasan-dev@googlegroups.com
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  include/linux/kasan.h | 20 +++++++++++++++++++-
>  lib/test_kasan.c      | 17 +++++++++++++++++
>  mm/kasan/common.c     | 15 ++++++++++++---
>  mm/slab.c             | 12 ++++++++----
>  mm/slub.c             | 11 +++++++----
>  5 files changed, 63 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index b40ea104dd36..9778a68fb5cf 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -63,6 +63,14 @@ void * __must_check kasan_krealloc(const void *object, size_t new_size,
>
>  void * __must_check kasan_slab_alloc(struct kmem_cache *s, void *object,
>                                         gfp_t flags);
> +
> +/**
> + * kasan_shadow_invalid - Check if shadow memory of object is invalid.
> + * @object: The pointed to object; the object pointer may be tagged.
> + * @return: true if shadow is invalid, false if valid.
> + */
> +bool kasan_shadow_invalid(const void *object);
> +
>  bool kasan_slab_free(struct kmem_cache *s, void *object, unsigned long ip);
>
>  struct kasan_cache {
> @@ -77,7 +85,11 @@ int kasan_add_zero_shadow(void *start, unsigned long size);
>  void kasan_remove_zero_shadow(void *start, unsigned long size);
>
>  size_t ksize(const void *);
> -static inline void kasan_unpoison_slab(const void *ptr) { ksize(ptr); }
> +static inline void kasan_unpoison_slab(const void *ptr)
> +{
> +       /* Force unpoison: ksize() only unpoisons if shadow of ptr is valid. */
> +       kasan_unpoison_shadow(ptr, ksize(ptr));
> +}
>  size_t kasan_metadata_size(struct kmem_cache *cache);
>
>  bool kasan_save_enable_multi_shot(void);
> @@ -133,6 +145,12 @@ static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
>  {
>         return object;
>  }
> +
> +static inline bool kasan_shadow_invalid(const void *object)
> +{
> +       return false;
> +}
> +
>  static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
>                                    unsigned long ip)
>  {
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 7de2702621dc..9b710bfa84da 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -623,6 +623,22 @@ static noinline void __init kasan_strings(void)
>         strnlen(ptr, 1);
>  }
>
> +static noinline void __init kmalloc_pagealloc_double_kzfree(void)
> +{
> +       char *ptr;
> +       size_t size = 16;
> +
> +       pr_info("kmalloc pagealloc allocation: double-free (kzfree)\n");

This does not have anything to do with pagealloc, right?
If so, remove pagealloc here and in the function name. kzfree also
implies kmalloc, so this could be just double_kzfree().

> +       ptr = kmalloc(size, GFP_KERNEL);
> +       if (!ptr) {
> +               pr_err("Allocation failed\n");
> +               return;
> +       }
> +
> +       kzfree(ptr);
> +       kzfree(ptr);
> +}
> +
>  static int __init kmalloc_tests_init(void)
>  {
>         /*
> @@ -664,6 +680,7 @@ static int __init kmalloc_tests_init(void)
>         kasan_memchr();
>         kasan_memcmp();
>         kasan_strings();
> +       kmalloc_pagealloc_double_kzfree();
>
>         kasan_restore_multi_shot(multishot);
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 242fdc01aaa9..357e02e73163 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -413,10 +413,20 @@ static inline bool shadow_invalid(u8 tag, s8 shadow_byte)
>                 return tag != (u8)shadow_byte;
>  }
>
> +bool kasan_shadow_invalid(const void *object)
> +{
> +       u8 tag = get_tag(object);
> +       s8 shadow_byte;
> +
> +       object = reset_tag(object);
> +
> +       shadow_byte = READ_ONCE(*(s8 *)kasan_mem_to_shadow(object));
> +       return shadow_invalid(tag, shadow_byte);
> +}
> +
>  static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
>                               unsigned long ip, bool quarantine)
>  {
> -       s8 shadow_byte;
>         u8 tag;
>         void *tagged_object;
>         unsigned long rounded_up_size;
> @@ -435,8 +445,7 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
>         if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
>                 return false;
>
> -       shadow_byte = READ_ONCE(*(s8 *)kasan_mem_to_shadow(object));
> -       if (shadow_invalid(tag, shadow_byte)) {
> +       if (kasan_shadow_invalid(tagged_object)) {
>                 kasan_report_invalid_free(tagged_object, ip);
>                 return true;
>         }
> diff --git a/mm/slab.c b/mm/slab.c
> index f7117ad9b3a3..3595348c401b 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -4226,10 +4226,14 @@ size_t ksize(const void *objp)
>                 return 0;
>
>         size = virt_to_cache(objp)->object_size;
> -       /* We assume that ksize callers could use the whole allocated area,
> -        * so we need to unpoison this area.
> -        */
> -       kasan_unpoison_shadow(objp, size);
> +
> +       if (!kasan_shadow_invalid(objp)) {
> +               /*
> +                * We assume that ksize callers could use the whole allocated
> +                * area, so we need to unpoison this area.
> +                */
> +               kasan_unpoison_shadow(objp, size);
> +       }
>
>         return size;
>  }
> diff --git a/mm/slub.c b/mm/slub.c
> index cd04dbd2b5d0..28231d30358e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3921,10 +3921,13 @@ static size_t __ksize(const void *object)
>  size_t ksize(const void *object)
>  {
>         size_t size = __ksize(object);
> -       /* We assume that ksize callers could use whole allocated area,
> -        * so we need to unpoison this area.
> -        */
> -       kasan_unpoison_shadow(object, size);
> +       if (!kasan_shadow_invalid(object)) {


I am thinking if we should call kasan_check_read(object, 1) here...
This would not produce a double-free error (use-after-free read
instead), but conceptually why we would allow calling ksize on freed
objects? But more importantly, we just skip unpoisoning shadow, but we
still smash the object contents on the second kzfree, right? This
means that the heap is corrupted after running the tests. As far as I
remember we avoided corrupting heap in tests and in particular a
normal double-free does not. As of now we've smashed the quarantine
link, but if we move the free metadata back into the object (e.g. to
resolve https://bugzilla.kernel.org/show_bug.cgi?id=198437) we also
smash free metadata before we print the double free report (at the
very least we will fail to print free stack, and crash at worst).

Doing kasan_check_read() in ksize() will cause a report _before_ we
smashed the object at the cost of an imprecise report title.
And fixing all of the issues will require changing kzfree I think.


> +               /*
> +                * We assume that ksize callers could use whole allocated area,
> +                * so we need to unpoison this area.
> +                */
> +               kasan_unpoison_shadow(object, size);
> +       }
>         return size;
>  }
>  EXPORT_SYMBOL(ksize);
> --
> 2.22.0.410.gd8fdbe21b5-goog
>
