Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F05E137C8D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jan 2020 10:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgAKJIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jan 2020 04:08:52 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:44760 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728558AbgAKJIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 04:08:52 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0F1D09625D48D0B11230;
        Sat, 11 Jan 2020 17:08:51 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sat, 11 Jan
 2020 17:08:47 +0800
Subject: Re: [f2fs-dev] [RFC PATCH v5] f2fs: support data compression
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20191216062806.112361-1-yuchao0@huawei.com>
 <20191218214619.GA20072@jaegeuk-macbookpro.roam.corp.google.com>
 <c7035795-73b3-d832-948f-deb36213ba07@huawei.com>
 <20191231004633.GA85441@jaegeuk-macbookpro.roam.corp.google.com>
 <7a579223-39d4-7e51-c361-4aa592b2500d@huawei.com>
 <20200102181832.GA1953@jaegeuk-macbookpro.roam.corp.google.com>
 <20200102190003.GA7597@jaegeuk-macbookpro.roam.corp.google.com>
 <d51f0325-6879-9aa6-f549-133b96e3eef5@huawei.com>
 <94786408-219d-c343-70f2-70a2cc68dd38@huawei.com>
 <20200106181620.GB50058@jaegeuk-macbookpro.roam.corp.google.com>
 <20200110235214.GA25700@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <3776cb0b-4b18-ae0d-16a7-a591bec77a5e@huawei.com>
Date:   Sat, 11 Jan 2020 17:08:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200110235214.GA25700@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/1/11 7:52, Jaegeuk Kim wrote:
> On 01/06, Jaegeuk Kim wrote:
>> On 01/06, Chao Yu wrote:
>>> On 2020/1/3 14:50, Chao Yu wrote:
>>>> This works to me. Could you run fsstress tests on compressed root directory?
>>>> It seems still there are some bugs.
>>>
>>> Jaegeuk,
>>>
>>> Did you mean running por_fsstress testcase?
>>>
>>> Now, at least I didn't hit any problem for normal fsstress case.
>>
>> Yup. por_fsstress
> 
> Please check https://github.com/jaegeuk/f2fs/commits/g-dev-test.
> I've fixed
> - truncation offset
> - i_compressed_blocks and its lock coverage
> - error handling
> - etc

I changed as below, and por_fsstress stops panic the system.

Could you merge all these fixes into original patch?

From bb17d7d77fe0b8a3e3632a7026550800ab9609e9 Mon Sep 17 00:00:00 2001
From: Chao Yu <yuchao0@huawei.com>
Date: Sat, 11 Jan 2020 16:58:20 +0800
Subject: [PATCH] f2fs: compress: fix f2fs_put_rpages_mapping()

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 502cd0ddc2a7..5c6a31d84ce4 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -74,18 +74,10 @@ static void f2fs_put_compressed_page(struct page *page)
 }

 static void f2fs_drop_rpages(struct compress_ctx *cc,
-		struct address_space *mapping, int len, bool unlock)
+					int len, bool unlock)
 {
 	unsigned int i;
 	for (i = 0; i < len; i++) {
-		if (mapping) {
-			pgoff_t start = start_idx_of_cluster(cc);
-			struct page *page = find_get_page(mapping, start + i);
-
-			put_page(page);
-			put_page(page);
-			cc->rpages[i] = NULL;
-		}
 		if (!cc->rpages[i])
 			continue;
 		if (unlock)
@@ -97,18 +89,25 @@ static void f2fs_drop_rpages(struct compress_ctx *cc,

 static void f2fs_put_rpages(struct compress_ctx *cc)
 {
-	f2fs_drop_rpages(cc, NULL, cc->cluster_size, false);
+	f2fs_drop_rpages(cc, cc->cluster_size, false);
 }

 static void f2fs_unlock_rpages(struct compress_ctx *cc, int len)
 {
-	f2fs_drop_rpages(cc, NULL, len, true);
+	f2fs_drop_rpages(cc, len, true);
 }

 static void f2fs_put_rpages_mapping(struct compress_ctx *cc,
-				struct address_space *mapping, int len)
+				struct address_space *mapping,
+				pgoff_t start, int len)
 {
-	f2fs_drop_rpages(cc, mapping, len, false);
+	int i;
+	for (i = 0; i < len; i++) {
+		struct page *page = find_get_page(mapping, start + i);
+
+		put_page(page);
+		put_page(page);
+	}
 }

 static void f2fs_put_rpages_wbc(struct compress_ctx *cc,
@@ -680,7 +679,8 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,

 		if (!PageUptodate(page)) {
 			f2fs_unlock_rpages(cc, i + 1);
-			f2fs_put_rpages_mapping(cc, mapping, cc->cluster_size);
+			f2fs_put_rpages_mapping(cc, mapping, start_idx,
+					cc->cluster_size);
 			f2fs_destroy_compress_ctx(cc);
 			goto retry;
 		}
@@ -714,7 +714,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 unlock_pages:
 	f2fs_unlock_rpages(cc, i);
 release_pages:
-	f2fs_put_rpages_mapping(cc, mapping, i);
+	f2fs_put_rpages_mapping(cc, mapping, start_idx, i);
 	f2fs_destroy_compress_ctx(cc);
 	return ret;
 }
-- 
2.18.0.rc1



> 
> One another fix in f2fs-tools as well.
> https://github.com/jaegeuk/f2fs-tools
> 
>>
>>>
>>> Thanks,
> .
> 
