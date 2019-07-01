Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAA5458A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 20:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfF0Sl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 14:41:29 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34687 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0Sl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:41:29 -0400
Received: by mail-qk1-f195.google.com with SMTP id t8so2652847qkt.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 11:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zp2l4O4LWB1oYN3F7c8FUspudG1FPkSVquIdBgKKNr8=;
        b=UDng4QJMv1LWzYnKCztVQrCNsQ7Xm4otaD1vwxegRokBDPjtcWCzhLj1b0tPvoH+5G
         e/wZZXygpBylg98sPuyuv5mbBgHjHPIhEGIY/4sXfGrI6hEsUakCdci1fKEcwYL664EC
         Ltd0eFTtccFg22S/AnCRO2+x3kM7m3mE76PbjYGJA3XX88l8d1RfTL8naCRYhwRRt0hN
         kyZi2ZsrwRjkdf7keArGTkmIEQdAUv5kF+i4bxZDaZkTJbnUfBtuvb8kgZ4DSAN0ClWA
         9uUXZkU+VDLLI8Wljm/1SQ0dpnn2hWHmINCPPoWh84Ec+rb3cevpyvhRbTvWyf7P5pkm
         ioRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zp2l4O4LWB1oYN3F7c8FUspudG1FPkSVquIdBgKKNr8=;
        b=gxp6BK5bbqJ9Zp+L/f8qJEuTfcKDw9pI75dgS/TjBs9VeCr/unHDLsWcQDwLZTsmJA
         ZJfcI5Diof8beSe2I4l1h2v08xldOt5BTafVxX5g3eebVbnJj7RMde37NUY3I2C08xDP
         WNqp9dm7ZyIMHVX5WTUrccJVu3gAg3FA1BQ2k617h2Hemn8Nrwz2CvQriu9dRcPKnmUj
         aAD26ozG4fkZu2xsAiKuQx9TMKC9V64vwR1bjLRlZ4RyhR6VUSH048eSTJvrsjjzkztJ
         FDPVZWLZPPTp+urq4eYsMe3NSQqAKr4MSbIImXpO1owfynarNQaHqqkPZdnCtysVv3X/
         zBhQ==
X-Gm-Message-State: APjAAAWRRvTCQ/SG8DITX34y6kGiFEvWD7d60PE//+FEb4ttes65bj/G
        9jWxA5IUFAir8wgR/kPLmpGrOQ==
X-Google-Smtp-Source: APXvYqzuAHF37eGCzmzOTvKs0gfWaevOeNG3BEuhoGjpmd7NajpcCkq1aEtP0oryKkwjtmcGiGqZAA==
X-Received: by 2002:a05:620a:13b9:: with SMTP id m25mr5020959qki.246.1561660885669;
        Thu, 27 Jun 2019 11:41:25 -0700 (PDT)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id t29sm1418301qtt.42.2019.06.27.11.41.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 11:41:24 -0700 (PDT)
Date:   Thu, 27 Jun 2019 14:41:23 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Kuo-Hsin Yang <vovoy@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Sonny Rao <sonnyrao@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: vmscan: fix not scanning anonymous pages when
 detecting file refaults
