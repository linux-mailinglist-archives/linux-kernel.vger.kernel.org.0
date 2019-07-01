Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01EE63CB82
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 14:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfFKM3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 08:29:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41206 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfFKM3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 08:29:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id m30so6839028pff.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 05:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y7gj05j+fTkifIRrdspgMrrd6G03saWrwNWynfBgS0U=;
        b=q44jIWreO5gdxzKinRevyVBXJSZQf8U+XKtuF2X+lzP726yGNOhXZCwF57PB5EMk2+
         3glGSCjLduh3nhIIVEzbXq/3LxETJr0vwhLBFpXPg1uM6vpyd9iR6/JFPDsXKB1H0g+W
         FoBB88T3IZZrFcKKcrwIoYX7D9lToHjdaWGEXFfmd9FxK69PRvptwMSUl3rdYgG+Kvoi
         O5oZlBdovnhg3TuqK6vS/1QVpw8QUgTpGAFVCutWvhjkRHiRSn8uARrmFM/5opytIhtt
         IlNBfi0I1q4bDDpZkAMPY1x2fWQzNTPwIKyM+rLYyeZal96gQSvR+viOZ1me5cB6P24F
         TEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y7gj05j+fTkifIRrdspgMrrd6G03saWrwNWynfBgS0U=;
        b=BqHPu3TuqvD9tBjNHttW+Ltu5SL3zgujjaMlFXX+iDyOW1pc9onlh3lG1ox3ZvTwL6
         6w8TRI0K92JBgKap3Wd14xA6biORajAq4Hgu19Rc4pq0+pXyXK0lCLtaC7K5h3JIJxAr
         UP7oasxOS8uOKcxl3QU8lW2wk/yARDulKaPaWaMhBSotgxlbgYUZo/sHasBNPji1wHoQ
         Wdf4GaN17rKsgbDUDMZVBR/Y0685mlIlIAcEj77ozOtkg43zcBQ4BOLeuB7DB9atFSOc
         bibfrVzDUrUP4NCzjWxi+FX+NMrTFWG9bnVU2e8ol5QSH/eE/HejnEigSx91AdZYdpuD
         Y7Rg==
X-Gm-Message-State: APjAAAXQ+QRXZl0BVCEqF31F02q3W3G5Luxdfh7kXXuGr7CNzYAEzyST
        ESaSZix5uuSEC0ERDVAB+fNpnDk=
X-Google-Smtp-Source: APXvYqxZv5u+6uxczWx/QpkRi7je6l/4vwiWO4NDGzDjaiGi1t7F3+s06xKpxFhSxyYobjjdIv03zQ==
X-Received: by 2002:a62:fb18:: with SMTP id x24mr79552145pfm.76.1560256193724;
        Tue, 11 Jun 2019 05:29:53 -0700 (PDT)
Received: from dhcp-128-55.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 24sm13723109pgn.32.2019.06.11.05.29.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 05:29:52 -0700 (PDT)
Date:   Tue, 11 Jun 2019 20:29:35 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 1/2] mm/gup: fix omission of check on FOLL_LONGTERM in
 get_user_pages_fast()
Message-ID: <20190611122935.GA9919@dhcp-128-55.nay.redhat.com>
References: <1559725820-26138-1-git-send-email-kernelfans@gmail.com>
 <20190605144912.f0059d4bd13c563ddb37877e@linux-foundation.org>
 <CAFgQCTur5ReVHm6NHdbD3wWM5WOiAzhfEXdLnBGRdZtf7q1HFw@mail.gmail.com>
 <2b0a65ec-4fb0-430e-3e6a-b713fb5bb28f@nvidia.com>
 <CAFgQCTtS7qOByXBnGzCW-Rm9fiNsVmhQTgqmNU920m77XyAwZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <CAFgQCTtS7qOByXBnGzCW-Rm9fiNsVmhQTgqmNU920m77XyAwZQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 07, 2019 at 02:10:15PM +0800, Pingfan Liu wrote:
