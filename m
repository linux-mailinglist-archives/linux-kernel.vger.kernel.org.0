Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6274F2F7A6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 08:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfE3G5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 02:57:51 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:48610 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725862AbfE3G5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 02:57:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TT.K-Od_1559199467;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TT.K-Od_1559199467)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 30 May 2019 14:57:47 +0800
To:     Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Subject: [HELP] How to get task_struct from mm
Message-ID: <5cf71366-ba01-8ef0-3dbd-c9fec8a2b26f@linux.alibaba.com>
Date:   Thu, 30 May 2019 14:57:46 +0800
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


As what we discussed about page demotion for PMEM at LSF/MM, the 
demotion should respect to the mempolicy and allowed mems of the process 
which the page (anonymous page only for now) belongs to.


The vma that the page is mapped to can be retrieved from rmap walk 
easily, but we need know the task_struct that the vma belongs to. It 
looks there is not such API, and container_of seems not work with 
pointer member.


Any suggestion?


Thanks,

Yang

