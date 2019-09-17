Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7C0AB498B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 10:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbfIQIbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 04:31:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40393 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728906AbfIQIbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:31:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id b24so2012657wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 01:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Yvd80cqDC7g7H/3EGDdUC4+VFqTvhuXauCbBSXd4cKQ=;
        b=m9rM+oJUxhFcRzvtzjy/b03fyK0MatUXoMTP9FtAwjLXnD6dShihpi6S/onI1oOhV/
         Mx2RNhcstTmfbx+3xLB7tBwCGyi+TN360USzfuG9fWN/aiBGOMhXaUge5vW6rWYoIwsw
         RyoYVbM7aUjqBKmBi9RIMcf4EpOi2yHlMhMpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Yvd80cqDC7g7H/3EGDdUC4+VFqTvhuXauCbBSXd4cKQ=;
        b=mGuEMgRPr9cfOh0O3/tELrt9+QHzTLcujiN3vVuMbsnp4ARwm6kujDa1BNmPRaAhDm
         Y44ei9t2J6NMaTNUGEhwmiixSk1OR5mWcBW8rtfr1iOypi04IgwF9c+TOoBh/zG2T5N9
         pnWPcIOTMmDuyiFlP8KtbCOJZHLlrZEfVZ8Um9SHIRl3bjUpRKkPpuucf6/W8lecohMm
         Vk9F+IdQineFeE5PTBRltdyUr3z8c3IAhLIJ1L79vEhxHKVerzc8fzPOHTFAgJYOdbaI
         daGYj7yjDiOqr1ZdTaHdQV0/Soji9QxxbGr12VcgKhEh7Em0PAZhvsNtJL4DFzzEEjNU
         Diiw==
X-Gm-Message-State: APjAAAXg8YNiGX+kjZYbJivbObsKYS9CwDORLlUht4YKN2IMtIYxur06
        l38Q2OohKWSsV8drbGeWSEo08g==
X-Google-Smtp-Source: APXvYqxhY4IauqcE6+bMW3Vzuz9urpQh9TOpjOry2a1gYoCQgrUeWJVIoSvMOTh1Myigya4XWNS7LA==
X-Received: by 2002:a1c:f916:: with SMTP id x22mr2499436wmh.69.1568709103043;
        Tue, 17 Sep 2019 01:31:43 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id e20sm2405568wrc.34.2019.09.17.01.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 01:31:42 -0700 (PDT)
Date:   Tue, 17 Sep 2019 10:31:35 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 5.3
Message-ID: <20190917083135.GA19549@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.3

Fix a regression in docker introduced by overlayfs changes in 4.19.  Also
fix a couple of miscellaneous bugs.

Thanks,
Miklos

----------------------------------------------------------------
Amir Goldstein (1):
      ovl: fix regression caused by overlapping layers detection

Ding Xiang (1):
      ovl: Fix dereferencing possible ERR_PTR()

Mark Salyzyn (1):
      ovl: filter of trusted xattr results in audit

---
 Documentation/filesystems/overlayfs.txt |  2 +-
 fs/overlayfs/export.c                   |  3 +-
 fs/overlayfs/inode.c                    |  3 +-
 fs/overlayfs/ovl_entry.h                |  1 +
 fs/overlayfs/super.c                    | 73 +++++++++++++++++++++------------
 5 files changed, 52 insertions(+), 30 deletions(-)