> On Fri, Jun 7, 2019 at 5:17 AM John Hubbard <jhubbard@nvidia.com> wrote:
> >
> > On 6/5/19 7:19 PM, Pingfan Liu wrote:
> > > On Thu, Jun 6, 2019 at 5:49 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> > ...
> > >>> --- a/mm/gup.c
> > >>> +++ b/mm/gup.c
> > >>> @@ -2196,6 +2196,26 @@ static int __gup_longterm_unlocked(unsigned long start, int nr_pages,
> > >>>       return ret;
> > >>>  }
> > >>>
> > >>> +#ifdef CONFIG_CMA
> > >>> +static inline int reject_cma_pages(int nr_pinned, struct page **pages)
> > >>> +{
> > >>> +     int i;
> > >>> +
> > >>> +     for (i = 0; i < nr_pinned; i++)
> > >>> +             if (is_migrate_cma_page(pages[i])) {
> > >>> +                     put_user_pages(pages + i, nr_pinned - i);
> > >>> +                     return i;
> > >>> +             }
> > >>> +
> > >>> +     return nr_pinned;
> > >>> +}
> > >>
> > >> There's no point in inlining this.
> > > OK, will drop it in V4.
> > >
> > >>
> > >> The code seems inefficient.  If it encounters a single CMA page it can
> > >> end up discarding a possibly significant number of non-CMA pages.  I
> > > The trick is the page is not be discarded, in fact, they are still be
> > > referrenced by pte. We just leave the slow path to pick up the non-CMA
> > > pages again.
> > >
> > >> guess that doesn't matter much, as get_user_pages(FOLL_LONGTERM) is
> > >> rare.  But could we avoid this (and the second pass across pages[]) by
> > >> checking for a CMA page within gup_pte_range()?
> > > It will spread the same logic to hugetlb pte and normal pte. And no
> > > improvement in performance due to slow path. So I think maybe it is
> > > not worth.
> > >
> > >>
> >
> > I think the concern is: for the successful gup_fast case with no CMA
> > pages, this patch is adding another complete loop through all the
> > pages. In the fast case.
> >
> > If the check were instead done as part of the gup_pte_range(), then
> > it would be a little more efficient for that case.
> >
> > As for whether it's worth it, *probably* this is too small an effect to measure.
> > But in order to attempt a measurement: running fio (https://github.com/axboe/fio)
> > with O_DIRECT on an NVMe drive, might shed some light. Here's an fio.conf file
> > that Jan Kara and Tom Talpey helped me come up with, for related testing:
> >
> > [reader]
> > direct=1
> > ioengine=libaio
> > blocksize=4096
> > size=1g
> > numjobs=1
> > rw=read
> > iodepth=64
> >
Unable to get a NVME device to have a test. And when testing fio on the
tranditional disk, I got the error "fio: engine libaio not loadable
fio: failed to load engine
fio: file:ioengines.c:89, func=dlopen, error=libaio: cannot open shared object file: No such file or directory"

But I found a test case which can be slightly adjusted to met the aim.
It is tools/testing/selftests/vm/gup_benchmark.c

Test enviroment:
  MemTotal:       264079324 kB
  MemFree:        262306788 kB
  CmaTotal:              0 kB
  CmaFree:               0 kB
  on AMD EPYC 7601

Test command:
  gup_benchmark -r 100 -n 64
  gup_benchmark -r 100 -n 64 -l
where -r stands for repeat times, -n is nr_pages param for
get_user_pages_fast(), -l is a new option to test FOLL_LONGTERM in fast
path, see a patch at the tail.

Test result:
w/o     477.800000
w/o-l   481.070000
a       481.800000
a-l     640.410000
b       466.240000  (question a: b outperforms w/o ?)
b-l     529.740000

Where w/o is baseline without any patch using v5.2-rc2, a is this series, b
does the check in gup_pte_range(). '-l' means FOLL_LONGTERM.

I am suprised that b-l has about 17% improvement than a. (640.41 -529.74)/640.41
As for "question a: b outperforms w/o ?", I can not figure out why, maybe it can be
considered as variance.

Based on the above result, I think it is better to do the check inside
gup_pte_range().

Any comment?

Thanks,


> Yeah, agreed. Data is more persuasive. Thanks for your suggestion. I
> will try to bring out the result.
> 
> Thanks,
>   Pingfan
> 


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="gup_pte_range_check.patch"

---
Patch to do check inside gup_pte_range()

diff --git a/mm/gup.c b/mm/gup.c
index 2ce3091..ba213a0 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1757,6 +1757,10 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
 		page = pte_page(pte);
 
+		if (unlikely(flags & FOLL_LONGTERM) &&
+			is_migrate_cma_page(page))
+				goto pte_unmap;
+
 		head = try_get_compound_head(page, 1);
 		if (!head)
 			goto pte_unmap;
@@ -1900,6 +1904,12 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 		refs++;
 	} while (addr += PAGE_SIZE, addr != end);
 
+	if (unlikely(flags & FOLL_LONGTERM) &&
+		is_migrate_cma_page(page)) {
+		*nr -= refs;
+		return 0;
+	}
+
 	head = try_get_compound_head(pmd_page(orig), refs);
 	if (!head) {
 		*nr -= refs;
@@ -1941,6 +1951,12 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 		refs++;
 	} while (addr += PAGE_SIZE, addr != end);
 
