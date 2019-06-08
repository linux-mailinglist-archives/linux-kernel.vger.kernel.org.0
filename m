Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8500939C3D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2019 11:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfFHJtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jun 2019 05:49:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33357 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfFHJtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 05:49:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id k187so1949705pga.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 02:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ceB58BsT2jhuXKLvpsF6nc1EbvAVeMuXaSf+CtPNzlg=;
        b=ZOHbvL/SIifcsBkKsIMBtCrqGGFpB9o8aoUYAqXaYK5rea2+tx1pKid0Xi8Vynev58
         f4lILw2GUYXpeCcgNH6FgWHFCQaUtzuGBRUWW48lR3mLLdEZv9dsA1qa9AUccDBNi22I
         FgsktcRehMLN1neRxc76Eny2dhNClfBg9lqgOzMnQoQykFEJW79rJ6r5sHMy70/8OX7y
         2sLhGA1S2c1im9T5w19fWhB6zgCHOChLxh+z3iWJNKNclF2wDv5mkWF/sxsNjI6OO3je
         NO3scrCxGmlU6VWSp9bmE2IM6I/n0jD+PCx/zfE5FgHtmru881NJywKLdNRLfXXsSYdj
         onpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ceB58BsT2jhuXKLvpsF6nc1EbvAVeMuXaSf+CtPNzlg=;
        b=cCswFXr85m22UANnC2XHqdz2nf1W05rfinSMttCkprLDOXWXuJKSMG/i5XMSCleSvV
         /l5bd++vzNwkTEuHUD+W+vae00P5NVB47g2Zx3GU9IE4sFXdVIVn4+wLfDO15Gxo43kn
         TSRKNLMa6ho4l9vrYIwqipPYUtVkcfozmZDSsMVd6N+phDdBxT65P/fCfy3YaHfG3KOH
         IqRhjDBWrKfwLIePg96jh+sepjnGwQFaG0ClPyy94iUgtTo8wtRU+7qKc38157ucFcSy
         01pbfkZhyZnQnDawWZsU5rX6rk0WnvgJztHtH4tGViARSEUN2eIR5D1KUKJRQ+6ZJsfx
         gUsg==
X-Gm-Message-State: APjAAAW0YG/9m8tPLS2kLAHs397WnzSExUzvRWtGoF794xQvIy+f5YC+
        s7S5fb5BUrsostZutnaSrQe5oah4
X-Google-Smtp-Source: APXvYqynnyl6j4lWBQSS4y8CNh8+wxRD6csIB5VrA1DZZsD6AFefijgTYBS9fQJ9CefQtd5iIsDANQ==
X-Received: by 2002:a62:65c7:: with SMTP id z190mr63825619pfb.73.1559987363342;
        Sat, 08 Jun 2019 02:49:23 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id z11sm4017605pjq.13.2019.06.08.02.49.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 02:49:22 -0700 (PDT)
Date:   Sat, 8 Jun 2019 15:19:18 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: erofs: make use of DBG_BUGON
Message-ID: <20190608094918.GA11605@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DBG_BUGON is introduced and it could only crash when EROFS_FS_DEBUG
(EROFS developping feature) is on.
replace BUG_ON with DBG_BUGON.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/erofs/unzip_vle.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle.h b/drivers/staging/erofs/unzip_vle.h
index 517e5ce..902e67d 100644
--- a/drivers/staging/erofs/unzip_vle.h
+++ b/drivers/staging/erofs/unzip_vle.h
@@ -147,7 +147,7 @@ static inline unsigned z_erofs_onlinepage_index(struct page *page)
 {
 	union z_erofs_onlinepage_converter u;
 
-	BUG_ON(!PagePrivate(page));
+	DBG_BUGON(!PagePrivate(page));
 	u.v = &page_private(page);
 
 	return atomic_read(u.o) >> Z_EROFS_ONLINEPAGE_INDEX_SHIFT;
@@ -179,7 +179,7 @@ static inline void z_erofs_onlinepage_fixup(struct page *page,
 		if (!index)
 			return;
 
-		BUG_ON(id != index);
+		DBG_BUGON(id != index);
 	}
 
 	v = (index << Z_EROFS_ONLINEPAGE_INDEX_SHIFT) |
@@ -193,7 +193,7 @@ static inline void z_erofs_onlinepage_endio(struct page *page)
 	union z_erofs_onlinepage_converter u;
 	unsigned v;
 
-	BUG_ON(!PagePrivate(page));
+	DBG_BUGON(!PagePrivate(page));
 	u.v = &page_private(page);
 
 	v = atomic_dec_return(u.o);
-- 
2.7.4

