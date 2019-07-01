Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB7519F70
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 16:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfEJOis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 10:38:48 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44159 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfEJOis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 10:38:48 -0400
Received: by mail-qt1-f194.google.com with SMTP id f24so2413152qtk.11;
        Fri, 10 May 2019 07:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WoMLIF2rg0EeY68QM7oBQC2dx49t05CQYIl4Q/tdJ2Q=;
        b=TRme1k96RXNmQtVQ4Fi6xRyhQkUJYa3bKwk7TNljQtA2hMnYAvr3WQ6QLBvsCdjvwA
         h67rtZkyMdb79TW16DEZmd66ANjdyH5anDJqLXKVtgPxa3wau7B7W6pGjkUWjPSN2jvr
         Jy4Gh8r2IvKeFhJjLqpt+n7ElpPsaSXSPRh0LUBUIMAbsNJ8Oc4yG54kSU0Gp7ptkQIH
         PlChm/iqdgoKWcfUj9jmc2Fmcjaz/R5LN4IgD4r9pvDpTPKyakCabhymOkVpdO93Yj0A
         Wsoz1wFoqQf+HADKfUpzhzeWNcavwz/giyhQNbVevuyl5/o7MLRGKWUFyChWanVl0+fs
         uVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=WoMLIF2rg0EeY68QM7oBQC2dx49t05CQYIl4Q/tdJ2Q=;
        b=PbmcORmyLa3e0G6SgqwHQsRg4jpgWmadknHk0Ek38lC2jH1BPIcY8tGT2ppP2dI9kL
         1VY7ah+awgQ+H0Ha/oc1YalA8gk6XBrgnjl5hZt/23+F6v0sSO716zznjFjxJCYw1mip
         jzbTkEBBkO3qM6mspNDk1XD7CM8IO+BJd26ZoqnUfCxmcbLzafBEhHdKtNgHhCNmwLa+
         VySSysfUunmjpshMESPiWg7TF/eFaYmsemnjixQ06ab9HJwWbRnedkN5UDRtorGOkN8J
         yCzXMWUk7Zypa4qkPjjC0Y9XSEbVRtyxG+DgeiaEF497ouS1XhhxBRkyrSitzuinaKVX
         BXUw==
X-Gm-Message-State: APjAAAU5k5IJwq3j61u5F//z1RFvD9L1oFb6EPebkl2GyF45Vyo4+yWa
        PqrmNJ80+x/7ElHe+UF1b10=
X-Google-Smtp-Source: APXvYqyYCRH+z2nYziTtLQ54DJGxDIAz3C/XuwwfNqvBW0Qd8I09xX9NBwpNG60R6M/slVAyevh9Vw==
X-Received: by 2002:a0c:d00d:: with SMTP id u13mr6563664qvg.147.1557499127113;
        Fri, 10 May 2019 07:38:47 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::8fe7])
        by smtp.gmail.com with ESMTPSA id a7sm2610983qkl.60.2019.05.10.07.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 07:38:46 -0700 (PDT)
Date:   Fri, 10 May 2019 07:38:43 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH block/for-5.2-fixes] blkcg: update blkcg_print_stat() to
 handle larger outputs
Message-ID: <20190510143817.GB374014@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on the number of devices, blkcg stats can go over the
default seqfile buf size.  seqfile normally retries with a larger
buffer but since the ->pd_stat() addition, blkcg_print_stat() doesn't
tell seqfile that overflow has happened and the output gets printed
truncated.  Fix it by calling seq_commit() w/ -1 on possible
overflows.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: 903d23f0a354 ("blk-cgroup: allow controllers to output their own stats")
Cc: stable@vger.kernel.org # v4.19+
Cc: Josef Bacik <jbacik@fb.com>
---
 block/blk-cgroup.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1005,8 +1005,12 @@ static int blkcg_print_stat(struct seq_f
 		}
 next:
 		if (has_stats) {
-			off += scnprintf(buf+off, size-off, "\n");
-			seq_commit(sf, off);
+			if (off < size - 1) {
+				off += scnprintf(buf+off, size-off, "\n");
+				seq_commit(sf, off);
+			} else {
+				seq_commit(sf, -1);
+			}
 		}
 	}
 
