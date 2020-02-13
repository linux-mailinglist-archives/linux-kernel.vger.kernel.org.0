Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2551715C91F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 18:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgBMRHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 12:07:16 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:60437 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727799AbgBMRHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 12:07:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04396;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Tpuiwn0_1581613620;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tpuiwn0_1581613620)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 14 Feb 2020 01:07:02 +0800
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Subject: [Question] Why PageReadahead is not migrated by migration code?
Message-ID: <7691ab12-2e84-2531-f27d-2fae9045576d@linux.alibaba.com>
Date:   Thu, 13 Feb 2020 09:06:58 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,


Recently we saw some PageReadahead related bugs, so I did a quick check 
about the use of PageReadahead. I just found the state is *not* migrated 
by migrate_page_states().


Since migrate_page() won't migrate writeback page, so if PageReadahead 
is set it should just mean PG_readahead rather than PG_reclaim. So, I 
didn't think of why it is not migrated.


I dig into the history a little bit, but the change in migration code is 
too overwhelming. But, it looks PG_readahead was added after migration 
was introduced. Is it just a simple omission?


Thanks,

Yang

