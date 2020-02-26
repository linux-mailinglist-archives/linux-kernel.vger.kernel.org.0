Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95A5916F75F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 06:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgBZFdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 00:33:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52926 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgBZFdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 00:33:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=R7FlMG+Bvduqa3vWTZsVfXNdv+eGdfaeXD+EX3Ia40U=; b=UAtOqdCtIa1gxxR3pMDq5JylXx
        azJWmvIewLWXM6fb3Qjt9wQI3hbwOlkb4pWp67FpIdIpxhf1bvjRPtdR//pAk7Knftf0K37ER/U6q
        S+M704BB8ttr7c2kSFC5WOuxhse7/+E6qzczur9bqiLXOW3XatonRS0zQP1fQl0eJq3jh2mtnLLST
        PBMXdDZq4uXi7rRYMojn0xEezZKWxQHQWR8WY2iHrnMeISKUtwpjLykJ5SG+rCgQsyA+jhxCCt4U1
        1MvkeUIh20O0dwFwssEe8rDixIIp+GeBCjMGC8MekJj26ctgW2NaTqBzb8VShYmhprBK8h0i4PP8L
        UXStqNzQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6pJV-0002Pr-Ll; Wed, 26 Feb 2020 05:32:53 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] sound: korg1212: fix if-statement empty body warnings
Message-ID: <91fb1e97-a773-5790-3f65-8198403341e1@infradead.org>
Date:   Tue, 25 Feb 2020 21:32:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix gcc warnings when -Wextra is used by using an empty do-while
block instead of <nothing>.  Fixes these build warnings:

../sound/pci/korg1212/korg1212.c:674:44: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../sound/pci/korg1212/korg1212.c:708:43: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../sound/pci/korg1212/korg1212.c:730:43: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../sound/pci/korg1212/korg1212.c:853:43: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../sound/pci/korg1212/korg1212.c:1013:44: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../sound/pci/korg1212/korg1212.c:1035:43: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../sound/pci/korg1212/korg1212.c:1052:43: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../sound/pci/korg1212/korg1212.c:1066:43: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../sound/pci/korg1212/korg1212.c:1087:43: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../sound/pci/korg1212/korg1212.c:1094:43: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../sound/pci/korg1212/korg1212.c:1208:43: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../sound/pci/korg1212/korg1212.c:2360:102: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
---
 sound/pci/korg1212/korg1212.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200225.orig/sound/pci/korg1212/korg1212.c
+++ linux-next-20200225/sound/pci/korg1212/korg1212.c
@@ -30,7 +30,7 @@
 #if K1212_DEBUG_LEVEL > 0
 #define K1212_DEBUG_PRINTK(fmt,args...)	printk(KERN_DEBUG fmt,##args)
 #else
-#define K1212_DEBUG_PRINTK(fmt,...)
+#define K1212_DEBUG_PRINTK(fmt,...)	do { } while (0)
 #endif
 #if K1212_DEBUG_LEVEL > 1
 #define K1212_DEBUG_PRINTK_VERBOSE(fmt,args...)	printk(KERN_DEBUG fmt,##args)

