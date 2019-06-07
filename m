Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4C183982D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2019 00:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbfFGWFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 18:05:18 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40877 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfFGWFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:05:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id a93so1316490pla.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 15:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C3WCTEPJuMhnDtyj4nCQQWf8hst+6hFcFTW9HCjkuQc=;
        b=eQ8X5t7ShcbHZ2iAaeihT56yVGm93DJwoGdLe+RAL+T33ZJeM5dpHTBSOFHnV6exd2
         McjPg9HRK4VzL2d97TDKLdk4cgN6l4tkjv6zJgwUwj1poxqn1D4faGt9f0dgLEJvD4kI
         nlj2hFdkXuXE9V6dflG5xHbpe+pelkqjFJDVStQgh4TZr8C3CXVWdShiPtMOmz92io3F
         G/7PZiS1LCcwJLyHB6DMjE+r1mSTqQMSaVXt4uniH3d8iUxxoPLLsGtjpKOqkzsTcqbY
         izGdDivK3ySoKFH5HXbVfJ1MkBO+mwjFUh9lObsesRKIEoo/4P5NBkxPi/L9gGPIPE7F
         GoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C3WCTEPJuMhnDtyj4nCQQWf8hst+6hFcFTW9HCjkuQc=;
        b=ibG/TX7pXPRt2F5N6JlgQCMxEDSHEjP+zlP5+PAohwir/XC6RNg6HZEZY3d+Qd0Rfr
         I60KfZiasrtUJGk4Zj5dPwtS7lbJI8+ES5jiIt9L36k8uOjO1N1ke8x/OC/aeSB2LveO
         /LfrOpX1UMJneLelOyq1rQmMzr23LqXbPpQnwxeP6t+rhXTCs2zSNu3LB9UYpYpp+19J
         nPPRxzpOzPW1ggnTWu78UbV4easJQWtuWwqFZffjkqc+ijVIn1dXEB/JkyWAx1TIoN+Z
         zEHVDbcoo8P8mmSEWCH4jTCcPkrSvj86zREg13yyRIWOMKQMUXmtB8H+LMg01ERMt5M+
         jKaA==
X-Gm-Message-State: APjAAAXujCS4l42+WUFCvG7dHn6HceVKCHdQv3yxDDzlYes8BPK4aAmq
        IFG17wbnyv/XGAsMxBpl+ok=
X-Google-Smtp-Source: APXvYqw79sGEGu7vaJbDLnMprFiFeHzfXZWGcQnVHInNP3xeYbkjRgBIAgRsCI7J7qswMroRiib5FA==
X-Received: by 2002:a17:902:6ac6:: with SMTP id i6mr44253449plt.233.1559945116817;
        Fri, 07 Jun 2019 15:05:16 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id d3sm3843748pfa.176.2019.06.07.15.05.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 15:05:16 -0700 (PDT)
Date:   Fri, 7 Jun 2019 15:05:18 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     shengjiu.wang@nxp.com, timur@kernel.org, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC/RFT PATCH] Revert "ASoC: fsl_esai: ETDR and TX0~5 registers
 are non volatile"
Message-ID: <20190607220517.GA3824@Asurada-Nvidia.nvidia.com>
References: <20190606230105.4385-1-nicoleotsuka@gmail.com>
 <20190607111244.GE2456@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607111244.GE2456@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On Fri, Jun 07, 2019 at 12:12:44PM +0100, Mark Brown wrote:
> On Thu, Jun 06, 2019 at 04:01:05PM -0700, Nicolin Chen wrote:
> > This reverts commit 8973112aa41b8ad956a5b47f2fe17bc2a5cf2645.
> 
> Please use subject lines matching the style for the subsystem.  This
> makes it easier for people to identify relevant patches.
> 
> > 1) Though ETDR and TX0~5 are not volatile but write-only registers,
> >    they should not be cached either. According to the definition of
> >    "volatile_reg", one should be put in the volatile list if it can
> >    not be cached.
> 
> There's no problem with caching write only registers, having a cache
> allows one to do read/modify/write cycles on them and can help with
> debugging.  The original reason we had cache code in ASoC was for write
> only devices.

Maybe because my paragraph doesn't state it clearly -- it's nothing
wrong with regmap caching write-only registers; but it caching data
registers would potentially cause dirty data or channel swap/shift.
So the reason (1) here is "cannot cached" == "should be volatile".

I will revise the commit message for review and fix the subject.

Thank you
Nicolin
