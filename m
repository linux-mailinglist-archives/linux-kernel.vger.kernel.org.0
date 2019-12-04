Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85D25112906
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 11:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfLDKL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 05:11:27 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39656 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfLDKLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 05:11:25 -0500
Received: by mail-pf1-f193.google.com with SMTP id x28so3414871pfo.6;
        Wed, 04 Dec 2019 02:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=AGS9q87syTG/h/5Jp+lUoZikl7TZIXDyakUjgIECOMg=;
        b=Nir7y0q96JoVJC2p7nFzB0rUwvv9vVYqzv0ZO6AYRqJbrGzhxAIbrgwZxqx8JlltWu
         ckHbsEIG1xG0OxZxvznzLWIyBldX17e3p7o8/WvAHAoS+VQ+oGd8ecKYkWc1JDpvHOYQ
         nVA/7rhDMUQv/N6Y+4/yKbBS98nokZsc+Pto2rgjIGfivGwYp/QRJ+NDrtx6FyNrCWx/
         LVDoa0uVAihEp/wHo3GSCpTkkK8xxzhyrn4t1wOiM8nWtnVUnXtz8qZR1blrl/sdsdKW
         iNPyilK06YjBPBD4EAFRffEpyyvBmYkmFs2WNJxtd9xFTTON+YAilPOanFNrWmRNnq/D
         MjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=AGS9q87syTG/h/5Jp+lUoZikl7TZIXDyakUjgIECOMg=;
        b=GREoVVr1L0HYLmgj4WFbmOtDuQzEPFNL1UipfZr4EfobvD2HPIG5hegV3PPq3ZXSaA
         2hB80UvSqqsJp6UbbnPOy+V31FMxwVGdCi1Pxv8FNv0cKEL8iEH7iKTXuQSuJSqpqO34
         4byM1m9Z6MLg0tnZBpd1Zsg8/tZNs0cPR6xL7+K7ZBRaHdtfvQKtDssAWEnP84yRQHnk
         XUatchkL0r6xviXKEtOgcsRaznBI6nsjKKL99QcFIghCJUNo5xfRLC76Gxd/IExj1gPL
         7R8ZS5CZvUc+a9qHpvmi7qMQo7V/F8zq1HrB0p6THnJUxbJaiM42Ru4U6mvlKHEFk4vE
         EpgA==
X-Gm-Message-State: APjAAAUb1ZouRlBkr0+U49WuEOhekITLHSD7jFoCWRram+fqrEwnrZim
        oJsYCzTjcHcLoq9m8Gz05Y4R5+Cr
X-Google-Smtp-Source: APXvYqxr8tkwP4o8dBIsWZ9D5v+ZB2lmjogEymXMOHS7Js48JRyom4oRPJ0btznThpZgzyCuKWIhdg==
X-Received: by 2002:a65:578e:: with SMTP id b14mr2657273pgr.444.1575454285180;
        Wed, 04 Dec 2019 02:11:25 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 67sm7664259pfw.82.2019.12.04.02.11.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Dec 2019 02:11:24 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     baolin.wang7@gmail.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] MAINTAINERS: Add myself as reviewer for the hwspinlock subsystem
Date:   Wed,  4 Dec 2019 18:10:41 +0800
Message-Id: <0a6d0c22100da5196f00dfe0eb431e5e6d6d8c65.1575454108.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <808692052649aa2e80693a2734cb392e5eddd83c.1575454108.git.baolin.wang7@gmail.com>
References: <808692052649aa2e80693a2734cb392e5eddd83c.1575454108.git.baolin.wang7@gmail.com>
In-Reply-To: <808692052649aa2e80693a2734cb392e5eddd83c.1575454108.git.baolin.wang7@gmail.com>
References: <808692052649aa2e80693a2734cb392e5eddd83c.1575454108.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I spend some time to do some optimization for the hwspinlock subsystem
in the nearest past, and I am willing to be a reviewer.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 MAINTAINERS |    1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 061d59a..c2bd3e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7284,6 +7284,7 @@ F:	drivers/hwtracing/
 HARDWARE SPINLOCK CORE
 M:	Ohad Ben-Cohen <ohad@wizery.com>
 M:	Bjorn Andersson <bjorn.andersson@linaro.org>
+R:	Baolin Wang <baolin.wang7@gmail.com>
 L:	linux-remoteproc@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git hwspinlock-next
-- 
1.7.9.5

