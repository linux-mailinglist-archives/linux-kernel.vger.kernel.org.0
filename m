Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED97F76E8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 15:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfKKOqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 09:46:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:51516 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726887AbfKKOqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:46:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2C882B02E;
        Mon, 11 Nov 2019 14:46:32 +0000 (UTC)
Subject: [PATCH 3/3] xen/mcelog: also allow building for 32-bit kernels
From:   Jan Beulich <jbeulich@suse.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <a83f42ad-c380-c07f-7d22-7f19107db5d5@suse.com>
Message-ID: <07358162-1d03-63f5-ad14-95a2e0e23018@suse.com>
Date:   Mon, 11 Nov 2019 15:46:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <a83f42ad-c380-c07f-7d22-7f19107db5d5@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no apparent reason why it can be used on 64-bit only.

Signed-off-by: Jan Beulich <jbeulich@suse.com>

--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -285,7 +285,7 @@ config XEN_ACPI_PROCESSOR
 
 config XEN_MCE_LOG
 	bool "Xen platform mcelog"
-	depends on XEN_DOM0 && X86_64 && X86_MCE
+	depends on XEN_DOM0 && X86 && X86_MCE
 	help
 	  Allow kernel fetching MCE error from Xen platform and
 	  converting it into Linux mcelog format for mcelog tools

