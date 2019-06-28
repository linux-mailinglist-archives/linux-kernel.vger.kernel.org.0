Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE7ED59BE5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 14:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfF1Moa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 08:44:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56030 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfF1Moa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=E1erKLyVVkGQjctq2VcYck1y9kJsOSAmy8euXP4sxFI=; b=K44JW2sUbtwUllYjEeoBoZXKP
        qpwZG+45pz50vTBjkMikPcqCzbATh/9kKuP9xcGJ7sEAvJKU2lfOgJzOnHTk2Aw/UWrBIX93T7dJ1
        eiSULrHWNpfDAkVATmv35yKsVmni6KnNZIrI6Hk9z4XsTgLuM3pvg3LEOL+QagIwmOAXxJTDU7ElV
        WwS7ABzdVsbHMjemSHU/3TYgMiE/r80EkvLeClJAn8Vt3KhbOcBT3P7bkm+6ZiCegLvdz85iT7z9w
        gDGxVzVLpfrY7zqrCpDD/vnGqcnkR2bpLZ8SJ2ToSZ9UnMbyGk3U00+H/Z4k6UQJx9O1kyHgBs9jY
        Z36trWmBQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hgqEo-00034F-Kp; Fri, 28 Jun 2019 12:44:22 +0000
Date:   Fri, 28 Jun 2019 05:44:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Qiuyang Sun <sunqiuyang@huawei.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Eric Biggers <ebiggers@google.com>,
        Wang Shilong <wangshilong1991@gmail.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix 32-bit linking
Message-ID: <20190628124422.GA9888@infradead.org>
References: <20190628104007.2721479-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628104007.2721479-1-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 12:39:52PM +0200, Arnd Bergmann wrote:
> Not all architectures support get_user() with a 64-bit argument:

Which architectures are still missing?  I think we finally need to
get everyone in line instead of repeatedly working around the lack
of minor arch support.
