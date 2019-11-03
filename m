Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA9F5ED329
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2019 12:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfKCLk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Nov 2019 06:40:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37838 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfKCLkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 06:40:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PhFqymQzLwUkpt9aZptmbnpE1l5x6Ym+qjsu62LkOys=; b=YqhpuaUXXDwH++xOSzBJBtTcgs
        MbPMHVwV5xt7v4HpI9ENS8XABr+chG9i2Rprb+FFRQvxyr1E24KfJIHrbiv/Yp/JEK5mGi+dUEM+q
        GIAEbwAQVYPyKkfuY7H3XQqG/xLKCfzjqt5+Fc4b/3MvUgD0T2th3VIvgON50cArweDmJHOHSHmwG
        smIpHSu7EvYEBAJzjhxejMymHQtTNxJCMzhWokD2l/PqrXD0EWRnDH0vJYF6v1pJB5TsI6HlVlKqB
        K05jsYeeZZQogyyFbkAlNrllPnjlJaBbmn0i489zpyUAj/uYJN9yP66hMu5eadgtyiAwXcl65CAl6
        /1uweMMw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iREEz-0007qS-PI; Sun, 03 Nov 2019 11:40:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH 4/5] idr: Handle integer overflow correctly
Date:   Sun,  3 Nov 2019 03:40:11 -0800
Message-Id: <20191103114012.30027-6-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191103114012.30027-1-willy@infradead.org>
References: <20191103114012.30027-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is an entry at INT_MAX then idr_for_each_entry() will increment
id after handling it.  This is undefined behaviour, and is caught by
UBSAN.  Adding 1U to id forces the operation to be carried out as an
unsigned addition which (when assigned to id) will result in INT_MIN.
Since there is never an entry stored at INT_MIN, idr_get_next() will
return NULL, ending the loop as expected.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 include/linux/idr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index ee7abae143d3..dc09bd646bcb 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -185,7 +185,7 @@ static inline void idr_preload_end(void)
  * is convenient for a "not found" value.
  */
 #define idr_for_each_entry(idr, entry, id)			\
-	for (id = 0; ((entry) = idr_get_next(idr, &(id))) != NULL; ++id)
+	for (id = 0; ((entry) = idr_get_next(idr, &(id))) != NULL; id += 1U)
 
 /**
  * idr_for_each_entry_ul() - Iterate over an IDR's elements of a given type.
-- 
2.24.0.rc1

