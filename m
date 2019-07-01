Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B86194AD92
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 23:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbfFRV4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 17:56:22 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38802 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbfFRV4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 17:56:22 -0400
Received: by mail-ot1-f67.google.com with SMTP id d17so17106131oth.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 14:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qtt1rZDPVuhTzJb0IIpSWujWs31YenUk5EJQ2S55LAQ=;
        b=o9IxJYZ8kwnBSB9PQOv7jn58lvvPn/adQGqPIytHTR0TqJoqUCra3YWwiCY4h3AlYH
         xiZVw6gaMWJJUNrNFzyv9a4lveZ5YBGgHA+j//loikNHE8IV1EjpOlRBLVY2vYvSogUU
         0HRgDKcziETxicByU2DKj1YOyOdBmwys4mY9nB3vVUzv2wlkAnmWoPopS5DE1HODt0hE
         5HVGkkpPJqTlus0NxOgdUJsZNLwRI5Ms+DrGaIK6OcLsA9l+7fwVwNt+8+nXzMaUjztq
         4e50KhU65baxSh5uGc0V1VK+yxUUi7tMoUQttN0dHnsHn1Nd/1FiB0CnMXZ3aGU2Sbu1
         pGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qtt1rZDPVuhTzJb0IIpSWujWs31YenUk5EJQ2S55LAQ=;
        b=dnr0GS0kIOXYmbpUM0LKj0w/ZAgLqVGc7mdt9BMxN0eTv/YVgWmnD/sLC1sf6A5963
         23YBDqOpcnYC+2ROMJQmDlTfM+kGMVu/oyfgwwTvhq3unxfbD9OD5LRg61xD/INNZRRm
         NtYy0sPL0IH0DdKPs+Kio14MQK5/g7739Mstpb/X93WasQs7G2pcReyNS9QW9KWIlk3O
         029tR3kZOYEs4o0XDQP+f8Q6b4TeSSSAOzrTNubptOLjejHvC8WY+91lXxW9174oYXnk
         Od5PTi4w3vvQdoRmiBFnGnT90csfkpED24bW2pDNPZVJ73mhGvmuyoUeXgST4uJ/NxL2
         GWKg==
X-Gm-Message-State: APjAAAVcDCzyHreiytS04S4CPnNZb2xX/ddMI2ssfdu20IETeXDqWrec
        Snzz4XT9rT6ppi1JMsyL12gCm4u83/Vomh18CPj66w==
X-Google-Smtp-Source: APXvYqzKPs+IsgHm4GdmBY9YxJvdl69JbeHvSvRruLq+veyQ9aHjXa2JJYwL1cAEYPsSnqgORpvbEL1TnIVnaDe8a/c=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr1219251otn.247.1560894981583;
 Tue, 18 Jun 2019 14:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155977187407.2443951.16503493275720588454.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190616131123.fkjs4kyg32aryjq6@master>
