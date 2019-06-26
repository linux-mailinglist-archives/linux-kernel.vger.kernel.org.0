Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E487556B73
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 16:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfFZOBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 10:01:16 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36785 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfFZOBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:01:15 -0400
Received: by mail-qt1-f196.google.com with SMTP id p15so2460737qtl.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BA3uP6UgDm/mAQcku8N1cgzRBe1OWyg/4vbkTvXQlT4=;
        b=e80B9uUbcZlc8oBXlplXQG2t4wv0bfJCY1Hvdz04UajojzPpaJDUqIIMajjUA5vVfb
         XlwF1nm+OgZlHEZqB17i/GgqZQuaA6VOWarowyHZhfCBXXVyBY4E8/defTsbo2hEg4Ru
         2XGusBWEpKW7/IbWNCiZ+nCF6heDq6cNDZXHUmL5lMG2mZOSMJuw1d1RNRg3x1Ram7g2
         5uslc6xC44K5bWhkM2MDDActklBT8KG1ywLJ0DtP8d42zc7SJ4pU80XoZp6u4tJb5QLv
         VP056gdTbzoB6b+zNetlM3XaMEec0hWJavzBpOZwfmG3ctlt1uREzm7UazQS0yd+drOe
         myYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BA3uP6UgDm/mAQcku8N1cgzRBe1OWyg/4vbkTvXQlT4=;
        b=uJIxHpz6M51GAO0M31Bxr4lT55dO/a3pr8fIcuavLRQrQh0aH+GEg5ZAisjJuDvHHP
         CLJ/dBSGha22hZokH1DJTfMrcOzKJ/PrUAJYARXr2RZHMtscGmBzLy3ZC9UNcUlI9Jw0
         O/gS4ZCl2fWKTyMcFaOckcwyVWwTheabR11QJ/mL6Joek2P28xvm76La4TvUBLSBnEd8
         o8klVl5yDZCMJJDY5fODKhfMKWgnowUhB0K3KExHc5kZqa4XXgtTDbxMrufbYNVoMMPg
         ff6ExYv7FH4qOrUBiNRaoS80CAMPyDsXgumkpzTD7en0X/lb5ba8Qy00XRbEbRyKAK+o
         P+Rg==
X-Gm-Message-State: APjAAAXgRULVDQickZ0F+TIqljkGmtNJADJi2DMI4ObOpXDmvPSxWArg
        7TsmexHzL7dTmavUfcEaRx8=
X-Google-Smtp-Source: APXvYqwuKnJRXPujB0mz5pe3tc6XJASAmIlm8quC0oPvyghXhKHMSZkfgT72MrFTvZxLwAW+Ki1y2A==
X-Received: by 2002:a0c:bd91:: with SMTP id n17mr3642103qvg.128.1561557674542;
        Wed, 26 Jun 2019 07:01:14 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::953f])
        by smtp.gmail.com with ESMTPSA id p13sm7994630qkj.4.2019.06.26.07.01.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 07:01:13 -0700 (PDT)
Date:   Wed, 26 Jun 2019 07:01:12 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/6] workqueue: convert to raw_spinlock_t
Message-ID: <20190626140112.GU657710@devbig004.ftw2.facebook.com>
References: <20190613145027.27753-1-bigeasy@linutronix.de>
 <20190626071719.psyftqdop4ny3zxd@linutronix.de>
 <20190626134957.GT657710@devbig004.ftw2.facebook.com>
 <alpine.DEB.2.21.1906261551190.32342@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906261551190.32342@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jun 26, 2019 at 03:53:43PM +0200, Thomas Gleixner wrote:
> > I don't now what to make of the series.  AFAICS, there's no benefit to
> > mainline.  What am I missing?
> 
> there is no downside either, right?

Sure, but that usually isn't enough for merging patches, right?

> It helps with the ongoing RT integration into the mainline kernel and we
> would appreciate if we can get the non controversial bits an pieces sorted.

I see.  I understand the intention and it was a lot clearer when the
changes were beneficial to mainline kernel too and I'm not sure this
is a decision we wanna make per-subsystem.  Maybe I'm just out of
loop.  Are we generally doing this?

Thanks.

-- 
tejun