Message-ID: <20190627184123.GA11181@cmpxchg.org>
References: <20190619080835.GA68312@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619080835.GA68312@google.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 04:08:35PM +0800, Kuo-Hsin Yang wrote:
> When file refaults are detected and there are many inactive file pages,
> the system never reclaim anonymous pages, the file pages are dropped
> aggressively when there are still a lot of cold anonymous pages and
> system thrashes. This issue impacts the performance of applications with
> large executable, e.g. chrome.
> 
> When file refaults are detected. inactive_list_is_low() may return
> different values depends on the actual_reclaim parameter, the following
> 2 conditions could be satisfied at the same time.
> 
> 1) inactive_list_is_low() returns false in get_scan_count() to trigger
>    scanning file lists only.
> 2) inactive_list_is_low() returns true in shrink_list() to allow
>    scanning active file list.
> 
> In that case vmscan would only scan file lists, and as active file list
> is also scanned, inactive_list_is_low() may keep returning false in
> get_scan_count() until file cache is very low.
> 
> Before commit 2a2e48854d70 ("mm: vmscan: fix IO/refault regression in
> cache workingset transition"), inactive_list_is_low() never returns
> different value in get_scan_count() and shrink_list() in one
> shrink_node_memcg() run. The original design should be that when
> inactive_list_is_low() returns false for file lists, vmscan only scan
> inactive file list. As only inactive file list is scanned,
> inactive_list_is_low() would soon return true.
> 
> This patch makes the return value of inactive_list_is_low() independent
> of actual_reclaim.
> 
> The problem can be reproduced by the following test program.
> 
> ---8<---
> void fallocate_file(const char *filename, off_t size)
> {
> 	struct stat st;
> 	int fd;
> 
> 	if (!stat(filename, &st) && st.st_size >= size)
> 		return;
> 
> 	fd = open(filename, O_WRONLY | O_CREAT, 0600);
> 	if (fd < 0) {
> 		perror("create file");
> 		exit(1);
> 	}
> 	if (posix_fallocate(fd, 0, size)) {
> 		perror("fallocate");
> 		exit(1);
> 	}
> 	close(fd);
> }
> 
> long *alloc_anon(long size)
> {
> 	long *start = malloc(size);
> 	memset(start, 1, size);
> 	return start;
> }
> 
> long access_file(const char *filename, long size, long rounds)
> {
> 	int fd, i;
> 	volatile char *start1, *end1, *start2;
> 	const int page_size = getpagesize();
> 	long sum = 0;
> 
> 	fd = open(filename, O_RDONLY);
> 	if (fd == -1) {
> 		perror("open");
> 		exit(1);
> 	}
> 
> 	/*
> 	 * Some applications, e.g. chrome, use a lot of executable file
> 	 * pages, map some of the pages with PROT_EXEC flag to simulate
> 	 * the behavior.
> 	 */
> 	start1 = mmap(NULL, size / 2, PROT_READ | PROT_EXEC, MAP_SHARED,
> 		      fd, 0);
> 	if (start1 == MAP_FAILED) {
> 		perror("mmap");
> 		exit(1);
> 	}
> 	end1 = start1 + size / 2;
> 
> 	start2 = mmap(NULL, size / 2, PROT_READ, MAP_SHARED, fd, size / 2);
> 	if (start2 == MAP_FAILED) {
> 		perror("mmap");
> 		exit(1);
> 	}
> 
> 	for (i = 0; i < rounds; ++i) {
> 		struct timeval before, after;
> 		volatile char *ptr1 = start1, *ptr2 = start2;
> 		gettimeofday(&before, NULL);
> 		for (; ptr1 < end1; ptr1 += page_size, ptr2 += page_size)
> 			sum += *ptr1 + *ptr2;
> 		gettimeofday(&after, NULL);
> 		printf("File access time, round %d: %f (sec)\n", i,
> 		       (after.tv_sec - before.tv_sec) +
> 		       (after.tv_usec - before.tv_usec) / 1000000.0);
> 	}
> 	return sum;
> }
> 
> int main(int argc, char *argv[])
> {
> 	const long MB = 1024 * 1024;
> 	long anon_mb, file_mb, file_rounds;
> 	const char filename[] = "large";
> 	long *ret1;
> 	long ret2;
> 
> 	if (argc != 4) {
> 		printf("usage: thrash ANON_MB FILE_MB FILE_ROUNDS\n");
> 		exit(0);
> 	}
> 	anon_mb = atoi(argv[1]);
> 	file_mb = atoi(argv[2]);
> 	file_rounds = atoi(argv[3]);
> 
> 	fallocate_file(filename, file_mb * MB);
> 	printf("Allocate %ld MB anonymous pages\n", anon_mb);
> 	ret1 = alloc_anon(anon_mb * MB);
> 	printf("Access %ld MB file pages\n", file_mb);
> 	ret2 = access_file(filename, file_mb * MB, file_rounds);
> 	printf("Print result to prevent optimization: %ld\n",
> 	       *ret1 + ret2);
> 	return 0;
> }
> ---8<---
> 
> Running the test program on 2GB RAM VM with kernel 5.2.0-rc5, the
> program fills ram with 2048 MB memory, access a 200 MB file for 10
> times. Without this patch, the file cache is dropped aggresively and
> every access to the file is from disk.
> 
>   $ ./thrash 2048 200 10
>   Allocate 2048 MB anonymous pages
>   Access 200 MB file pages
>   File access time, round 0: 2.489316 (sec)
>   File access time, round 1: 2.581277 (sec)
>   File access time, round 2: 2.487624 (sec)
>   File access time, round 3: 2.449100 (sec)
>   File access time, round 4: 2.420423 (sec)
>   File access time, round 5: 2.343411 (sec)
>   File access time, round 6: 2.454833 (sec)
>   File access time, round 7: 2.483398 (sec)
>   File access time, round 8: 2.572701 (sec)
>   File access time, round 9: 2.493014 (sec)
> 
> With this patch, these file pages can be cached.
> 
>   $ ./thrash 2048 200 10
>   Allocate 2048 MB anonymous pages
>   Access 200 MB file pages
>   File access time, round 0: 2.475189 (sec)
>   File access time, round 1: 2.440777 (sec)
>   File access time, round 2: 2.411671 (sec)
>   File access time, round 3: 1.955267 (sec)
>   File access time, round 4: 0.029924 (sec)
>   File access time, round 5: 0.000808 (sec)
>   File access time, round 6: 0.000771 (sec)
>   File access time, round 7: 0.000746 (sec)
>   File access time, round 8: 0.000738 (sec)
>   File access time, round 9: 0.000747 (sec)
> 
> Fixes: 2a2e48854d70 ("mm: vmscan: fix IO/refault regression in cache workingset transition")
> Signed-off-by: Kuo-Hsin Yang <vovoy@chromium.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Your change makes sense - we should indeed not force cache trimming
only while the page cache is experiencing refaults.

I can't say I fully understand the changelog, though. The problem of
forcing cache trimming while there is enough page cache is older than
the commit you refer to. It could be argued that this commit is
incomplete - it could have added refault detection not just to
inactive:active file balancing, but also the file:anon balancing; but
it didn't *cause* this problem.

Shouldn't this be

Fixes: e9868505987a ("mm,vmscan: only evict file pages when we have plenty")
Fixes: 7c5bd705d8f9 ("mm: memcg: only evict file pages when we have plenty")

instead?
