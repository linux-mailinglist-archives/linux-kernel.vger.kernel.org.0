Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92373902CC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 15:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfHPNV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 09:21:28 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41331 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbfHPNV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 09:21:28 -0400
Received: by mail-qt1-f194.google.com with SMTP id i4so6016534qtj.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 06:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7fbkwihLXGXUfSUCVgs/bzQtXmI2e46v397aoKmwXP0=;
        b=dI2ZRUmnzm/OQ7ydksBbmdAmwdFhghyE5zxE/88riTwrPr45hrTbh9qPDArvMDYkUd
         F7TAhHC0K17hpC59Kb70l7xnuvBK1ehXOYI4hmFKzPZ5LHf+F7ck89rsxd9+xqdKGAh8
         0OBJEVFpEL1GN8Lztfoc6pNfrOTZ64wRrEuOMnk/0d4kVcCsSAyJaDpzmzvVpuhupZWC
         MNv9nij6C3ZuxZ++UeOVAPidMEH48g3PpjPtYSEiIhc8CL1Dg/ITZ/+1++XljyUZqrgE
         EdXUpC3SfjQFqHODoe6tjrvYNFaAcubmOtJ7unkDEub/FyJ3DEXgLELKkaYHnCVq9bbT
         cjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7fbkwihLXGXUfSUCVgs/bzQtXmI2e46v397aoKmwXP0=;
        b=ryyv1x7AiBsueP5IOcBG0SmTOAVDeWqGhimbdmWibScTDRm7TEzxs1ftLT134ALLok
         MWQl+5tPjq5dDecN55OPsT/O7jYiu3GQhs5yBX9puKiapLamh+iuraJ72Ks/C4dySu8P
         Mx4roDcsGeafzZ+sShDjc32rMzUoY2v12DwVBRTG+0n6PhjC9oK3w/oycFY+kzkiRWQG
         dtEmhLfQSbAXSQNqNTk2gZ8x6NV49P9oiHsd01TtjuaILFveZ2clrwapUM92hYVsKefD
         5JtMMrGXv38PX9Q7iWc9TdvOkGnqS0/OEAB55jLreCSV1nxs9A5qahrcEMYvteVWSIBn
         hK3A==
X-Gm-Message-State: APjAAAUz0w88ZicnbTVajSRyp/3aQbRUACCDjlXNQ0Rp1LV+E25RU6/U
        H0RmeP0ftJe55SMDJd9Tw01WDw==
X-Google-Smtp-Source: APXvYqwUG3oxzHkWJiHLRirGSQ2MZcvdeSnSOLkA48d/eqFPbvANn+AgGCEMxoezPLFXYyOiwVvFFQ==
X-Received: by 2002:a0c:eec5:: with SMTP id h5mr1785518qvs.238.1565961687236;
        Fri, 16 Aug 2019 06:21:27 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::e5ca])
        by smtp.gmail.com with ESMTPSA id 18sm2924794qkh.77.2019.08.16.06.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 06:21:26 -0700 (PDT)
Date:   Fri, 16 Aug 2019 09:21:25 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        noreply-spamdigest via bfq-iosched 
        <bfq-iosched@googlegroups.com>, Tejun Heo <tj@kernel.org>
Subject: Re: io.latency controller apparently not working
Message-ID: <20190816132124.ggedqxrhi5povqlo@macbook-pro-91.dhcp.thefacebook.com>
References: <22878C62-54B8-41BA-B90C-1C5414F3060F@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22878C62-54B8-41BA-B90C-1C5414F3060F@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 12:57:41PM +0200, Paolo Valente wrote:
> Hi,
> I happened to test the io.latency controller, to make a comparison
> between this controller and BFQ.  But io.latency seems not to work,
> i.e., not to reduce latency compared with what happens with no I/O
> control at all.  Here is a summary of the results for one of the
> workloads I tested, on three different devices (latencies in ms):
> 
>              no I/O control        io.latency         BFQ
> NVMe SSD     1.9                   1.9                0.07
> SATA SSD     39                    56                 0.7
> HDD          4500                  4500               11
> 
> I have put all details on hardware, OS, scenarios and results in the
> attached pdf.  For your convenience, I'm pasting the source file too.
> 

Do you have the fio jobs you use for this?  I just tested on Jens's most recent
tree and io.latency appears to be doing what its supposed to be doing.  We've
also started testing 5.2 in production and it's still working in production as
well.  The only thing I've touched recently was around wakeups and shouldn't
have broken everything.  I'm not sure why it's not working for you, but a fio
script will help me narrow down what's going on.  Thanks,

Josef
