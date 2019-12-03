Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5EE0111C6A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 23:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfLCWn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 17:43:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:59456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728857AbfLCWnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:43:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A21A2073C;
        Tue,  3 Dec 2019 22:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413030;
        bh=4Hi7puFYa9ZD/tWeZe+cdHnTgvx3uxgPBqtlp1x6mX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1P8zeJElG1YkyHXaIoCE9/V3bhJGJ1PFhyj/PZrwJI9IS3xNtEAFtBZtjEk/f69aa
         2yb5KjzuEs3QeFkZ5CMYJFnydvfW0232YfIOsUG1aNY9O0UBH9++1dB1J3cp8ss/wo
         D/URfQtGj0c5xf/21La119dbOUXQsQ/l/hA4KNK8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeroen de Borst <jeroendb@google.com>,
        Catherine Sullivan <csully@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 109/135] gve: Fix the queue page list allocated pages count
Date:   Tue,  3 Dec 2019 23:35:49 +0100
Message-Id: <20191203213041.231691250@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203213005.828543156@linuxfoundation.org>
References: <20191203213005.828543156@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeroen de Borst <jeroendb@google.com>

[ Upstream commit a95069ecb7092d03b2ea1c39ee04514fe9627540 ]

In gve_alloc_queue_page_list(), when a page allocation fails,
qpl->num_entries will be wrong.  In this case priv->num_registered_pages
can underflow in gve_free_queue_page_list(), causing subsequent calls
to gve_alloc_queue_page_list() to fail.

Fixes: f5cedc84a30d ("gve: Add transmit and receive support")
Signed-off-by: Jeroen de Borst <jeroendb@google.com>
Reviewed-by: Catherine Sullivan <csully@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/google/gve/gve_main.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -544,7 +544,7 @@ static int gve_alloc_queue_page_list(str
 	}
 
 	qpl->id = id;
-	qpl->num_entries = pages;
+	qpl->num_entries = 0;
 	qpl->pages = kvzalloc(pages * sizeof(*qpl->pages), GFP_KERNEL);
 	/* caller handles clean up */
 	if (!qpl->pages)
@@ -562,6 +562,7 @@ static int gve_alloc_queue_page_list(str
 		/* caller handles clean up */
 		if (err)
 			return -ENOMEM;
+		qpl->num_entries++;
 	}
 	priv->num_registered_pages += pages;
 


