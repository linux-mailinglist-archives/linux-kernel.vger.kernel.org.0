Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB2741542C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 21:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfEFTHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 15:07:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:36904 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725883AbfEFTHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 15:07:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F2707AD3A;
        Mon,  6 May 2019 19:07:32 +0000 (UTC)
Date:   Mon, 6 May 2019 21:07:31 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     mike.kravetz@oracle.com, shenkai8@huawei.com,
        linfeilong@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wangwang2@huawei.com,
        "Zhoukang (A)" <zhoukang7@huawei.com>,
        Mingfangsen <mingfangsen@huawei.com>, agl@us.ibm.com,
        nacc@us.ibm.com, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] mm/hugetlb: Don't put_page in lock of hugetlb_lock
Message-ID: <20190506190731.GE31017@dhcp22.suse.cz>
References: <12a693da-19c8-dd2c-ea6a-0a5dc9d2db27@huawei.com>
 <b8ade452-2d6b-0372-32c2-703644032b47@huawei.com>
 <20190506142001.GC31017@dhcp22.suse.cz>
 <d11fa51f-e976-ec33-4f5b-3b26ada64306@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d11fa51f-e976-ec33-4f5b-3b26ada64306@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06-05-19 23:22:08, Zhiqiang Liu wrote:
[...]
> Does adding Cc: stable mean adding Cc: <stable@vger.kernel.org>
> tag in the patch or Ccing stable@vger.kernel.org when sending the new mail?

The former. See Documentation/process/stable-kernel-rules.rst for more.

Thanks!
-- 
Michal Hocko
SUSE Labs
