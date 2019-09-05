Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E57B8A9DF4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 11:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733095AbfIEJN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 05:13:27 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:37164 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732963AbfIEJN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 05:13:26 -0400
Received: by mail-lj1-f175.google.com with SMTP id t14so1650177lji.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 02:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lg+YMpq+gNDI7xAM1SDSvOeQlpL3bUFXipKQWY1s63k=;
        b=shXHw/QY1ASWgitkU/tyiV7VOOMF7hyYLjT/iDUwItxDaP1N7LClS0e8XHmU+qY8W1
         9fdyt2mAYLROze4tMA1n7IKnlShLUrDVatCS0Tf6bsDIqs0wLlrmbe3LZE7DvEjYpIG1
         F2H7V0ziSg7Y3DLAjPmYr9TmkRgQvjUVxVW/C0UyQ1BM109wmTUmuappdobvU1Os1ZE+
         fthm3RK517nRHJTaFe+RS5LNydSxIFe+aoCxTZhndemSRkm5FTpBOjG2F0rUpOgRqH/M
         oa1R0RY6KpeXYbSeMamG1o9o9b4L5pUVWr4Q6IwP4JCCUoywOk3RJhVsYzxVCiGHnN38
         xK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lg+YMpq+gNDI7xAM1SDSvOeQlpL3bUFXipKQWY1s63k=;
        b=djtc/x4TOa8+8rR1ExfmaGzYhQhcWuHJks9yKGlESKAO9en+0HGc3X/OJJO1bRePH9
         WOx61SJIfeMjL1jk5awJYNdc97cMeH1kZXysoM3PQmbpq0aUVy8ysvTAWEG9za5mxyW6
         uMXHpmO6dDZi8xiGnaqHEXMF/EKzSNsDLxCXe14YnSWC46icy7DrCSVmU3xCRWBGBcf/
         eu+wGSx4S/1hINXdh3mEQN6+1w5L6l/dkuUWbBnPIcfK87MhIshYkBeQyKuvzQ/kYme3
         i5Bynk8qmJr7Qv5vFx1IS+kyyvUxAU9EJoYLa1/TVSheYJQdrR5TssvOnB3HmULjadZS
         RzOg==
X-Gm-Message-State: APjAAAX9OLmSpIviw45duQWudZZTqMuu7KVdeaGIoqWLHpxgbkCBgKi+
        5LG73FRVl6deqh8uy27Puwcs6N4lCx7/vPICfPN75A==
X-Google-Smtp-Source: APXvYqxs7StB/zHZBT6cbVWDGsXZppnf8u0EPpozPSsrwy7Sjyo5pTckCUC8G6y1E9FCq8UFjNZWbaplA6eKwnLCr/M=
X-Received: by 2002:a2e:94cd:: with SMTP id r13mr1349759ljh.24.1567674804268;
 Thu, 05 Sep 2019 02:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <7C6CCE98-1E22-433C-BF70-A3CBCDED4635@lca.pw> <20190903123719.GF1131@ZenIV.linux.org.uk>
 <20190903130456.GA9567@infradead.org> <20190903134832.GH1131@ZenIV.linux.org.uk>
 <20190903135024.GA8274@infradead.org> <20190903135354.GI1131@ZenIV.linux.org.uk>
 <20190903153930.GA2791@infradead.org> <20190903175610.GM1131@ZenIV.linux.org.uk>
 <20190904123940.GA24520@infradead.org>
In-Reply-To: <20190904123940.GA24520@infradead.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 5 Sep 2019 14:43:12 +0530
Message-ID: <CA+G9fYtwEfp482+8qzGKD9NSHOGtKyp4pKbVxQK8G4L94UvOVQ@mail.gmail.com>
Subject: Re: "fs/namei.c: keep track of nd->root refcount status" causes boot panic
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Qian Cai <cai@lca.pw>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph and Al Viro,

Linux next 20190904 boot PASS now.
May i know which patch fixed this problem ?

- Naresh
