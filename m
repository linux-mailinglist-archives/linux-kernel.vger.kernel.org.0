Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 042E7131758
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 19:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgAFSQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 13:16:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:56546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgAFSQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 13:16:21 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4181D2072C;
        Mon,  6 Jan 2020 18:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578334581;
        bh=fH5EwCq6AaxG0YJmz1AOmBC/ME6Sk1bbhiEMQkJniao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AtSs5ivBqHXdw6gdrjAdPCMS7A0vqxZp9kiT+HGjA5sUGpPt+F0jhro4LW0v235Vu
         QwSknE6d/4zCpF+cNlO2CYv9fDFMHFwNj+NIMhyMWDe3P2c92O2TiWtTuYcw6RCeyI
         AlkO+GqR0ktDZa75XjQi3xDU4yp6cY+GS8/xm1wM=
Date:   Mon, 6 Jan 2020 10:16:20 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [RFC PATCH v5] f2fs: support data compression
Message-ID: <20200106181620.GB50058@jaegeuk-macbookpro.roam.corp.google.com>
References: <20191216062806.112361-1-yuchao0@huawei.com>
 <20191218214619.GA20072@jaegeuk-macbookpro.roam.corp.google.com>
 <c7035795-73b3-d832-948f-deb36213ba07@huawei.com>
 <20191231004633.GA85441@jaegeuk-macbookpro.roam.corp.google.com>
 <7a579223-39d4-7e51-c361-4aa592b2500d@huawei.com>
 <20200102181832.GA1953@jaegeuk-macbookpro.roam.corp.google.com>
 <20200102190003.GA7597@jaegeuk-macbookpro.roam.corp.google.com>
 <d51f0325-6879-9aa6-f549-133b96e3eef5@huawei.com>
 <94786408-219d-c343-70f2-70a2cc68dd38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94786408-219d-c343-70f2-70a2cc68dd38@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06, Chao Yu wrote:
> On 2020/1/3 14:50, Chao Yu wrote:
> > This works to me. Could you run fsstress tests on compressed root directory?
> > It seems still there are some bugs.
> 
> Jaegeuk,
> 
> Did you mean running por_fsstress testcase?
> 
> Now, at least I didn't hit any problem for normal fsstress case.

Yup. por_fsstress

> 
> Thanks,
