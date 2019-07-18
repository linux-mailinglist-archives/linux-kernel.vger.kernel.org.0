Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBF76C413
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 03:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbfGRBVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 21:21:25 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44284 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbfGRBVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 21:21:25 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1529F1264D596;
        Wed, 17 Jul 2019 18:21:24 -0700 (PDT)
Date:   Wed, 17 Jul 2019 18:21:21 -0700 (PDT)
Message-Id: <20190717.182121.54176691060371062.davem@davemloft.net>
To:     torvalds@linux-foundation.org
Cc:     ldv@altlinux.org, hch@lst.de, khalid.aziz@oracle.com,
        akpm@linux-foundation.org, matorola@gmail.com,
        sparclinux@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/16] sparc64: use the generic get_user_pages_fast code
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAHk-=wgjmt2i37nn9v+nGC0m8-DdLBMEs=NC=TV-u+9XAzA61g@mail.gmail.com>
References: <CAHk-=whj_+tYSRcDsw7mDGrkmyU9tAk-a53XK271wYtDqYRzig@mail.gmail.com>
        <20190717233031.GB30369@altlinux.org>
        <CAHk-=wgjmt2i37nn9v+nGC0m8-DdLBMEs=NC=TV-u+9XAzA61g@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 17 Jul 2019 18:21:24 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jul 2019 17:17:16 -0700

> Anyway, I suspect some sparc64 person needs to delve into it.

I'll take a look at it soon if someone doesn't figure it out before
me.
