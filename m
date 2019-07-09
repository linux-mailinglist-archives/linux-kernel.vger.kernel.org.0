Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA1963D16
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 23:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbfGIVGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 17:06:48 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41932 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfGIVGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 17:06:48 -0400
Received: by mail-qk1-f196.google.com with SMTP id v22so229517qkj.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 14:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=p+0iKIpxhtS7ONqpYVXoHpFJPdscdiTEJQgn7ZEifkM=;
        b=EZNfMS2Gmc5dJFFX6FnoVUd6/tB7z1Xkj19bXe5+6+yveOChvKOModxqdrg8Z+VW16
         ZlI0/XaWHSuxsvYtZEvt6wDcl3nuFx8vqil+JUQAviEGSw5IsMcjFQsiy2r9/5L7M8be
         n75eRyqbK1O5dputlsiOaROXEb1yCNdnHZruAbQmcRst+KlXXYFtFoyusfM6Z2xcRrPD
         jGlR27zfHVc0lHDkHV/PRL7//e3PbcpwTX7zY/L7gzfAYb2RDmcv8a5rcW9c0hPV1GMz
         FuGdGZjoDt/e8+1fJJT09eI8BaAoSCstxKAYMgZ30xgXOjuYAv9kKeSYJv/Bb6KIFNQX
         ZF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=p+0iKIpxhtS7ONqpYVXoHpFJPdscdiTEJQgn7ZEifkM=;
        b=eBCfYM+/c+S2/BQrxL3xwK7lYIihUKqEHn8ZGPgLid4uGGgUQwMGI8lNm4zoc3TuR9
         fDYmwDP8nUX9FdzLkdDvL7I+8EXV6FfziYjrQwZsVHMcBMOCq1y/DG8gAZ7AIxPW+dqY
         2QrdOcPP4TCzUKh/KQnUy8Km0ILtbcOAdnan4N9IXK5PWYwnRs5jRAUeko8oNOCF6mFe
         BJt3cDqKSZQMDqLIY74uTse6nKBhox/iuf8bNFlVaNPL11po/3/1/oQCF66FfbuWTggh
         IHtWrYox4uBJ8hkfN9fVs/lZTJHvH0Ucxp3HMh31grbcnII27BKb18yudKIaDl8gmJou
         rjoA==
X-Gm-Message-State: APjAAAU3pFd2ByRmh4Ui9EdkTg3os37RPWITvkL55cueM5fWFF+RXxJO
        GlqafAeIR2w37rsJPa85xyA=
X-Google-Smtp-Source: APXvYqwReSkVKUnYVb8h3Ezdd3eVWWwto1dEAbd73p13w0xBUvFRK5wMaabBqBcDZdeLWTaZOdXSSA==
X-Received: by 2002:a05:620a:1448:: with SMTP id i8mr20607337qkl.73.1562706407024;
        Tue, 09 Jul 2019 14:06:47 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:fa50])
        by smtp.gmail.com with ESMTPSA id g3sm66571qkk.125.2019.07.09.14.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 14:06:45 -0700 (PDT)
Date:   Tue, 9 Jul 2019 14:06:43 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Corey Minyard <minyard@acm.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] ipmi_si_intf: use usleep_range() instead of busy looping
Message-ID: <20190709210643.GJ657710@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ipmi_thread() uses back-to-back schedule() to poll for command
completion which, on some machines, can push up CPU consumption and
heavily tax the scheduler locks leading to noticeable overall
performance degradation.

This patch replaces schedule() with usleep_range(100, 200).  This
allows the sensor readings to finish resonably fast and the cpu
consumption of the kthread is kept under several percents of a core.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/char/ipmi/ipmi_si_intf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index f124a2d2bb9f..2143e3c10623 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -1010,7 +1010,7 @@ static int ipmi_thread(void *data)
 		if (smi_result == SI_SM_CALL_WITHOUT_DELAY)
 			; /* do nothing */
 		else if (smi_result == SI_SM_CALL_WITH_DELAY && busy_wait)
-			schedule();
+			usleep_range(100, 200);
 		else if (smi_result == SI_SM_IDLE) {
 			if (atomic_read(&smi_info->need_watch)) {
 				schedule_timeout_interruptible(100);
