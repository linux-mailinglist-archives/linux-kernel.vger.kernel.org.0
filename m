Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59FA21926A9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 12:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbgCYLF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 07:05:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57814 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgCYLF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 07:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Xj5cCj8r7SaDFtamrs+Fgedwd23OEns1xvko9GLsk5M=; b=uhvgkR5ENy58dFitnfuFzxbUMm
        o8h494/2840b8bTFZ8xEzeB+yoOjjQuiiWeSIglHEuJcyLTWjcrk9Okov+eo3j4ZXCChNUFEcmOfD
        8h52OUovUqmklMbCasiCXZ7jqSobrRwtVg8a4vQq4B7S5U6xNZqx9qCPnpJnJy4BdEXo8nDQnvSNu
        SRsmZfJ/beExLo21ncLiWmlPhTrI3a+UtGvPbTrdjnPIf+MNZ6ZGBiMV0uwE19FhgfibW3LlR3pSO
        EHTPWO6W+4Q815dnhpiEWC7VAnySVhuchIDC6K5TxMPIofd66jVBR1PJ4rp5imIGQaS7RUtSlXmWQ
        6cDbV4Eg==;
Received: from [2001:4bb8:18c:2a9e:999c:283e:b14a:9189] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH3rB-0001tU-0w; Wed, 25 Mar 2020 11:05:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] block: mark part_in_flight and part_in_flight_rw static
Date:   Wed, 25 Mar 2020 12:03:32 +0100
Message-Id: <20200325110338.1029232-3-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200325110338.1029232-1-hch@lst.de>
References: <20200325110338.1029232-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c         | 7 ++++---
 include/linux/genhd.h | 3 ---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 52841f41d6eb..e8978df06f35 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -112,7 +112,8 @@ void part_dec_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
 		part_stat_local_dec(&part_to_disk(part)->part0, in_flight[rw]);
 }
 
-unsigned int part_in_flight(struct request_queue *q, struct hd_struct *part)
+static unsigned int part_in_flight(struct request_queue *q,
+		struct hd_struct *part)
 {
 	int cpu;
 	unsigned int inflight;
@@ -132,8 +133,8 @@ unsigned int part_in_flight(struct request_queue *q, struct hd_struct *part)
 	return inflight;
 }
 
-void part_in_flight_rw(struct request_queue *q, struct hd_struct *part,
-		       unsigned int inflight[2])
+static void part_in_flight_rw(struct request_queue *q, struct hd_struct *part,
+		unsigned int inflight[2])
 {
 	int cpu;
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 7310108f5351..18fd9e01c511 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -413,9 +413,6 @@ static inline void free_part_stats(struct hd_struct *part)
 #define part_stat_local_read_cpu(gendiskp, field, cpu)			\
 	local_read(&(part_stat_get_cpu(gendiskp, field, cpu)))
 
-unsigned int part_in_flight(struct request_queue *q, struct hd_struct *part);
-void part_in_flight_rw(struct request_queue *q, struct hd_struct *part,
-		       unsigned int inflight[2]);
 void part_dec_in_flight(struct request_queue *q, struct hd_struct *part,
 			int rw);
 void part_inc_in_flight(struct request_queue *q, struct hd_struct *part,
-- 
2.25.1

