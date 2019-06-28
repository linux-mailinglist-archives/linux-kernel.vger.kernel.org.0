Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 298025A78A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2019 01:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfF1XZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 19:25:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49118 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfF1XZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 19:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Gh2oFWghIHrTNBD1izTrFr/szmDBJru7LcJZzZ60QQE=; b=AKHLtbO6XygZYXVGOGSvdmbRs8
        tP5/GyaWvQKDrfHJge2h1bLiufWgk20kBE38Q+DTV7rPATeG9rC6ta3x2vFBejKYEifKG+OOvfyoO
        A18DgC1fp76BLBKoP7VxiTzkqU6ljwgMdFYpN9csriayEV2tMKbt/daU3dxj1UfUI3jIe9d/JquU+
        EdFhoj6gPyuQQPeqoZ3obr1tBUIImUVI8cPSw9OedzYuubwg+rmv+6UgDDuGrLsjA1XB+7nxP1HWd
        PKNzfvUKtg0z47BuQsc4W7Gn5HQROvK2riVA/pwi2h5oSiVs7F2nKe0EwfPfsQxVfP1ZAUQk4q9ho
        Cta0Qjcg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hh0Er-0004Pq-8Q; Fri, 28 Jun 2019 23:25:05 +0000
Subject: Re: [PATCH] f2fs: fix 32-bit linking
To:     Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Qiuyang Sun <sunqiuyang@huawei.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Eric Biggers <ebiggers@google.com>,
        Wang Shilong <wangshilong1991@gmail.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20190628104007.2721479-1-arnd@arndb.de>
 <20190628124422.GA9888@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1d121a83-6042-fc5e-4440-ea0f53f0bc51@infradead.org>
Date:   Fri, 28 Jun 2019 16:25:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190628124422.GA9888@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/19 5:44 AM, Christoph Hellwig wrote:
> On Fri, Jun 28, 2019 at 12:39:52PM +0200, Arnd Bergmann wrote:
>> Not all architectures support get_user() with a 64-bit argument:
> 
> Which architectures are still missing?  I think we finally need to
> get everyone in line instead of repeatedly working around the lack
> of minor arch support.
> 

arch/microblaze/include/asm/uaccess.c does not support get_user()
with a size of 8.

-- 
~Randy
