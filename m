Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4CB4165D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 13:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgBTM1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 07:27:46 -0500
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:33902 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgBTM1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 07:27:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 9D9583F5AE;
        Thu, 20 Feb 2020 13:27:40 +0100 (CET)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="OaILxhm+";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KPHY7eEQ--tJ; Thu, 20 Feb 2020 13:27:39 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id D431E3F49A;
        Thu, 20 Feb 2020 13:27:34 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 3EE2336016F;
        Thu, 20 Feb 2020 13:27:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1582201654; bh=eCvHiFbQ8gHm9NDwNOq1qIsqK0H59VOA9pzhD1uajyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OaILxhm+m7Xx+sHfC/nWT+noYt2XqhlrgBZf39HjE8aNaMUsJLdLkJIpWaqRjoP/2
         GuSF1hBbFqiXS4Yk/iWspgncQydoGsgzMJxV2Mv2BI7vlb9bJWJOWS4TfdIDXAvz+D
         wOW+v2Y6UEYOWiCEH4GxmH+RSCwPV0ZXVwcKYhCk=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Roland Scheidegger <sroland@vmware.com>
Subject: [PATCH v4 1/9] fs: Constify vma argument to vma_is_dax
Date:   Thu, 20 Feb 2020 13:27:11 +0100
Message-Id: <20200220122719.4302-2-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200220122719.4302-1-thomas_os@shipmail.org>
References: <20200220122719.4302-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

The vma argument is only dereferenced for reading.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Roland Scheidegger <sroland@vmware.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98e0349adb52..4f41fdbf402f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3367,7 +3367,7 @@ static inline bool io_is_direct(struct file *filp)
 	return (filp->f_flags & O_DIRECT) || IS_DAX(filp->f_mapping->host);
 }
 
-static inline bool vma_is_dax(struct vm_area_struct *vma)
+static inline bool vma_is_dax(const struct vm_area_struct *vma)
 {
 	return vma->vm_file && IS_DAX(vma->vm_file->f_mapping->host);
 }
-- 
2.21.1

