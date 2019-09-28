Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2EDC1238
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2019 23:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfI1VX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Sep 2019 17:23:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfI1VX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 17:23:59 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFAEC2082F;
        Sat, 28 Sep 2019 21:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569705837;
        bh=IL2VVcFyxpeEUNpyOhzjpMAkldnUFCjDXmLJjSwk0b4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wLdl2VGnUe1bttx+zoWYTFG0bVC3xiy9wTHUhXVGdxu0oGh+c2V1lcRZUegpXKI4O
         bDk12tLvcuBPRlRc+QaY9NVwiuEUXyWwrjig3MiTd2pzE1GZdfzJTxAKehjSZOqBTf
         G9t6No8G87XcrxeJ2aBKM9W7gl2v6Wr2VIa1YDGY=
Date:   Sat, 28 Sep 2019 14:23:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        tglx@linutronix.de, Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mm, vmpressure: Fix a signedness bug in
 vmpressure_register_event()
Message-Id: <20190928142356.932cff0ad6c17f4a18edc80f@linux-foundation.org>
In-Reply-To: <20190925110449.GO3264@mwanda>
References: <20190925110449.GO3264@mwanda>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2019 14:04:49 +0300 Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The "mode" and "level" variables are enums and in this context GCC will
> treat them as unsigned ints so the error handling is never triggered.
> 
> I also removed the bogus initializer because it isn't required any more
> and it's sort of confusing.
> 

A bit picky of me, but it's an eyesore to assign an int to an enum,
then compare the casted enum to an int then copy the enum back to an
int.

How about doing it this way?  Only copy the int to the enum once we
know it's within range?

--- a/mm/vmpressure.c~mm-vmpressure-fix-a-signedness-bug-in-vmpressure_register_event-fix
+++ a/mm/vmpressure.c
@@ -375,20 +375,18 @@ int vmpressure_register_event(struct mem
 
 	/* Find required level */
 	token = strsep(&spec, ",");
-	level = match_string(vmpressure_str_levels, VMPRESSURE_NUM_LEVELS, token);
-	if ((int)level < 0) {
-		ret = level;
+	ret = match_string(vmpressure_str_levels, VMPRESSURE_NUM_LEVELS, token);
+	if (ret < 0)
 		goto out;
-	}
+	level = ret;
 
 	/* Find optional mode */
 	token = strsep(&spec, ",");
 	if (token) {
-		mode = match_string(vmpressure_str_modes, VMPRESSURE_NUM_MODES, token);
-		if ((int)mode < 0) {
-			ret = mode;
+		ret = match_string(vmpressure_str_modes, VMPRESSURE_NUM_MODES, token);
+		if (ret < 0)
 			goto out;
-		}
+		mode = ret;
 	}
 
 	ev = kzalloc(sizeof(*ev), GFP_KERNEL);
_

