Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2693714C9F0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 12:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgA2Lxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 06:53:53 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:42300 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgA2Lxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 06:53:52 -0500
Received: by mail-wr1-f41.google.com with SMTP id k11so5149959wrd.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 03:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Y05EfyJNi14bOEE5ZvYiIMjjtZ7yNSpp/7KfSnBt91Y=;
        b=miJIWpJyg5dYTUaRZ0OB503gPB7VG6lsvE+0dGkzHgkJgvxwvRYdEhCxsJ/kj2K16f
         ESSJF5Y8IAjB3XtAcPc6QCRFeTS8w2iChXQIe+xBX1ETpm0qO+RHwW7As/JUq+Ti/aNC
         Mi2Ot+RxDv2F16FyMreM/fxJ5Y88QxpuKWRBmbD28yWwLkhFSPQ2GNH3vm1AwWgGWApb
         fNWAavYovqIR/X7MVJ3Yj05y4mwErl8nyqizdT9qOe9nDjLzMdUCL+TPTA33YBaAffus
         E6aYjRNaFsL3G/yQLSt82jYB1nZI6u4yuPLL7MZTSPHtsWZRBbVaP8GjOmvU/Jh1FWh0
         ELug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=Y05EfyJNi14bOEE5ZvYiIMjjtZ7yNSpp/7KfSnBt91Y=;
        b=jyRiO47CptQZVXMrDhxyR1FBT86d+lAQHpXEii0L+zros4GHIy87NTqDPkJjgiUtA/
         x0Y8HRPwd5gOBLHAwlasWjRkbWUge9gWjlpdFSjBgcG/v06Uvg4B0jxSnHF/y+n7t3Ik
         cg3wAejQxp7MWnBRP3FRJl9Ey+fLnQiBD81EUIU73xLKjPkCwvRVAAcUQ3+bAdVcXFFr
         z+x/qWvbWDUV1XO1wn6F63DBze1YBGQBXBObGERqPJSqlN6+VJFYOhhG7IYcHxxs7UGd
         VLBcFLh3b4H0ZjQk90rJKYKF7mZ2iPXeXdw5gcOuXlniW4a/NJbzuYxv0ARR+YMlZfBP
         RO3Q==
X-Gm-Message-State: APjAAAVKAArnH6+L3MRFonGjEm0OuzGXLtn5K9c+wiBK5kMO58OhKSjX
        NuNJtA11z22KGFXpwm8S9iXGvH1M
X-Google-Smtp-Source: APXvYqzNkUJ7IzGACqFO5elTneGAD+WiGqJOg1NhNxCM78Ka0Gy+hdpILUvoFbzWqbc8DLuWKuigsQ==
X-Received: by 2002:a5d:4f90:: with SMTP id d16mr35064320wru.395.1580298830796;
        Wed, 29 Jan 2020 03:53:50 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id b10sm2545053wrt.90.2020.01.29.03.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 03:53:50 -0800 (PST)
Date:   Wed, 29 Jan 2020 12:53:48 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] core kernel fixes
Message-ID: <20200129115348.GA128016@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

   # HEAD: 74777eaf7aef0f80276cb1c3fad5b8292c368859 Merge branch 'core/documentation' into core/urgent, to pick up single commit

Three objtool fixes, plus marking SFI as obsolete.

 Thanks,

	Ingo

------------------>
Josh Poimboeuf (1):
      objtool: Skip samples subdirectory

Lukas Bulwahn (1):
      MAINTAINERS: Mark simple firmware interface (SFI) obsolete

Olof Johansson (1):
      objtool: Silence build output

Shile Zhang (1):
      objtool: Fix ARCH=x86_64 build error


 MAINTAINERS                 | 5 +----
 samples/Makefile            | 1 +
 tools/objtool/Makefile      | 6 +-----
 tools/objtool/sync-check.sh | 2 --
 4 files changed, 3 insertions(+), 11 deletions(-)
