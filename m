Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB7C14790C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 08:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbgAXHr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 02:47:27 -0500
Received: from relay.sw.ru ([185.231.240.75]:54378 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgAXHr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 02:47:27 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1iutgQ-0008M2-HG; Fri, 24 Jan 2020 10:47:14 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] seq_read: info message about buggy .next functions
To:     linux-kernel@vger.kernel.org
Cc:     NeilBrown <neilb@suse.com>
References: <244674e5-760c-86bd-d08a-047042881748@virtuozzo.com>
Message-ID: <7c24087c-e280-e580-5b0c-0cdaeb14cd18@virtuozzo.com>
Date:   Fri, 24 Jan 2020 10:47:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <244674e5-760c-86bd-d08a-047042881748@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It helps to detect missed or out-of-tree incorect .next seq_file functions

https://bugzilla.kernel.org/show_bug.cgi?id=206283
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/seq_file.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 1600034..07c6909 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -256,9 +256,12 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 		loff_t pos = m->index;
 
 		p = m->op->next(m, p, &m->index);
-		if (pos == m->index)
-			/* Buggy ->next function */
+		if (pos == m->index) {
+			pr_info("buggy seq_file .next function %ps "
+				"did not updated position index\n",
+				m->op->next);
 			m->index++;
+		}
 		if (!p || IS_ERR(p)) {
 			err = PTR_ERR(p);
 			break;
-- 
1.8.3.1

