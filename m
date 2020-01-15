Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C070813B7BA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 03:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgAOCde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 21:33:34 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:42602 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728862AbgAOCdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 21:33:32 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Tnlx2xO_1579055609;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Tnlx2xO_1579055609)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 15 Jan 2020 10:33:30 +0800
Subject: Re: [PATCH] mm/vmscan: remove prefetch_prev_lru_page
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1579006500-127143-1-git-send-email-alex.shi@linux.alibaba.com>
 <FC618797-2F5E-4F73-A244-0DC19AA1CB74@lca.pw>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <739f4470-8dfe-bb2f-8100-2134f48868b6@linux.alibaba.com>
Date:   Wed, 15 Jan 2020 10:31:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <FC618797-2F5E-4F73-A244-0DC19AA1CB74@lca.pw>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/1/14 ÏÂÎç9:46, Qian Cai Ð´µÀ:
> 
> 
>> On Jan 14, 2020, at 7:55 AM, Alex Shi <alex.shi@linux.alibaba.com> wrote:
>>
>> This macro are never used in git history. So better to remove.
> 
> When removing unused thingy, it is important to figure out which commit introduced it in the first place and Cc the relevant people in that commit.
> 

Thanks fore reminder, Qian!

This macro was introduced in 1da177e4c3f4 Linux-2.6.12-rc2, no author or commiter could be found.

Thanks
Alex