+	if (unlikely(flags & FOLL_LONGTERM) &&
+		is_migrate_cma_page(page)) {
+		*nr -= refs;
+		return 0;
+	}
+
 	head = try_get_compound_head(pud_page(orig), refs);
 	if (!head) {
 		*nr -= refs;
@@ -1978,6 +1994,12 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 		refs++;
 	} while (addr += PAGE_SIZE, addr != end);
 
+	if (unlikely(flags & FOLL_LONGTERM) &&
+		is_migrate_cma_page(page)) {
+		*nr -= refs;
+		return 0;
+	}
+
 	head = try_get_compound_head(pgd_page(orig), refs);
 	if (!head) {
 		*nr -= refs;

--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mm-gup-introduce-LONGTERM_BENCHMARK-in-fast-path.patch"

---
Patch for testing

diff --git a/mm/gup_benchmark.c b/mm/gup_benchmark.c
index 7dd602d..61dec5f 100644
--- a/mm/gup_benchmark.c
+++ b/mm/gup_benchmark.c
@@ -6,8 +6,9 @@
 #include <linux/debugfs.h>
 
 #define GUP_FAST_BENCHMARK	_IOWR('g', 1, struct gup_benchmark)
-#define GUP_LONGTERM_BENCHMARK	_IOWR('g', 2, struct gup_benchmark)
-#define GUP_BENCHMARK		_IOWR('g', 3, struct gup_benchmark)
+#define GUP_FAST_LONGTERM_BENCHMARK	_IOWR('g', 2, struct gup_benchmark)
+#define GUP_LONGTERM_BENCHMARK	_IOWR('g', 3, struct gup_benchmark)
+#define GUP_BENCHMARK		_IOWR('g', 4, struct gup_benchmark)
 
 struct gup_benchmark {
 	__u64 get_delta_usec;
@@ -53,6 +54,11 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
 			nr = get_user_pages_fast(addr, nr, gup->flags & 1,
 						 pages + i);
 			break;
+		case GUP_FAST_LONGTERM_BENCHMARK:
+			nr = get_user_pages_fast(addr, nr,
+						 (gup->flags & 1) | FOLL_LONGTERM,
+						 pages + i);
+			break;
 		case GUP_LONGTERM_BENCHMARK:
 			nr = get_user_pages(addr, nr,
 					    (gup->flags & 1) | FOLL_LONGTERM,
@@ -96,6 +102,7 @@ static long gup_benchmark_ioctl(struct file *filep, unsigned int cmd,
 
 	switch (cmd) {
 	case GUP_FAST_BENCHMARK:
+	case GUP_FAST_LONGTERM_BENCHMARK:
 	case GUP_LONGTERM_BENCHMARK:
 	case GUP_BENCHMARK:
 		break;
diff --git a/tools/testing/selftests/vm/gup_benchmark.c b/tools/testing/selftests/vm/gup_benchmark.c
index c0534e2..ade8acb 100644
--- a/tools/testing/selftests/vm/gup_benchmark.c
+++ b/tools/testing/selftests/vm/gup_benchmark.c
@@ -15,8 +15,9 @@
 #define PAGE_SIZE sysconf(_SC_PAGESIZE)
 
 #define GUP_FAST_BENCHMARK	_IOWR('g', 1, struct gup_benchmark)
-#define GUP_LONGTERM_BENCHMARK	_IOWR('g', 2, struct gup_benchmark)
-#define GUP_BENCHMARK		_IOWR('g', 3, struct gup_benchmark)
+#define GUP_FAST_LONGTERM_BENCHMARK	_IOWR('g', 2, struct gup_benchmark)
+#define GUP_LONGTERM_BENCHMARK	_IOWR('g', 3, struct gup_benchmark)
+#define GUP_BENCHMARK		_IOWR('g', 4, struct gup_benchmark)
 
 struct gup_benchmark {
 	__u64 get_delta_usec;
@@ -37,7 +38,7 @@ int main(int argc, char **argv)
 	char *file = "/dev/zero";
 	char *p;
 
-	while ((opt = getopt(argc, argv, "m:r:n:f:tTLUSH")) != -1) {
+	while ((opt = getopt(argc, argv, "m:r:n:f:tTlLUSH")) != -1) {
 		switch (opt) {
 		case 'm':
 			size = atoi(optarg) * MB;
@@ -54,6 +55,9 @@ int main(int argc, char **argv)
 		case 'T':
 			thp = 0;
 			break;
+		case 'l':
+			cmd = GUP_FAST_LONGTERM_BENCHMARK;
+			break;
 		case 'L':
 			cmd = GUP_LONGTERM_BENCHMARK;
 			break;
-- 
2.7.5


--W/nzBZO5zC0uMSeA--
