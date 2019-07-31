Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07D857D019
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 23:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbfGaVal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 17:30:41 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:42433 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfGaVal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 17:30:41 -0400
Received: by mail-io1-f42.google.com with SMTP id e20so6660452iob.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 14:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=LorXcbFrkDiur0GwKhOS0WtYPlhd7m6A9hFg1D5qG4Q=;
        b=Y+XYLq1GfpFsLdBp2odvBbnfZzGEE/EAyXfNcZDp6CRNDfB+xJ/SwxMyaaLKVBYn0N
         +jVpn09a5mkEl8XQG4Gi6OnmJ+6QOZEPwBvzaziIVbZuLdM4Gx+hUxXTHsBnrpA+F6ko
         W245s6uNCJby+pvNSQ7bsI9RWFURyKTIwAN9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LorXcbFrkDiur0GwKhOS0WtYPlhd7m6A9hFg1D5qG4Q=;
        b=VD0v7A9W7ouDl3PRtytbWqxLoLr9PrISFlvsHZsuU/W51P8ArIFKc366FL2C32FOEz
         Mkr6IMP3DTr+LpMVKXw2CMAZigrsATpHYy0o4KR5dy+9wlFAOe3kGdxBnmRcruZ68CKv
         cOBPZCjcWSuIKNFdF8hc7FCsGnyp13R5pUeBAaKWuQmTnhgGMsdMww2/6adS4GFpczuo
         aKVUe4R8HxDL2PqHotVOXNBuwjNfFwcA1IzRN+IDkFKaQC0E9NyGzpLRSxfpwQJH//Wt
         Y332MwPjAplDW18LJGqibZIOp4NWHuQZLmWKYHRUbF6a7Hs1bXvoKIcw89RTd3Q0Ekfz
         n80w==
X-Gm-Message-State: APjAAAXjT8Px2t3fstpmhpMl+5bK84ZgF4qqGLzy8BCRMJfRd83X0kda
        NhDLm4NLvD4I8oeyXr1PvXI5XSKWmJ0uf4fo+mpiwQ==
X-Google-Smtp-Source: APXvYqy3BKFTmjWzotYFCuzp4BPjn1MMaYy70Rlzz2fRaa9EbCnLYGgLAER+4pJYzAzQGEaU/wQqEBNu6KjKMF9N374=
X-Received: by 2002:a02:710f:: with SMTP id n15mr87971397jac.119.1564608640491;
 Wed, 31 Jul 2019 14:30:40 -0700 (PDT)
MIME-Version: 1.0
From:   Micah Morton <mortonm@chromium.org>
Date:   Wed, 31 Jul 2019 14:30:29 -0700
Message-ID: <CAJ-EccMXEVktpuPS5BwkGqTo++dGcpHAuSUZo7WgJhAzFByz0g@mail.gmail.com>
Subject: [GIT PULL] SafeSetID MAINTAINERS file update for v5.3
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

You mentioned a couple weeks ago it would be good if I added myself to
the MAINTAINERS file for the SafeSetID LSM. Here's the pull request
for v5.3.

Thanks!
--
The following changes since commit 179757afbef5f64b9bd25e6161f72fc1a52a8f2e:

  Merge commit 'v5.3-rc2^0' (2019-07-31 13:45:16 -0700)

are available in the Git repository at:

  https://github.com/micah-morton/linux.git tags/safesetid-maintainers-5.3-rc2

for you to fetch changes up to 7e20e910eabdf0af90fd10e712f15b413be8e135:

  Add entry in MAINTAINERS file for SafeSetID LSM (2019-07-31 13:58:11 -0700)

----------------------------------------------------------------
Add entry in MAINTAINERS file for SafeSetID LSM.

Has not had any bake time or testing, since its just changes to a text file.

----------------------------------------------------------------
Micah Morton (1):
      Add entry in MAINTAINERS file for SafeSetID LSM

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)
