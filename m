Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27FAE13CF5F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 22:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbgAOVom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 16:44:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:53084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgAOVol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 16:44:41 -0500
Received: from localhost (unknown [104.132.0.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BFBE222C3;
        Wed, 15 Jan 2020 21:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579124681;
        bh=mE/mjZUev0yWvsC/cdIQQ/2Qb6eYka5CK2eFeu8pbQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X/0gVxnbzIOTvm8thhpsxDek7Zjf+LrsoK5jZp5opS37qy7ZLJqtiJMQsseDTjcE5
         7fGgDy/w+49Ywon+fjhrMt/rz8VYhjuEYaU81FBLQ5iNs4FGT4bhG0QgtlA3//YCTs
         pFRhLD9Qh0wTC42lS26hHny2Ybt+ge6g2srPddgs=
Date:   Wed, 15 Jan 2020 13:44:40 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Yuehaibing <yuehaibing@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [f2fs-dev] [PATCH -next] f2fs: remove set but not used variable
 'cs_block'
Message-ID: <20200115214440.GC57854@jaegeuk-macbookpro.roam.corp.google.com>
References: <20191224124359.15040-1-yuehaibing@huawei.com>
 <673efe18-d528-2e9b-6d44-a6a7a22086f3@huawei.com>
 <62ce1981-9061-f798-a65d-9599ceceb4b8@huawei.com>
 <20191226082419.ljbhystwkhp2d4gh@shindev.dhcp.fujisawa.hgst.com>
 <20200115023328.bummaaa7pdnao5qk@shindev.dhcp.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115023328.bummaaa7pdnao5qk@shindev.dhcp.fujisawa.hgst.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/15, Shinichiro Kawasaki wrote:
> On Dec 26, 2019 / 17:24, Shin'ichiro Kawasaki wrote:
> > On Dec 26, 2019 / 14:05, Yuehaibing wrote:
> > > On 2019/12/26 11:44, Chao Yu wrote:
> > > > On 2019/12/24 20:43, YueHaibing wrote:
> > > >> fs/f2fs/segment.c: In function fix_curseg_write_pointer:
> > > >> fs/f2fs/segment.c:4485:35: warning: variable cs_block set but not used [-Wunused-but-set-variable]
> > > >>
> > > >> It is never used since commit 362d8a920384 ("f2fs: Check
> > > >> write pointer consistency of open zones") , so remove it.
> > > > 
> > > > Thanks for the fix!
> > > > 
> > > > Do you mind merging this patch to original patch? as it's still
> > > > pending in dev branch.
> > > 
> > > It's ok for me.
> > >
> > 
> > Thank you for this catch and the fix. Appreciated.
> 
> I have merged YueHaibing's change to the write pointer consistency fix patch
> and sent out as the v6 series. Thanks again for finding out the unused variable.

I applied the fix in the original patch.

Thanks,

> 
> I was not sure if I should add Chao Yu's reviewed by tag to the patch from which
> the unused variable was removed. To be strict, I didn't add the tag. Just
> another quick review by Chao will be appreciated.
> 
> --
> Best Regards,
> Shin'ichiro Kawasaki
