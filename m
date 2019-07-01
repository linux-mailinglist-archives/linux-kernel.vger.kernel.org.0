Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7B03B6F6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 16:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390727AbfFJOJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 10:09:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389171AbfFJOJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 10:09:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F01F207E0;
        Mon, 10 Jun 2019 14:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560175789;
        bh=ZAdzIptRY5irvM99E4Rd4sa4j4ZDbKjnWVOozitc7jA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mUWo8Wug7Wud6ryWjivz2LO3St7mSAblmp81R6eSmB9pMqPwNqr9/hEvrQtoKgD8r
         2SI8V7RcQCjJMZsl9MuOpLwLMKaFMv7Vd7tOO07735Cotp0leXUGw/rND9MJUH4cUB
         sR3w/GcCm4K4H571eyof1Ot/MQnVh4RdsCBp/TpU=
Date:   Mon, 10 Jun 2019 16:09:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     devel@driverdev.osuosl.org, YueHaibing <yuehaibing@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 -next] staging: fieldbus: Fix build error without
 CONFIG_REGMAP_MMIO
Message-ID: <20190610140947.GB18627@kroah.com>
References: <CAGngYiU=uFjJFEoiHFUr+ab73sJksaTBkfxvQwL1X6WJnhchqw@mail.gmail.com>
 <20190528142912.13224-1-yuehaibing@huawei.com>
 <CAGngYiW_hCDPRWao+389BfUH_2sP4S6pL+gteim=kDrnb9UDzQ@mail.gmail.com>
 <3f4c1d4c-656b-8266-38c4-3f7c36a2bd7e@huawei.com>
 <20190528155956.GA21964@kroah.com>
 <CAGngYiW8Y3jt9ikb5e9LtfSkquZquLgB5iSRVXyka9fUXLrqYQ@mail.gmail.com>
 <CAGngYiV9XsPL8Mk9_K9=0a-k6P6JN_waJvk5bDH+mDwGMAYbmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiV9XsPL8Mk9_K9=0a-k6P6JN_waJvk5bDH+mDwGMAYbmw@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 08:51:10AM -0400, Sven Van Asbroeck wrote:
> Hello Greg, just a friendly ping regarding this patch. It got my Reviewed-by tag
> two weeks ago, no further feedback from anyone. Is there anything you would
> like us to do before queuing this?
> 
> Link to v2 that got the Reviewed-by:
> https://lkml.org/lkml/2019/5/28/609
> 
> On Tue, May 28, 2019 at 1:31 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
> > For the v2 patch:
> > Reviewed-by: Sven Van Asbroeck <TheSven73@gmail.com>

Odd, sorry, must have fell through the cracks, I'll pick it up now.

thanks,

greg k-h
