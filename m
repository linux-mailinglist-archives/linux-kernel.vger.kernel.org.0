Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDE0217A37B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 11:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgCEKyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 05:54:06 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.181]:35450 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725880AbgCEKyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 05:54:06 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 4389E12D27
        for <linux-kernel@vger.kernel.org>; Thu,  5 Mar 2020 04:54:05 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 9o8jjLCo1Efyq9o8jjP1sU; Thu, 05 Mar 2020 04:54:05 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FaEd7taemh650scF/FKlDe95GL6rqrDcsV1+ENwoAYo=; b=f24mJ78xbf1EfsW+xIzeAqlquK
        E6JU5oxcoHQ+vdMzeLJhMCMKgcOUb/FqutbKiYFFgIHiIo4Q7catoDYtyq2lxHrO3H/ozwIw7c7Bo
        tyb4OV0di9NN8eFHHc+JlrgesLpI69f0XD5a3kYQLME0v2+5rh4qCfJQhUx1DA1E+tlAfnz9aVV2z
        kiwqF8mhIlgwi2SMBi0amMDMPFBTpAZt7KDjzudY9GvCzOYw1txTPqLJrimhO6cd7Uat5B2sNegND
        jzTPMWFvqePG8y8/B5mNSNjnyX0ITxIoH4EquTpF/KSpJ5506vdB3hLGLap7RFsGVxQvLMYgDGKBu
        oM32RlwA==;
Received: from [201.166.169.220] (port=31563 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j9o8f-003gJu-CY; Thu, 05 Mar 2020 04:54:01 -0600
Date:   Thu, 5 Mar 2020 04:57:07 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] drm/vc4/vc4_drv.h: Replace zero-length array with
 flexible-array member
Message-ID: <20200305105707.GA19261@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.166.169.220
X-Source-L: No
X-Exim-ID: 1j9o8f-003gJu-CY
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.166.169.220]:31563
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 31
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/vc4/vc4_drv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index f90c0d08e740..5ecb8b4a48a1 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -65,7 +65,7 @@ struct vc4_perfmon {
 	 * Note that counter values can't be reset, but you can fake a reset by
 	 * destroying the perfmon and creating a new one.
 	 */
-	u64 counters[0];
+	u64 counters[];
 };
 
 struct vc4_dev {
-- 
2.25.0

