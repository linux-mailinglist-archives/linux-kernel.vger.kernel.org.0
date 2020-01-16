Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 468E513F5C8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 19:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437208AbgAPS7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 13:59:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60944 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388977AbgAPRGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:06:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=O2oB/VU8iyxVCOuhkqWCVkodRFDstN8yc7koL+Xm+D0=; b=Cs2GYr29Sk6mgBrpJMwsneQ5V
        2veU5z/gjrHrU71aINh9D5iD1aAExRuhDprTAaEsebypTxAJchrDZhyovQdEqTYLEUugPVwtxScA8
        DvL6qrrLxYp/bX/DR97jxt5JSBFeszY1p9bjxKvlzirZl9W8KTfZ8CfnumW22DwFFHzc/xSaiO4pt
        i/eHG0a+mVoMhvkGAjN6bzzGB/QYCACNVbX+2jYAc1Se0Pjp7xnX+ji1f771Po7TZimDFtMSsBc/m
        BliXxXh2T2Y25LFDPZXC6CMB/o0/Ut14ssG54q/mfJ5scEfzy1yN6o5b6BlQe6kCp29D1nJXvdhPr
        32AAbhyKA==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1is8bQ-0008Cf-UC; Thu, 16 Jan 2020 17:06:40 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] MAINTAINERS: nouveau mailing list is moderated
Message-ID: <2684257e-1027-1c1b-d794-78bb1864b437@infradead.org>
Date:   Thu, 16 Jan 2020 09:06:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Mark the nouveau@ mailing list as moderated for non-subscribers.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 MAINTAINERS |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200116.orig/MAINTAINERS
+++ linux-next-20200116/MAINTAINERS
@@ -5315,7 +5315,7 @@ F:	Documentation/devicetree/bindings/dis
 DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS
 M:	Ben Skeggs <bskeggs@redhat.com>
 L:	dri-devel@lists.freedesktop.org
-L:	nouveau@lists.freedesktop.org
+L:	nouveau@lists.freedesktop.org (moderated for non-subscribers)
 T:	git git://github.com/skeggsb/linux
 S:	Supported
 F:	drivers/gpu/drm/nouveau/
@@ -16914,7 +16914,7 @@ R:	Karol Herbst <karolherbst@gmail.com>
 R:	Pekka Paalanen <ppaalanen@gmail.com>
 S:	Maintained
 L:	linux-kernel@vger.kernel.org
-L:	nouveau@lists.freedesktop.org
+L:	nouveau@lists.freedesktop.org (moderated for non-subscribers)
 F:	kernel/trace/trace_mmiotrace.c
 F:	include/linux/mmiotrace.h
 F:	arch/x86/mm/kmmio.c

