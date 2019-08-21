Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00AE9972D6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 08:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfHUGo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 02:44:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30489 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbfHUGo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 02:44:28 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C943693E7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 06:44:27 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id k15so747780wrw.18
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 23:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=omPliZLuCRMscEE4W+freOK1QfBBdUKTD5kYd/YUcdg=;
        b=BhSG3GPpuoVcyQN/7LZCiSpuVLRW8/hbJFBCd3PoqsDox9iAoY5PqO1h6Zfpiet93k
         J1gHsbteuvP22o9Yuj5yI9bcai7Tz4+E6BQcpDDV9qCHrxVPql8tl+EpYZTYbr7Ab6vN
         MFK53v6XuraOotcCc8zpOir3+U+f5pLqXM2JWBm5OUFy8igxoTnxEhHofWieQXFfjuhH
         anjyEsYwevgGJon0ydf88Z60EJrgsOYCpZgYTWKDopSCAYJFFmq4UrapYpR9tiHHAieA
         8q0NeLNr56XbJoPmxeoE82qGKvyxFuhQ5x48Ln0V/L8qMsro/s21wxZntGpVRNldqRHY
         nfWA==
X-Gm-Message-State: APjAAAWvKg/Fri/jRb8frSJ64bS325XrGhSbTPKR66X4H9Jqx2uBBDte
        awOy0xW8U4v/SjExP3v638/UHDbVTwZjalOp0oGJZ7Y62l1RrY3DYWB1el5PmHkkfgORRWQeIXg
        Y1uapG7j+GG71TWjNuxlLJbm8
X-Received: by 2002:a5d:554a:: with SMTP id g10mr20274025wrw.9.1566369866147;
        Tue, 20 Aug 2019 23:44:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxYqR03pNTRAp+wDsR4GmDB89PRwmEWDmx3q4AiDqcJEbHN7AHpfZNwFSEws0FiTi+FZMY2nQ==
X-Received: by 2002:a5d:554a:: with SMTP id g10mr20273980wrw.9.1566369865792;
        Tue, 20 Aug 2019 23:44:25 -0700 (PDT)
Received: from localhost.localdomain ([151.29.237.107])
        by smtp.gmail.com with ESMTPSA id h8sm12733900wrq.49.2019.08.20.23.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 23:44:24 -0700 (PDT)
Date:   Wed, 21 Aug 2019 08:44:22 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     "Li, Philip" <philip.li@intel.com>
Cc:     Juri Lelli <juri.lelli@gmail.com>, lkp <lkp@intel.com>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "williams@redhat.com" <williams@redhat.com>
Subject: Re: [RT PATCH v2] net/xfrm/xfrm_ipcomp: Protect scratch buffer with
 local_lock
Message-ID: <20190821064422.GE6860@localhost.localdomain>
References: <20190819122731.6600-1-juri.lelli@redhat.com>
 <201908201356.Pffozrxv%lkp@intel.com>
 <20190820064203.GB6860@localhost.localdomain>
 <831EE4E5E37DCC428EB295A351E66249520CA35E@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <831EE4E5E37DCC428EB295A351E66249520CA35E@shsmsx102.ccr.corp.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/19 01:43, Li, Philip wrote:
> > Subject: Re: [RT PATCH v2] net/xfrm/xfrm_ipcomp: Protect scratch buffer with
> > local_lock
> > 
> > Hi,
> > 
> > On 20/08/19 13:35, kbuild test robot wrote:
> > > Hi Juri,
> > >
> > > Thank you for the patch! Yet something to improve:
> > >
> > > [auto build test ERROR on linus/master]
> > > [cannot apply to v5.3-rc5 next-20190819]
> > > [if your patch is applied to the wrong git tree, please drop us a note to help
> > improve the system]
> > 
> > This seems to be indeed the case, as this patch is for RT v4.19-rt
> > stable tree:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git v4.19-rt
> > 
> > I was under the impression that putting "RT" on the subject line (before
> > PATCH) would prevent build bot to pick this up, but maybe something
> > else/different is needed?
> Hi Juri, currently if the mail subject has RFC, we will test it but send report
> privately to author only.

OK. But, my email had "RT" and not "RFC" in the subject (since it is
meant for one of the PREEMPT_RT stable trees [1]).

Best,

Juri

1 - git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git v4.19-rt
