Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A74E0137A62
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jan 2020 00:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgAJXwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 18:52:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:38132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727706AbgAJXwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 18:52:16 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91F062072A;
        Fri, 10 Jan 2020 23:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578700335;
        bh=NvOUcUspxFLI01lV4A8uaAMX4Ow8pA4DdoGx2zMfWBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K5rsvDPnEAR5f21xmUvg1WTxOoWEYMaz3T4nOp8ln4/PnRUK4/QvBccKSxw5gx6F5
         KSbS8D2qzcW2V8HhqcHE4E4fU2V4WST4iFRc15NeOJdUxDkmGbzhsYrvkRgYg0zg5s
         4Pnn73nYDbl8cxLB9pOYFoZPsR8NX3+HrjDDKgns=
Date:   Fri, 10 Jan 2020 15:52:14 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [RFC PATCH v5] f2fs: support data compression
Message-ID: <20200110235214.GA25700@jaegeuk-macbookpro.roam.corp.google.com>
References: <20191216062806.112361-1-yuchao0@huawei.com>
 <20191218214619.GA20072@jaegeuk-macbookpro.roam.corp.google.com>
 <c7035795-73b3-d832-948f-deb36213ba07@huawei.com>
 <20191231004633.GA85441@jaegeuk-macbookpro.roam.corp.google.com>
 <7a579223-39d4-7e51-c361-4aa592b2500d@huawei.com>
 <20200102181832.GA1953@jaegeuk-macbookpro.roam.corp.google.com>
 <20200102190003.GA7597@jaegeuk-macbookpro.roam.corp.google.com>
 <d51f0325-6879-9aa6-f549-133b96e3eef5@huawei.com>
 <94786408-219d-c343-70f2-70a2cc68dd38@huawei.com>
 <20200106181620.GB50058@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106181620.GB50058@jaegeuk-macbookpro.roam.corp.google.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06, Jaegeuk Kim wrote:
> On 01/06, Chao Yu wrote:
> > On 2020/1/3 14:50, Chao Yu wrote:
> > > This works to me. Could you run fsstress tests on compressed root directory?
> > > It seems still there are some bugs.
> > 
> > Jaegeuk,
> > 
> > Did you mean running por_fsstress testcase?
> > 
> > Now, at least I didn't hit any problem for normal fsstress case.
> 
> Yup. por_fsstress

Please check https://github.com/jaegeuk/f2fs/commits/g-dev-test.
I've fixed
- truncation offset
- i_compressed_blocks and its lock coverage
- error handling
- etc

One another fix in f2fs-tools as well.
https://github.com/jaegeuk/f2fs-tools

> 
> > 
> > Thanks,
