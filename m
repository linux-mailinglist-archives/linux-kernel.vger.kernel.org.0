Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1A0476F8F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 19:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfGZRLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 13:11:54 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10585 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfGZRLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 13:11:53 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d3b34610000>; Fri, 26 Jul 2019 10:12:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 26 Jul 2019 10:11:53 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 26 Jul 2019 10:11:53 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Jul
 2019 17:11:48 +0000
Subject: Re: [PATCH v2 2/7] mm/hmm: a few more C style and comment clean ups
To:     Christoph Hellwig <hch@lst.de>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <nouveau@lists.freedesktop.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
References: <20190726005650.2566-1-rcampbell@nvidia.com>
 <20190726005650.2566-3-rcampbell@nvidia.com> <20190726062320.GA22881@lst.de>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <6673dc71-f43e-849f-ca36-0b20805fc092@nvidia.com>
Date:   Fri, 26 Jul 2019 10:11:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190726062320.GA22881@lst.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564161121; bh=esO7QnCCyx9dzKTMgBFciVXyQ2aruZtdaUPoDfDZZgU=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=BtXkSUiESCykynn98aAUZOYyg4yz7jKnWyWlQeuTkJgRs1pzxbnG+tdWelFiuNWFf
         lk2A6TLLDs6cQLe2Yo2AGejt/oTzYMtS1amgKmn2dm5v84UdJRMTYaGngk6xAfFfNb
         p99GEAtPQKu0WpF74vtOAbWCO1P3EV8HcGsPjmb/CtOUwIfsJf4d4RzpBS0UZFOFl5
         mKy6fFTJpky1hLxVBJ8kIaj3ucax+hLNkEj3Rb1EYWFnVqCmhNJAyxMjR01QHESrZT
         ZRtQfwyfeh21KLwAKZ3N0lRnAXuC9Yp0RdEq+oNcbACTXWG+Ly+6gcvZF0sXLDUj4M
         vgXH0/SGBnYgA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/25/19 11:23 PM, Christoph Hellwig wrote:
> Note: it seems like you've only CCed me on patches 2-7, but not on the
> cover letter and patch 1.  I'll try to find them later, but to make Ccs
> useful they should normally cover the whole series.
> 
> Otherwise this looks fine to me:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

Thanks for the review and sorry about the oversight on CCs.
