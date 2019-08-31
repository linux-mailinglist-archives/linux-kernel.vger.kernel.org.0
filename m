Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 583F8A4171
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2019 02:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbfHaAvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 20:51:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39833 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbfHaAvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 20:51:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so4333781pgi.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 17:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=1wQe6nOU+rm8Hxhio/8zXXhtjYpsRY4PCoDEXh11uU4=;
        b=Z6QHLAgjM/qzsYesJS7JVXGXYcDJmCI28hBN9xNL0wH2Zpefv8aVty2b0WGbuVPeVd
         w6XEzfxm987SdrLAui97QupWlgcfvsUyAmMrPDESqNxpdWl6YcbDo3dZu4zQTzjARYDT
         wIgqLzV+q51DbUAFcmoyncxzXhN6T9gpFpHYBr0BaKpdrYNx2Ly8ppruAspzvLXKLRQG
         Ij5i69SJPa+t1/exPKJ46wO54H7LPJ4r2aQ6uwmo7mrv+VRgCGbFL38nqixK5YmkEgLt
         m9eEJptb2r6qlMGxfYyTq7NtJvTevRHwuKAuiN/RpyjFIwS7BM/YP40Oicdijw3RljG/
         wIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=1wQe6nOU+rm8Hxhio/8zXXhtjYpsRY4PCoDEXh11uU4=;
        b=X0LKeYfXmNTS1vtGLyBuUDPB2mPy6BlP4sDia7KbX3+Srs/Yq62T27cpa26h2YwwRB
         OvomZ1Y0/XqUFdTpwJ2/hUQoftuL08WRaXJe7eOSs4543OK2z8KSyiYncq5OPjkTn1Nn
         CTCNGQ6QKyXN1nnab+TfCI7c8CEEXc9kCeDTXB4S/YsVN6M/ba/Eesnq973I1eBJg/NP
         BneQN5vF/zBDMv3POTxJuqxEbhfleqYjQ4ePGa6LPbWvpE2TDtiN03q6VEF6RskmDbFL
         OehqlqB+Tlsyhel1itG2l1SeHfu1mE7A86cxk58uyCp+bkrQJN6Aot3HW1ZwS8GKF0VA
         bXGw==
X-Gm-Message-State: APjAAAWVD7LDL9IzjgUz1bL05D/utcPg9VFgi/laWloVZI34j0o7U7M1
        uG9xOXHillSGeKe8H5W5bnLyV/SFS34=
X-Google-Smtp-Source: APXvYqzbEbim+0Iu1USz/ypElWV0TkMQXJw+Fa4PDaeM5FvZyrI/nJdpLnxouqdSqHdj9yMeReJyew==
X-Received: by 2002:a17:90a:be06:: with SMTP id a6mr1305657pjs.92.1567212669878;
        Fri, 30 Aug 2019 17:51:09 -0700 (PDT)
Received: from localhost ([76.14.1.154])
        by smtp.gmail.com with ESMTPSA id 138sm8932171pfw.78.2019.08.30.17.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 17:51:09 -0700 (PDT)
Date:   Fri, 30 Aug 2019 17:51:08 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: add arch/riscv/Kbuild
In-Reply-To: <20190821092658.32764-1-yamada.masahiro@socionext.com>
Message-ID: <alpine.DEB.2.21.9999.1908301748400.22348@viisi.sifive.com>
References: <20190821092658.32764-1-yamada.masahiro@socionext.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Aug 2019, Masahiro Yamada wrote:

> Use the standard obj-y form to specify the sub-directories under
> arch/riscv/. No functional change intended.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks, queued for v5.4-rc1.


- Paul
