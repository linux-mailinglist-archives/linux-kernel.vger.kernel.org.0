Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80F8A773E2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 00:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfGZWOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 18:14:07 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37925 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbfGZWOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 18:14:06 -0400
Received: by mail-lj1-f196.google.com with SMTP id r9so52873035ljg.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 15:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=tM6iRcvs2oyT/Wt34pW7ORo4I6mVuCJbX7XV+vt6GyM=;
        b=17VtZ02iyN18SKHkZeksu8ybrTXnDBYaB6pUGE0u2GqW19a3eN9TIX5k0/f4h9t5HO
         yaXE/S9pGdF+wFpa26PyPxUg6dlIeTtdcCQAGJTbWX2g+iDoVuWNdO2UuuuhL4v34lr+
         +vcixfn5Tgx3dXaOZpO476FinvXLRXCOJpOvvOu8uyAi7CroNjfwUVvEAQ7Ot5S4Yxxu
         NauuHeM7fEZKHAUNgLZRDGBQY3XrpcPU9ylD9xgzI7PxYIcF5CTnx0xazjGrOlg/ubPW
         sMaT3qyInNKzLouIUJ5BVIol2ligsh0hP3/xTi1c3dJ11XqDDkGutSrGnIuHt4chxJCY
         P6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=tM6iRcvs2oyT/Wt34pW7ORo4I6mVuCJbX7XV+vt6GyM=;
        b=rGe6iylVZxeVgLxh8d0MrxbwI30g8mNOPkSbIyS4SJjWMtoqX7lBcLgROZHwBd0rtF
         fpAm4B2uPcWMw9/wX9fZlXlA8RX3f7pgeDAnAZNy/6sTIgjWsONekXMDLqgN8fO76i3f
         nkMudM00AKCyJ6zPeCuE2Rs9BPQhJ82Wd5sF3eUDuuY5Rh2HVkMuRjr0LnH2vzu4uaPw
         p1mdeSI8YdZgM1je2TaxSipPFl0NallWE1u75tsOcqHbarcYmvqHmbNWSyGa/ItR5eZn
         5yOiMUjJOX00vjzRdLt8UMwUq32sxN2HwG0uzBAyN4yk5F10tPBnJmexMaw3+2vG8VTh
         CPdg==
X-Gm-Message-State: APjAAAWE4/SfIyhgTlCWHlEN3fd65zH88TIZKqDOcm5AK51E0QVwJ13G
        3cVbpVaHotMn6a4mqVOlhxwcgAeoZk8k4YjoIA==
X-Google-Smtp-Source: APXvYqzcW7BFPRKH5zQXIM0uI4BFE2T9Ag129+7Kta5szZyKk08AVmLt88TF2Pb++oK4r+lUCHS4epYfiPg/jw+yusQ=
X-Received: by 2002:a2e:9858:: with SMTP id e24mr27285211ljj.91.1564179244320;
 Fri, 26 Jul 2019 15:14:04 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 26 Jul 2019 18:13:53 -0400
Message-ID: <CAHC9VhQJ8oDqX09AdrvLJAgweaBcxETCw547CSiRyApRguXznQ@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.3 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

One small SELinux patch to add some proper bounds/overflow checking
when adding a new sid/secid.  Please merge for v5.3.

Thanks,
-Paul
--
The following changes since commit ea74a685ad819aeed316a9bae3d2a5bf762da82d:

 selinux: format all invalid context as untrusted
   (2019-07-01 16:29:05 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20190726

for you to fetch changes up to acbc372e6109c803cbee4733769d02008381740f:

 selinux: check sidtab limit before adding a new entry
   (2019-07-24 11:13:34 -0400)

----------------------------------------------------------------
selinux/stable-5.3 PR 20190726

----------------------------------------------------------------
Ondrej Mosnacek (1):
     selinux: check sidtab limit before adding a new entry

security/selinux/ss/sidtab.c | 5 +++++
1 file changed, 5 insertions(+)

-- 
paul moore
www.paul-moore.com
