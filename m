Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8C0F16BB8C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 09:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgBYILe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 03:11:34 -0500
Received: from relay.sw.ru ([185.231.240.75]:41990 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgBYILe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 03:11:34 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1j6VJJ-00055H-CR; Tue, 25 Feb 2020 11:11:21 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2] pstore: pstore_ftrace_seq_next should increase position
 index
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Message-ID: <4e49830d-4c88-0171-ee24-1ee540028dad@virtuozzo.com>
Date:   Tue, 25 Feb 2020 11:11:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If .next function does not change position index,
following .show function will repeat output related
to current position index.

Cc: stable@vger.kernel.org
Fixes: 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code ...")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206283
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/pstore/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 7fbe8f0..ea8799b 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -87,11 +87,11 @@ static void *pstore_ftrace_seq_next(struct seq_file *s, void *v, loff_t *pos)
 	struct pstore_private *ps = s->private;
 	struct pstore_ftrace_seq_data *data = v;
 
+	(*pos)++;
 	data->off += REC_SIZE;
 	if (data->off + REC_SIZE > ps->total_size)
 		return NULL;
 
-	(*pos)++;
 	return data;
 }
 
-- 
1.8.3.1

