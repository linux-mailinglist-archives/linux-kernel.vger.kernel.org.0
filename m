Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E03E14BF2C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 19:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgA1SH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 13:07:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44829 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgA1SH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 13:07:58 -0500
Received: by mail-wr1-f66.google.com with SMTP id q10so17140921wrm.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 10:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QPCuI/or6wdJJoyAUoVh8dctP6+KzRdtWWX/rDq6bUU=;
        b=VP6P1PCflJJqraBHxidWkOdFjd/QgZRXU2w2tBK60xRjdVeTD0re9EN/ywVccoJPP0
         R7F3x7rrHdU8mdEbfHWElVXNoyNA3QQ17Tf17gOag//QvULaWPy35kWphNec+U1hjusE
         6ndK5E307lkjLFWxPXLSL7o4D+jrLAcqL4KsU53ZRkrp9l48YCCCdokFvbZBiDcT0i8I
         H5R7fuWhfb+Gu52yeKQOZoCxGQCOYSex9d7bU3wU1LREDnzpD8+92uVBqsoTxX9AKUmh
         9iqM92OYMDdXxyOseJGr522QFzFYKPsP5DZUlwaMhU8TpUcspZruXzoZgvx/P5EqwhBs
         cyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=QPCuI/or6wdJJoyAUoVh8dctP6+KzRdtWWX/rDq6bUU=;
        b=Dgn0PMcXspma++3thSxPr1cajg3FepycWJaxmC+blPwY6JL3+JDWajtXCtF2ltdZLW
         9Jxb8KMTLWcAeT5bKlZ6cTcFfAQcscKRRjSQuRotLmFKK/V5Tl4hlTt5P+rN0W/mBUgV
         aAFwXAd15HltOgJbvWwAHrS29vXzfgdYLtdeOk9H6yIK81jAvyrCTFwVUYIkIpqkbaSq
         OrDBVPb5+Ix/i22PtvkToRDJdHfxmQaAyGtmohKhGvrEWwBzRy2A7azns1CSkAt0A6O/
         dgxs1/VXgZ9q5Qj5JJL1LRO3pDxXznNekUIVUFpYX6SuK6oN49M6zAtiM+WqHU1c2CCY
         kUZQ==
X-Gm-Message-State: APjAAAWTNfOJ6F7mVTjISedQjdpo/dHLFAaC4ORKs5KjTeH6PHZUsn4b
        y1fHDZZ9mn6hhUeI1L3xP9E=
X-Google-Smtp-Source: APXvYqw6wEGKZtPJSdWhMkgOtoMfX8TELcMS0xwGmidmgmlVcRIOjqUAUHo5K3aPlqzhYEVW50kHhg==
X-Received: by 2002:adf:fd87:: with SMTP id d7mr31680223wrr.226.1580234876796;
        Tue, 28 Jan 2020 10:07:56 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id e18sm26837291wrr.95.2020.01.28.10.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 10:07:56 -0800 (PST)
Date:   Tue, 28 Jan 2020 19:07:54 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, bpetkov@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/fpu changes for v5.6
Message-ID: <20200128180754.GA104974@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-fpu-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-for-linus

   # HEAD: bbc55341b9c67645d1a5471506370caf7dd4a203 x86/fpu: Deactivate FPU state after failure during state load

Three changes: fix a race that can result in FPU corruption, plus two 
cleanups.

 Thanks,

	Ingo

------------------>
Sebastian Andrzej Siewior (1):
      x86/fpu: Deactivate FPU state after failure during state load

Yu-cheng Yu (2):
      x86/fpu/xstate: Fix small issues
      x86/fpu/xstate: Make xfeature_is_supervisor()/xfeature_is_user() return bool


 arch/x86/kernel/fpu/signal.c |  3 +++
 arch/x86/kernel/fpu/xstate.c | 18 ++++++++----------
 2 files changed, 11 insertions(+), 10 deletions(-)

