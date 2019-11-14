Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9112AFB11E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 14:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfKMNLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 08:11:02 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43391 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfKMNLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 08:11:02 -0500
Received: by mail-lf1-f66.google.com with SMTP id q5so1901338lfo.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 05:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arrikto-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=APXfuG82A+VYQSkpqfeuJieTcNwnepuIQxnGzHt+UyY=;
        b=BAeCjAlzwou5Zo9UvZSL2D4JSlacqkT7yTYCtZVUIRNeMaEt3hdYh761eqcGUkI/Yo
         I9+kvWMLSuScZsn4KcRn9p2zxHd49AvbDJDQusjhSGNQRLQWic3DzLnaWBrpON3B69nD
         aVDAJ3BCTMD/v+an6y8zO+6Nko1hmKWVLk2aJVx1z30XdkijkPW8Oo9Mxcu/IJuD/+fM
         A84fvsdtOR9NSSVxTeXmcTMGwIy/fSZA8PSWC5wbLHWpfo03k+8kG4VfIRlyF1SaCLO2
         VF5At8jflRl18pUJbLsDnR83UOo2nNH/Us1sPEkSPeCTSwXq5zT4raVSZ/wxuqy8xY7a
         lnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=APXfuG82A+VYQSkpqfeuJieTcNwnepuIQxnGzHt+UyY=;
        b=Katu1rkoGmNgEh4AVfrFHw/xquO+KbEh5SC/4FDSLETY+1CBBTrkUjPUD4VPNalyyL
         Rjs3hy6JfTbMxVDoUkW83GdYGWa67HwpUvY7zkrSv7B+Zv5sD5XYjiYyNhfpHMLGTrgU
         Q+BxoZw/Oqs7hLy4fJSRqkeBSSlpyJCASoWHRU67wM7+zv+6+NU/kE4IHZJFZ6xTAt1F
         VO1iTxk5pOAqXqcs1fQRyeNAXgBdo/E/shArLnmZijRJCJloNqPW6e+QPd35epvXgECg
         eWNSxOwUV9DuRcG+oUsYbqFQKt8p9FGDgqanCX2zYEZIwcRcYGxHtpk64zzjPzKRFnJI
         iJRg==
X-Gm-Message-State: APjAAAUgoTGP2bVIlL7VNaa3V875mYKFAD1ddjtOneZy4lNxAzkRXNdw
        kp+Inp79sYL/lUWxOfCC/mEQnw==
X-Google-Smtp-Source: APXvYqw8acf0sFiW3raGdnG9WRNX75XMtKloLZJBrhpNKGHffyGTzbwc68/x0EVvUMtvNYR9K6RDIA==
X-Received: by 2002:a19:500d:: with SMTP id e13mr2669462lfb.85.1573650660205;
        Wed, 13 Nov 2019 05:11:00 -0800 (PST)
Received: from snf-864.vm.snf.arr ([31.177.62.212])
        by smtp.gmail.com with ESMTPSA id y75sm1070176lff.58.2019.11.13.05.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 05:10:59 -0800 (PST)
From:   Nikos Tsironis <ntsironis@arrikto.com>
To:     mpatocka@redhat.com, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org, msnitzer@redhat.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Cc:     swood@redhat.com, linux-fsdevel@vger.kernel.org, dwagner@suse.de,
        bigeasy@linutronix.de, iliastsi@arrikto.com, ntsironis@arrikto.com
Subject: [PATCH RT 2/2 v4] list_bl: avoid BUG when the list is not locked
Date:   Wed, 13 Nov 2019 15:10:42 +0200
Message-Id: <20191113131042.7719-1-ntsironis@arrikto.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <alpine.LRH.2.02.1911121110430.12815@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1911121110430.12815@file01.intranet.prod.int.rdu2.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

list_bl would crash with BUG() if we used it without locking.
dm-snapshot uses its own locking on realtime kernels (it can't use
list_bl because list_bl uses raw spinlock and dm-snapshot takes other
non-raw spinlocks while holding bl_lock).

To avoid this BUG we deactivate the list debug checks for list_bl on
realtime kernels.

This patch is intended only for the realtime kernel patchset, not for
the upstream kernel.

Signed-off-by: Nikos Tsironis <ntsironis@arrikto.com>
Reviewed-by: Mikulas Patocka <mpatocka@redhat.com>
---
 include/linux/list_bl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index da38433240f5..3585b2f6b948 100644
--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -25,7 +25,7 @@
 #define LIST_BL_LOCKMASK	0UL
 #endif
 
-#ifdef CONFIG_DEBUG_LIST
+#if defined(CONFIG_DEBUG_LIST) && !defined(CONFIG_PREEMPT_RT_BASE)
 #define LIST_BL_BUG_ON(x) BUG_ON(x)
 #else
 #define LIST_BL_BUG_ON(x)
-- 
2.11.0

