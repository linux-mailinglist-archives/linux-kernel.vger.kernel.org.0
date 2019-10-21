Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C812DDE250
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 04:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfJUCor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Oct 2019 22:44:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44096 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfJUCor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 22:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rC6gSXEIYzPJ8RDbWxn7d8O48Lkwu1i0Wg5ua9cjhrc=; b=tDJD4MSK4qTRpeO8q1mGy7g24
        F2tnNVzdQudSjEiRN/+/bxJ3dWrsKwBVfqCF5mmBSs/TlEwcUakx4AvTYkRhcly8oxNOKmXgJsBbw
        VmCdAJumA7KAFmaB5j4uIu9X1Rwf8FvO6sW2+rF95/MBtJWg6Our4z4Ry03cWaSNLxXstzN1SfKSu
        5TLu4h95M0da0PNI1n1h50x9eTsWBzfKXX0wcWhweeoJOTZLl6W8wtYnE7UdPPMcjmBvAEvCs9m1X
        3g4nP0vzkQw0f+uC1ojV0K7QUM9DeMpPGE0YbHsEkAHksAGBpOadZrxBv8aFWP+ts7S80K1M9iHI9
        BaX6UcT0Q==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMNgb-0003hM-Oo; Mon, 21 Oct 2019 02:44:45 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Dmitry Safonov <dima@arista.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next RESEND] Documentation/admin-guide: fix sysctl Sphinx
 warning
Message-ID: <c5fed83a-d105-4142-8607-4b06ebadf0e8@infradead.org>
Date:   Sun, 20 Oct 2019 19:44:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix Sphinx warning when building Documentation:

Documentation/admin-guide/sysctl/kernel.rst:397: WARNING: Title underline too short.

hung_task_interval_warnings:
===================

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dmitry Safonov <dima@arista.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
---
 Documentation/admin-guide/sysctl/kernel.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20191018.orig/Documentation/admin-guide/sysctl/kernel.rst
+++ linux-next-20191018/Documentation/admin-guide/sysctl/kernel.rst
@@ -394,7 +394,7 @@ This file shows up if CONFIG_DETECT_HUNG
 
 
 hung_task_interval_warnings:
-===================
+============================
 
 The same as hung_task_warnings, but set the number of interval
 warnings to be issued about detected hung tasks during check