In-Reply-To: <20190616131123.fkjs4kyg32aryjq6@master>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 18 Jun 2019 14:56:09 -0700
Message-ID: <CAPcyv4hw2W3=CkrUmWtvu3cAdo3GLRhG0=G_RO7xQBugNB2htA@mail.gmail.com>
Subject: Re: [PATCH v9 01/12] mm/sparsemem: Introduce struct mem_section_usage
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 16, 2019 at 6:11 AM Wei Yang <richard.weiyang@gmail.com> wrote:
>
> On Wed, Jun 05, 2019 at 02:57:54PM -0700, Dan Williams wrote:
> >Towards enabling memory hotplug to track partial population of a
> >section, introduce 'struct mem_section_usage'.
> >
> >A pointer to a 'struct mem_section_usage' instance replaces the existing
> >pointer to a 'pageblock_flags' bitmap. Effectively it adds one more
> >'unsigned long' beyond the 'pageblock_flags' (usemap) allocation to
> >house a new 'subsection_map' bitmap.  The new bitmap enables the memory
> >hot{plug,remove} implementation to act on incremental sub-divisions of a
> >section.
> >
> >The default SUBSECTION_SHIFT is chosen to keep the 'subsection_map' no
> >larger than a single 'unsigned long' on the major architectures.
> >Alternatively an architecture can define ARCH_SUBSECTION_SHIFT to
> >override the default PMD_SHIFT. Note that PowerPC needs to use
> >ARCH_SUBSECTION_SHIFT to workaround PMD_SHIFT being a non-constant
> >expression on PowerPC.
> >
> >The primary motivation for this functionality is to support platforms
> >that mix "System RAM" and "Persistent Memory" within a single section,
> >or multiple PMEM ranges with different mapping lifetimes within a single
> >section. The section restriction for hotplug has caused an ongoing saga
> >of hacks and bugs for devm_memremap_pages() users.
> >
> >Beyond the fixups to teach existing paths how to retrieve the 'usemap'
> >from a section, and updates to usemap allocation path, there are no
> >expected behavior changes.
> >
> >Cc: Michal Hocko <mhocko@suse.com>
> >Cc: Vlastimil Babka <vbabka@suse.cz>
> >Cc: Logan Gunthorpe <logang@deltatee.com>
> >Cc: Oscar Salvador <osalvador@suse.de>
> >Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> >Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >Cc: Paul Mackerras <paulus@samba.org>
> >Cc: Michael Ellerman <mpe@ellerman.id.au>
> >Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >---
> > arch/powerpc/include/asm/sparsemem.h |    3 +
> > include/linux/mmzone.h               |   48 +++++++++++++++++++-
> > mm/memory_hotplug.c                  |   18 ++++----
> > mm/page_alloc.c                      |    2 -
> > mm/sparse.c                          |   81 +++++++++++++++++-----------------
> > 5 files changed, 99 insertions(+), 53 deletions(-)
> >
> >diff --git a/arch/powerpc/include/asm/sparsemem.h b/arch/powerpc/include/asm/sparsemem.h
> >index 3192d454a733..1aa3c9303bf8 100644
> >--- a/arch/powerpc/include/asm/sparsemem.h
> >+++ b/arch/powerpc/include/asm/sparsemem.h
> >@@ -10,6 +10,9 @@
> >  */
> > #define SECTION_SIZE_BITS       24
> >
> >+/* Reflect the largest possible PMD-size as the subsection-size constant */
> >+#define ARCH_SUBSECTION_SHIFT 24
> >+
> > #endif /* CONFIG_SPARSEMEM */
> >
> > #ifdef CONFIG_MEMORY_HOTPLUG
> >diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> >index 427b79c39b3c..ac163f2f274f 100644
> >--- a/include/linux/mmzone.h
> >+++ b/include/linux/mmzone.h
> >@@ -1161,6 +1161,44 @@ static inline unsigned long section_nr_to_pfn(unsigned long sec)
> > #define SECTION_ALIGN_UP(pfn) (((pfn) + PAGES_PER_SECTION - 1) & PAGE_SECTION_MASK)
> > #define SECTION_ALIGN_DOWN(pfn)       ((pfn) & PAGE_SECTION_MASK)
> >
> >+/*
> >+ * SUBSECTION_SHIFT must be constant since it is used to declare
> >+ * subsection_map and related bitmaps without triggering the generation
> >+ * of variable-length arrays. The most natural size for a subsection is
> >+ * a PMD-page. For architectures that do not have a constant PMD-size
> >+ * ARCH_SUBSECTION_SHIFT can be set to a constant max size, or otherwise
> >+ * fallback to 2MB.
> >+ */
> >+#if defined(ARCH_SUBSECTION_SHIFT)
> >+#define SUBSECTION_SHIFT (ARCH_SUBSECTION_SHIFT)
> >+#elif defined(PMD_SHIFT)
> >+#define SUBSECTION_SHIFT (PMD_SHIFT)
> >+#else
> >+/*
> >+ * Memory hotplug enabled platforms avoid this default because they
> >+ * either define ARCH_SUBSECTION_SHIFT, or PMD_SHIFT is a constant, but
> >+ * this is kept as a backstop to allow compilation on
> >+ * !ARCH_ENABLE_MEMORY_HOTPLUG archs.
> >+ */
> >+#define SUBSECTION_SHIFT 21
> >+#endif
> >+
> >+#define PFN_SUBSECTION_SHIFT (SUBSECTION_SHIFT - PAGE_SHIFT)
> >+#define PAGES_PER_SUBSECTION (1UL << PFN_SUBSECTION_SHIFT)
> >+#define PAGE_SUBSECTION_MASK ((~(PAGES_PER_SUBSECTION-1)))
>
> One pair of brackets could be removed, IMHO.

Sure.

>
> >+
> >+#if SUBSECTION_SHIFT > SECTION_SIZE_BITS
> >+#error Subsection size exceeds section size
> >+#else
> >+#define SUBSECTIONS_PER_SECTION (1UL << (SECTION_SIZE_BITS - SUBSECTION_SHIFT))
> >+#endif
> >+
> >+struct mem_section_usage {
> >+      DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION);
> >+      /* See declaration of similar field in struct zone */
> >+      unsigned long pageblock_flags[0];
> >+};
> >+
> > struct page;
> > struct page_ext;
> > struct mem_section {
> >@@ -1178,8 +1216,7 @@ struct mem_section {
> >        */
> >       unsigned long section_mem_map;
> >
> >-      /* See declaration of similar field in struct zone */
> >-      unsigned long *pageblock_flags;
> >+      struct mem_section_usage *usage;
> > #ifdef CONFIG_PAGE_EXTENSION
> >       /*
> >        * If SPARSEMEM, pgdat doesn't have page_ext pointer. We use
> >@@ -1210,6 +1247,11 @@ extern struct mem_section **mem_section;
> > extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
> > #endif
> >
> >+static inline unsigned long *section_to_usemap(struct mem_section *ms)
> >+{
> >+      return ms->usage->pageblock_flags;
>
> Do we need to consider the case when ms->usage is NULL?

No, this routine safely assumes it is always set.
