Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3F8D31676
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 23:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfEaVOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 17:14:20 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37912 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfEaVOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 17:14:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id f97so4491541plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 14:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=N5VBbSDZXCG+FOI8GYS2ku3sBeJ+EZTRC3ZX2yAfkRQ=;
        b=fj3dqAqvGIC2JeWNLeqwvsSGzDYdILD9Tsteak9wAz2iwFC+WPLXoePw4kAuOE7IdS
         43W00Wn1BlP/h5RanltBT7IsUEBe7CtzthCb8h5rG5Eoc7+EJC8dKTkHRTF2TCZjwXb5
         EMqg6jfah9ulpADLvgg1kXKbnXTtgbKful5KQb4HSoTFdlU4NzLi3D1OXjuwrybO7DCS
         nUUmSyIpuper88cWMmvVkdO4XSB5u5jfs+l6wBn6E0rDJP7QdSmO/w9Jz4yL1a5dNNHx
         IW7Es+TAMuoJ8ZwsMIn97UzbuXY3sy+/GO+3cqS4RNGUP8ZyNfSDc2s/RYfLhx5AZCqo
         SJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=N5VBbSDZXCG+FOI8GYS2ku3sBeJ+EZTRC3ZX2yAfkRQ=;
        b=sXvwcBPz+99cKERBpFrJme9LhKruVA0l0FHTWDRrCUEK9C1IDeNHXnlCKsRFYhUAlc
         Sq9UIum0QKuSdvuWfDYzpT8Fxqgh/P+5ZRYIGATNyIZR0Nv99UfOhlCB5tTH35mX6wLW
         2rREFQ2UfaAgala3Tg9K78fgFbQ26/LU+AbDLjKQtyMAllZlzSYWDk0NELoCota3We+z
         wdeS9iAV4Qi6KARzo6gWmVSjdhD/S8S75LcphwMB+aomwDeop2IcowpXSh/nT9Mquy/O
         ZWxgbdza7MhZhtPGSp32A6Z/iE31qvG/T126atcJJjGC45TxYlZsUTf/98DkfeNMDkyC
         aGoQ==
X-Gm-Message-State: APjAAAWUjLV/eQK10agMFgblKrXbcaEdp+xHwtgKwr8Mk16lDw41E2jf
        LHQLBdw4OqUnhvMhQ0x35nc1+g==
X-Google-Smtp-Source: APXvYqwv+jZp8UCB4UL+JeIxlGPnPgk6wAfg5gBTl9hII57RjtxDKJiNGgCX1CAeTwZzlCkTlcFgiQ==
X-Received: by 2002:a17:902:9a4c:: with SMTP id x12mr11295810plv.298.1559337258592;
        Fri, 31 May 2019 14:14:18 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id u4sm51903pfn.144.2019.05.31.14.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 14:14:17 -0700 (PDT)
Date:   Fri, 31 May 2019 14:14:17 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Jonathan Corbet <corbet@lwn.net>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC] Rough draft document on merging and rebasing
In-Reply-To: <20190530135317.3c8d0d7b@lwn.net>
Message-ID: <alpine.DEB.2.21.1905311412310.81065@chino.kir.corp.google.com>
References: <20190530135317.3c8d0d7b@lwn.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 May 2019, Jonathan Corbet wrote:

> docs: Add a document on repository management
> 
> Every merge window seems to involve at least one episode where subsystem
> maintainers don't manage their trees as Linus would like.  Document the
> expectations so that at least he has something to point people to.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

We're in the process of defining the pros and cons of merging vs rebasing 
as part of our workflows internally and this is a great doc that does that 
with less words and more clarity than I did it, so very happy to add

Acked-by: David Rientjes <rientjes@google.com>
