Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1057A6CA3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 17:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfICPOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 11:14:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbfICPOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:14:01 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5B9B3C057F88
        for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2019 15:14:01 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id i19so19216741qtq.17
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 08:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CaPZ1zkWwINlsmN10NDJY2kQHdXVRLZB3mGk6bOHXV4=;
        b=SvXaVaBbPDZqKA4zUuEkJpd7vbsWBPzmBbW7daSsSxi3G9sfbWQ2vfEWqmQx5xun6U
         kCraD3qTpPkspCSvhlmQtUHjBHxSD7R3V1ohW9tA8EYKUki1yNMUuFoGrNDMFfYDKK+E
         ucR9rVQA5OUP0Zpok1l+NdDyAnwpWsen+rh+TrdbdrRZXsMKZwcnyC2iDCPnB1mz9vSs
         Pk6LdVaeqKs5zcmfkKZd9mnJOjb6qLPDshu5emBCWO/5jFB07V5qF5SQEzcU1AYy5tDA
         vmTUeHTAyJyLZDJHVrV4vOn4S630/CYc1GhvhA0npCLNXJ/fEO6JQOdRq3lgZ2NZp2+Y
         hcfw==
X-Gm-Message-State: APjAAAV8g1w0fCEEFxP/7HOqCEqXOTllvn+n67zMTUnGl2bT/17CLWrr
        68Ih4o6tCiH1M2aIsTZB39A5zoCEV+ZAqd3u76UP/EZT+XdO7pYVO5xV/z7dObcCuuTM7WIasy0
        2rexAsOXH6DXV8PXEgjiLsoKGYwVrJFZURxTpF/qC
X-Received: by 2002:a37:6756:: with SMTP id b83mr12785607qkc.170.1567523640750;
        Tue, 03 Sep 2019 08:14:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyAtP3KTpDw6MJmnw+mTpEUCk0L7u6deDIOslI5akLbIxzDuWVhXLPbeq9LcRcqgABTlssXjj2hrV0WTZg4FGc=
X-Received: by 2002:a37:6756:: with SMTP id b83mr12785584qkc.170.1567523640616;
 Tue, 03 Sep 2019 08:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190702083931.7392-1-hadess@hadess.net> <2505a7c3e29afb5a140ed47e54ea9c72d0192367.camel@hadess.net>
In-Reply-To: <2505a7c3e29afb5a140ed47e54ea9c72d0192367.camel@hadess.net>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 3 Sep 2019 17:13:49 +0200
Message-ID: <CAO-hwJLGfvNMgV9eU8xAur+a1NbvtV62gD2XVY6WXdOKrx0JUQ@mail.gmail.com>
Subject: Re: [PATCH v6] HID: sb0540: add support for Creative SB0540 IR receivers
To:     Bastien Nocera <hadess@hadess.net>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Bastien Nocera <bnocera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 4:15 PM Bastien Nocera <hadess@hadess.net> wrote:
>
> Hey,
>
> On Tue, 2019-07-02 at 10:39 +0200, Bastien Nocera wrote:
> > From: Bastien Nocera <bnocera@redhat.com>
> >
> > Add a new hid driver for the Creative SB0540 IR receiver. This
> > receiver
> > is usually coupled with an RM-1500 or an RM-1800 remote control.
> >
> > The scrollwheels on the RM-1800 remote are not bound, as they are
> > labelled for specific audio controls that don't usually exist on most
> > systems. They can be remapped using standard Linux keyboard
> > remapping tools.
>
> I'm back from travelling, so ready to update/respin this patch if
> needed.
>

Nope, looks good now.

Applied to for-5.4/sb0540

Sorry for the delay, a mess in my mailbox hid the v6.

Cheers,
Benjamin
